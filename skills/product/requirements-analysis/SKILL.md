---
name: prod-requirements-analysis
description: >-
  Elicits, clarifies, and formalizes functional and non-functional requirements from user prompts.
  Use when analyzing new feature requests, defining domain invariants, identifying edge cases, or clarifying ambiguous business requirements.
---

# Requirements Analysis Shell

## Purpose
Guide the agent and developer in breaking down vague or high-level business ideas into structured, unambiguous requirements before writing technical designs or code.

---

## When to Use
- When the user asks for a new capability or feature.
- When an existing feature has ambiguous requirements or edge cases.
- When evaluating impacts on the 12 Life Areas or the Habit & Life Balance priority model.

---

## Workflow Playbook
1. **Identify the Core Objective**: What problem does this solve for the person seeking life balance?
2. **Determine In-Scope vs. Out-of-Scope**: Explicitly bound what will and will not be built.
3. **Map to Domain Hierarchy**:
   - Which of the 12 Life Areas does this touch?
   - Does it affect Priorities, Goals, Habits, or Reflections?
4. **Identify Edge Cases & Invariants**:
   - Negative inputs, boundary conditions, rate/frequency limits.
5. **Output**: Produce a concise problem statement and requirements list.

---

## Quality Checklist
- [ ] User persona and goal clearly identified.
- [ ] Non-functional constraints captured (latency, privacy, mobile responsiveness).
- [ ] Invariants and edge cases documented.
