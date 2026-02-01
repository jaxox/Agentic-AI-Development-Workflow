
# Skill: JavaScript Refactoring Architect

## Purpose
To modernize legacy JavaScript codebases by effectively migrating ES5 to ES6+, decomposing monolithic functions, and implementing async/await patterns while ensuring zero regressions.

## Inputs
- Legacy JavaScript source file(s)
- Associated unit tests (if available)

## Output
- Refactored Source Code (ES6+, Modular, Async)
- Updated Unit Tests
- `artifacts/refactoring-report.md`: A summary of changes, complexity reduction, and verification results.

## Responsibilities
- **Modernization**: Convert ES5 `var` to `let/const`, function expressions to arrow functions, string concat to template literals.
- **Decomposition**: Identify and extract monolithic functions (cyclomatic complexity > 10, lines > 50) into pure helper functions.
- **Async Patterning**: Migrate callback hell or raw Promises to `async/await` with mandatory `try/catch` blocks.
- **Verification**: Adhere strictly to the "Verify or Rollback" Golden Rule.
- **Safety**: Use AST analysis to preserve variable scope and closures.

## Forbidden
- **Breaking Tests**: Committing any code that causes `npm test` to fail.
- **Logic Alteration**: Changing the runtime behavior/business logic of the application (refactoring must be semantic-preserving).
- **Blind Transformation**: Applying regex-based replacements without AST awareness (risk of scope issues).
- **Execution of Arbitrary Commands**: Running unverified shell commands outside of the allowed protocol.

## Workflow

### 1. Analysis & Baseline
- **Baseline**: Run `npm test <filename>` to establish a passing baseline. If tests fail initially, ABORT or fix specific known issues first.
- **Complexity Check**: Run `scripts/analyze_complexity.py` to identify hot spots (CC > 10).
- **Scope Analysis**: Identify variable hoisting and closure dependencies.

### 2. Transformation
- **Automated Codemods**: Use `refactor-old-js-architect/scripts/run_codemod.sh` (wraps `jscodeshift` or similar) for deterministic ES5->ES6 updates.
- **Manual Pattern Application**:
    - **Monoliths**: Extract logic blocks into standalone functions.
    - **Async**: `util.promisify` legacy callbacks, then await them.

### 3. Verification
- **Run Tests**: Execute `npm test <filename>`.
- **Golden Rule**:
    - **PASS**: Commit changes.
    - **FAIL**: Attempt ONE fix. If it still fails, `git checkout <filename>` (Revert).

## Checklist
- [ ] **Baseline Established**: Tests passed before any editing.
- [ ] **Complexity Sized**: Analyzed target functions for complexity.
- [ ] **Variables Scoped**: Verified `var` -> `let/const` safety.
- [ ] **Codemods Applied**: Ran automated transformations.
- [ ] **Async Safety**: Wrapped all `await` calls in `try/catch`.
- [ ] **Loops Modernized**: Replaced `forEach` with `for...of` where appropriate.
- [ ] **Verified**: Tests passed after changes.
