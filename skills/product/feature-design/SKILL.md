---
name: prod-feature-design
description: >-
  Translates business requirements into detailed user flows, state machines, wireframe outlines, and API contracts.
  Use when designing the structure, interaction model, and technical specifications of a feature before coding.
---

# Feature Design Shell

## Purpose
Bridge the gap between raw business requirements and concrete code implementation by designing intuitive user experiences, system state transitions, and component contracts.

---

## When to Use
- When planning how a user navigates through a feature (e.g., Life Assessment questionnaire, habit creation wizard).
- When modeling entity state transitions (e.g., habit statuses: draft, active, paused, archived).
- When defining API input/output models and UI component hierarchies.

---

## Workflow Playbook
1. **User Flow Mapping**: Define the sequence of steps a user takes from entry to completion.
2. **State Modeling**: Identify possible entity states, valid transitions, and forbidden operations.
3. **Data Contract Design**: Outline the input payload (Commands) and output view models (Queries).
4. **UI/UX Wireframe Concepts**: Specify layout sections, visual feedback (progress indicators, charts), and error states.

---

## Quality Checklist
- [ ] Happy path and failure recovery flows documented.
- [ ] State transitions enforce domain rules.
- [ ] Contracts align with CQRS and Modular Monolith boundaries.
