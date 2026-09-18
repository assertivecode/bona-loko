# Agent Skill Orchestration Rule

This rule governs how the agent selects, retrieves, and applies skills across the project lifecycle.

## Objective
Ensure that whenever a user sends a prompt, the agent systematically identifies and activates the relevant skills from `.agents/skills/` before formulating implementation plans or writing code.

---

## 2-Pass Skill Resolution Protocol

Whenever analyzing a user request (especially in planning mode or during implementation), follow this 2-pass resolution process:

### Pass 1: Lifecycle & Domain Classification
Analyze the incoming request against three core axes:

1. **Lifecycle Phase**:
   - *Problem discovery / Business requirements* -> Consult `.agents/skills/product/` (`requirements-analysis`, `feature-design`, `acceptance-criteria`).
   - *Architecture & system structure* -> Consult `.agents/skills/architecture/` (`modular-monolith`, `cqrs`, etc.).
   - *Coding & delivery* -> Consult `.agents/skills/engineering/` (`implementation`, `skill-builder`, etc.).
   - *Quality assurance* -> Consult `.agents/skills/quality/` (testing strategy, unit tests, etc.).
   - *Security, DevOps, SRE, Data* -> Consult respective categories once expanded.

2. **Domain & Feature Context**:
   - Cross-reference [direction/VISION.md](../../direction/VISION.md) and [direction/ROADMAP.md](../../direction/ROADMAP.md) to understand which of the 12 life areas or core engine capabilities (Life Assessment, Priority Management, Habits, Focus/Distraction, Reflection) are touched.

3. **Technical Stack**:
   - Check if changes involve backend (Modular Monolith, CQRS, C# .NET, EF Core) or frontend (Nuxt, TypeScript) or data storage (PostgreSQL).

---

### Pass 2: Skill Activation & Context Loading

1. **Consult the Skill Matrix**: Check [.agents/skills/CATALOG.md](../skills/CATALOG.md) for matching triggers and recommended bundles.
2. **Explicit Skill Loading**: Use `view_file` to read the `SKILL.md` of each matching skill.
3. **Execution Compliance**: Follow the execution playbooks and checklists specified in the activated skills.
4. **Transparent Citation**: In implementation plans and task updates, clearly state which skills were activated for the task.

---

## Skill Creation Synchronization

- When a new skill is added or requested, activate the `meta-skill-builder` skill ([.agents/skills/skill-builder/SKILL.md](../skills/skill-builder/SKILL.md)) to update all referencing files.

