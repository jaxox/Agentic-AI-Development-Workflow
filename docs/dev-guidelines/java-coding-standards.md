# Java Coding Standards

**Scope:** General Java projects (backend services, APIs, batch jobs, and libraries)  
**Version:** 1.0.0  
**Last Updated:** 2026-02-13

## Overview

This document defines baseline Java coding standards for maintainable, testable, and production-grade code.

Use this as a shared default across repositories. Project-specific conventions can extend this file, but should not weaken these standards.

## Core Principles

1. Readability first. Code is read more than it is written.
2. Consistency over preference. Follow established patterns.
3. SOLID design where it improves maintainability.
4. Testability by design. Separate pure logic from side effects.
5. Immutability by default for value objects and DTOs.
6. Framework-first development. Prefer proven platform/framework features over custom infrastructure code.

## Framework-First Development

### Rule

Before writing custom infrastructure logic, check the following in order:

1. Java standard library / JDK capabilities
2. Your project framework (for example Spring, Micronaut, Quarkus, Jakarta EE)
3. Mature third-party libraries
4. Custom implementation (only if no suitable option exists)

### Use Existing Platform Features

Prefer framework-native features for common concerns:

- Retry and backoff
- Caching
- Async execution
- Scheduling
- Validation
- HTTP client behavior
- Events / pub-sub abstractions

Example (Spring, optional):

```java
@Service
@RequiredArgsConstructor
public class PaymentService {

    @Retryable(retryFor = ExternalServiceException.class, maxAttempts = 3)
    public PaymentResult capture(String paymentId) {
        return gateway.capture(paymentId);
    }

    @Recover
    public PaymentResult recover(ExternalServiceException ex, String paymentId) {
        return PaymentResult.failed(paymentId);
    }
}
```

Avoid hand-rolled loops and thread pools unless requirements cannot be met with framework support.

### Decision Guide

```
Need to implement a feature?
|
|- JDK already provides it? ---------> yes: use JDK
|- Framework provides it? ----------> yes: use framework
|- Mature library provides it? -----> yes: use library
`- none of the above ----------------> implement custom with rationale + tests
```

### Custom Code Is Acceptable When

- No suitable framework/library option exists
- Domain-specific behavior is unique to the business
- Performance constraints require specialized implementation

When custom code is chosen, document why existing options were not selected.

## Lombok Usage Guidelines

Lombok is optional. If used, keep usage predictable and conservative.

### Entities (JPA/Hibernate)

Use mutable annotations required by persistence frameworks.

```java
@Entity
@Table(name = "orders")
@Getter
@Setter
@NoArgsConstructor
public class Order {
    @Id
    private UUID id;

    @Column(nullable = false)
    private String status;
}
```

Do not use `@Data` on entities.

### DTOs and Value Objects

Use `@Builder` for objects with multiple optional fields.

```java
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class OrderResponse {
    private UUID id;
    private String status;
    private Instant createdAt;
}
```

### Records (Java 17+)

Prefer records for simple immutable data carriers.

```java
public record CustomerTokenPayload(String email, String subject, String name) {}
```

Use builders with records only when defaults/complex construction are needed.

### Services

Use constructor injection.

```java
@Service
@RequiredArgsConstructor
public class OrderService {
    private final OrderRepository orderRepository;
    private final Clock clock;
}
```

Avoid field injection.

### Utility Classes

Prefer static-only utility classes with private constructors.

```java
public final class SlugUtils {
    private SlugUtils() {
        throw new UnsupportedOperationException("Utility class");
    }

