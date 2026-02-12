---
name: manage_context
description: Tools and instructions for initializing and updating the `CONTEXT.md` file to preserve project knowledge.
---

# Manage Context Skill

This skill helps you maintain a `CONTEXT.md` file in the root of the project. This file serves as the project's long-term memory, preserving architectural decisions, debugging findings, and experiment results across different AI sessions.

## 1. Initialization
**Trigger:** User asks to "start a new project", "initialize context", or "setup knowledge base".

**Steps:**
1.  Check if `CONTEXT.md` already exists in the project root.
2.  If it exists, inform the user and ask if they want to update it instead.
3.  If it does not exist, create it using the template below.
4.  Ask the user for a brief "Project Overview" and "Current Status" to fill in the initial details.

### Template
```markdown
# Project Context & Knowledge Base

> **Usage:** Update this file at the end of every significant work session. It serves as the "long-term memory" for the project. When starting a new AI conversation, paste these contents or ask the AI to read this file first.

## 1. Project Overview
**Goal:** [Brief 1-sentence description of what the project does]
**Current Status:** [e.g., v0.1 - Project initialized]

## 2. Active Focus (The "Now")
*What are we currently working on?*
- [ ] [First major task]

## 3. Key Architectural Decisions (ADRs)
*Why is the code built this way?*
- **[Date] [Topic]:** [Decision]. *Reasoning: [Why].*

## 4. Experimentation Log & Findings
*Crucial for R&D/Algorithm work.*

| Experiment / Hypothesis | Status | Outcome / Result |
| :--- | :--- | :--- |
| *[Experiment Name]* | *[Status]* | *[Outcome]* |

## 5. Debugging Journal (Known "Gotchas")
*Weird errors we've solved before.*
- **Issue:** [Error message]
  - **Cause:** [Root cause]
  - **Fix:** [Solution]

## 6. Technical Debt & TODOs
- [ ] [Item 1]
```

## 2. Update Context
**Trigger:** User asks to "update context", "save progress", or "end session". Also, you should proactively suggest this after solving a complex bug or completing a major feature.

**Steps:**
1.  Read the current `CONTEXT.md`.
2.  Review your conversation history and tools execution to identify:
    *   **Completed Tasks:** Move items in "Active Focus" to completed or remove them.
    *   **New Decisions:** Did you decide on a library? A pattern? Add to "ADRs".
    *   **Experiments:** Did you try something that failed? Add to "Experimentation Log".
    *   **Bugs:** Did you solve a tricky error? Add to "Debugging Journal".
3.  Draft the updates and present them to the user for confirmation (using a `diff` block or summary).
4.  Write the updated content to `CONTEXT.md`.

## 3. Best Practices (Internal Monologue)
*   **Be Concise:** The context file is for *you* (the future AI). Write in a way that is easy for an LLM to parse.
*   **Don't Duplicate:** If it's already in the code comments, you might not need it here, UNLESS it's a high-level decision (ADR).
*   **Capture Failures:** Failed experiments are *more* important than successes in the long run to prevent loops.
