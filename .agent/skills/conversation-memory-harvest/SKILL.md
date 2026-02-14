---
name: conversation-memory-harvest
description: "Analyze the **entire conversation** before deletion and determine whether there is **anything worth preserving** as a:"
metadata:
  short-description: "Analyze the **entire conversation** before deletion and determine whether there is **anything worth preserving** as a:"
---

# AI Skill: conversation_memory_harvest

## Purpose
Analyze the **entire conversation** before deletion and determine whether there is **anything worth preserving** as a:
- Rule (standards, preferences, constraints)
- Workflow (repeatable multi-step process)
- Skill (reusable AI capability)
- Improvement to an existing rule, workflow, or skill

If **nothing durable or reusable** is found, explicitly approve deletion.

---

## Non-Goals (Strict)
- Do NOT save opinions, emotions, venting, or personal commentary
- Do NOT save one-off explanations or context-specific answers
- Do NOT save transient data (dates, prices, states, negotiations)
- Do NOT invent abstractions or generalize weak signals
- Do NOT store anything unless it clearly improves future performance

---

## Input
- Full conversation transcript (system + user + assistant)

---

## Output (Choose ONE path only)

### Path A — Something Worth Saving
Produce a **proposal only**.  
Do NOT automatically write memory, rules, or skills.

```
## Conversation Memory Harvest — Proposal

### 1. What Is Worth Saving
- Type: Rule | Workflow | Skill | Improvement
- Why it is durable and reusable
- Evidence from the conversation (specific references)

### 2. Proposed Artifact
- Name:
- Category: Rule / Workflow / Skill
- Description (concise and reusable)
- When it should be applied
- When it should NOT be applied

### 3. Suggested Placement
- Existing rule/workflow/skill to update (if applicable), OR
- New artifact to create

### 4. Confidence Level
- High | Medium | Low
```

---

### Path B — Nothing Worth Saving
Return **exactly** the following and stop execution:

```
No durable rules, workflows, or skills identified. Safe to delete.
```

---

## Save Evaluation Checklist
Proceed with **Path A** only if **at least one** condition is met:
- Improves future AI output quality
- Represents a reusable pattern across projects
- Formalizes an implicit standard already in use
- Reduces repeated explanations or corrections
- Applies meaningfully in future conversations

If none apply → **Path B**

---

## Execution Order
1. Scan for repeated corrections, preferences, or structured reasoning
2. Identify patterns that generalize beyond this conversation
3. Reject context-specific, emotional, or one-off content
4. Produce **Path A or Path B only**

---

## Behavioral Constraints
- Be strict and conservative
- Prefer losing information over polluting memory
- Default to “do not save”
- Never auto-write memory or rules

---

## Intended Use
- Run immediately **before deleting a conversation**
- Acts as a final memory quality gate
- Prevents rule, workflow, and skill bloat