    public static String toSlug(String input) {
        return input.toLowerCase(Locale.ROOT).replace(" ", "-");
    }
}
```

## Builder Pattern Best Practices

Use `@Builder` (or manual builders) when:

- Class has 3+ fields
- Construction has optional/default fields
- Readable named construction improves clarity
- Building test fixtures

Avoid builders when:

- Object is simple (1-2 fields)
- Type is a mutable entity managed by ORM
- Constructor validation is strict and straightforward

Builder defaults example:

```java
@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class SearchCriteria {
    @Builder.Default
    private int pageSize = 50;

    private String query;
}
```

## Lombok Anti-Patterns

### Avoid `@Data` on Entities

`@Data` generates `equals`/`hashCode` across all fields, which can conflict with ORM proxy behavior.

### Avoid `@Builder` on Entities

Entity lifecycle is controlled by ORM; builders often hide invalid or partial state.

## Naming Conventions

### Classes

- Services: `*Service`
- Repositories: `*Repository`
- Controllers/Handlers: `*Controller` or `*Handler`
- DTOs: `*Request`, `*Response`, or `*Dto` (pick one style per repo)
- Exceptions: `*Exception`
- Enums: singular noun

### Methods

- Boolean methods: `isX`, `hasX`, `canX`
- Factories: `create`, `from`, `of`
- Conversion methods: `toX`, `asX`

### Constants

- `UPPER_SNAKE_CASE` for `static final` constants
- Prefer enums over string constants for bounded sets

## Imports and Type Names

Always import classes explicitly; avoid inline fully qualified names in signatures.

Good:

```java
import java.util.List;
import java.util.UUID;

public List<OrderResponse> getOrders(UUID customerId) {
    // ...
}
```

Bad:

```java
public java.util.List<com.example.api.OrderResponse> getOrders(java.util.UUID customerId) {
    // ...
}
```

Import order:

1. Java/Jakarta (`java.*`, `javax.*`, `jakarta.*`)
2. Third-party libraries
3. Project imports

## Code Organization

### Package Structure

Organize by feature/domain first, then by technical layer.

```text
com.example.app
|- order
|  |- controller
|  |- service
|  |- repository
|  |- model
|  `- dto
|- customer
|- config
`- common
```

### Class Layout

1. Constants
2. Dependencies (constructor-injected fields)
3. Public API methods
4. Private helpers

## Exception Handling

Use typed exceptions and stable error codes for boundary layers (API, messaging, jobs).

```java
public enum ErrorCode {
    ORDER_NOT_FOUND,
    PAYMENT_CAPTURE_FAILED
}

public class DomainException extends RuntimeException {
    private final ErrorCode code;

    public DomainException(ErrorCode code, String message) {
        super(message);
        this.code = code;
    }

    public ErrorCode getCode() {
        return code;
    }
}
```

Do not swallow exceptions. Log with actionable context and rethrow/translate appropriately.

## Validation Standards

Use Bean Validation annotations (`@NotNull`, `@NotBlank`, `@Size`, etc.) instead of ad-hoc manual checks.

- Use `@Valid` for nested object graph validation.
- Use framework method validation support (`@Validated` in Spring, equivalent in other frameworks) for parameter and return constraints.

## Testing Standards

### Baseline Requirements

Before merging:

1. Run relevant tests before changes and note baseline failures if any.
2. Run full impacted test scope after changes.
3. Confirm no new regressions.
4. Add or update tests for all new business behavior.

### Minimum Expectations by Change Type

- Pure domain logic: unit tests
- Persistence changes: repository/integration tests
- API contract changes: controller/integration tests
- Serialization/deserialization changes: contract or mapping tests

### Test Data Builders

Use fixture builders/factories to keep tests readable and avoid brittle setup duplication.

```java
public final class TestFixtures {
    private TestFixtures() {}

    public static OrderResponse.OrderResponseBuilder defaultOrderResponse() {
        return OrderResponse.builder()
            .id(UUID.randomUUID())
            .status("PENDING")
            .createdAt(Instant.now());
    }
}
```

## Merge Readiness Checklist

Before opening or merging a PR, verify:

- [ ] Code follows naming/import/organization rules
- [ ] No custom infrastructure code where framework support exists
- [ ] No Lombok anti-patterns on persistence entities
- [ ] New or changed behavior has tests
- [ ] No new test regressions
- [ ] Exceptions are typed and mapped consistently

## References

- [Java Language Specification](https://docs.oracle.com/javase/specs/)
- [Project Lombok](https://projectlombok.org/features/)
- [Jakarta Bean Validation](https://beanvalidation.org/)
- [Spring Boot Reference (if Spring-based)](https://docs.spring.io/spring-boot/reference/)
