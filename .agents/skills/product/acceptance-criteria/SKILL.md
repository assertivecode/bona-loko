---
name: prod-acceptance-criteria
description: >-
  Formulates testable, unambiguous acceptance criteria and verification scenarios using Gherkin syntax.
  Use when writing task specifications, defining Definition of Done, or establishing automated test scenarios.
---

# Acceptance Criteria Shell

## Purpose
Ensure every feature, task, and bug fix has clear, objective criteria that define success and serve directly as the basis for automated and manual tests.

---

## When to Use
- When authoring a task specification or defining acceptance criteria for a feature.
- When agreeing on what constitutes "Done" before beginning implementation.
- When formulating scenarios for unit, integration, or end-to-end tests.

---

## Workflow Playbook
1. **Identify Scenarios**: Formulate at least one primary happy-path scenario, one validation scenario, and one boundary/error scenario.
2. **Use Gherkin Format**:
   - **Given**: Initial context or system state.
   - **When**: Specific user or system trigger.
   - **Then**: Observable, verifiable result.
3. **Verify Testability**: Ensure every criterion can be asserted deterministically (no ambiguous statements like "must be fast" or "should look nice").

---

## Quality Checklist
- [ ] Criteria written in Given/When/Then format.
- [ ] Edge cases, validations, and boundary limits covered.
- [ ] Directly executable as integration or unit tests.
