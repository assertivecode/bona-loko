# AGENTS.md - Agent Charter & Operating Manual

Welcome to **bona-loko** (Habit & Life Balance). This repository is engineered for structured pair-programming between humans and AI agents.

---

## 1. Project Domain & Context

`bona-loko` is a personal development platform focused on **Habit & Life Balance**:
- **Core Purpose**: Helping people understand where they want to invest their time and energy, identify priority gaps, and build sustainable daily behaviors.
- **Foundational Model**: 12 Life Areas with a multi-dimensional priority model:
  $$\text{Importance} \rightarrow \text{Current State} \rightarrow \text{Current Investment} \rightarrow \text{Desired Investment} \rightarrow \text{Priority}$$
- **Execution Loop**: $\text{Assess} \rightarrow \text{Prioritize} \rightarrow \text{Identify Gaps} \rightarrow \text{Define Habits} \rightarrow \text{Practice} \rightarrow \text{Reflect} \rightarrow \text{Adjust}$.
- Full vision and roadmap are maintained in [direction/VISION.md](./direction/VISION.md) and [direction/ROADMAP.md](./direction/ROADMAP.md).

---

## 2. Agent Skill Discovery & Routing

All agent skills are organized in `skills/` across 10 categories, registered via [.agents/skills.json](./.agents/skills.json).

### The Skill Selection Protocol:
Whenever receiving a prompt:
1. **Classify Intent**: Identify whether the request requires product analysis, architectural design, implementation, refactoring, or testing.
2. **Consult Catalog**: Look up matching triggers in [skills/CATALOG.md](./skills/CATALOG.md).
3. **Read Skill Guidelines**: Open the matching `SKILL.md` using `view_file` to review instructions, constraints, and checklists.
4. **Cite Skills**: Explicitly mention activated skills in your implementation plan or explanation.

---

## 3. Creating New Skills (`skill-builder`)

Whenever a new skill is requested or created:
- Follow [.agents/skills/skill-builder/SKILL.md](./.agents/skills/skill-builder/SKILL.md).
- **Mandatory Synchronization**: You MUST update all consumer and reference files:
  1. `skills/CATALOG.md` (Add new skill entry, triggers, and bundle mappings)
  2. `skills/README.md` (Update taxonomy hierarchy and counts)
  3. `.agents/skills.json` (Ensure the category directory path is registered)

---

## 4. Architectural Standards

- Architecture follows a **Modular Monolith** pattern with **CQRS** (Command Query Responsibility Segregation) as defined in:
  - [skills/architecture/modular-monolith/SKILL.md](./skills/architecture/modular-monolith/SKILL.md)
  - [skills/architecture/cqrs/SKILL.md](./skills/architecture/cqrs/SKILL.md)
  - [direction/ARCHITECTURE_VISION.md](./direction/ARCHITECTURE_VISION.md)
- Domain core remains framework-agnostic and free from external dependencies.
