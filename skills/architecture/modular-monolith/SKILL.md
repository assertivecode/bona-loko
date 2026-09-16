---
name: arch-modular-monolith
description: >-
  Establishes and guards module boundaries, public contracts, and shared kernels within a single deployable unit.
  Use when designing new modules, establishing inter-module communication, defining shared contracts, or preventing cross-boundary coupling.
---

# Modular Monolith Architecture Shell

## Purpose
Enable rapid development velocity within a unified codebase while enforcing strict boundary encapsulation, ensuring independent evolutionary pathways for each business module without premature distributed system complexity.

---

## When to Use
- When introducing a new functional module (e.g., Assessment, Priorities, Habits, Focus).
- When communicating between modules (e.g., Assessment emitting an event consumed by Priorities).
- When defining shared utilities vs. module-internal implementations.

---

## Core Boundary Rules
1. **Module Autonomy**:
   - Each module lives in its own root namespace: `src/Modules/<ModuleName>/`.
   - Internal implementations (`Domain`, `Application`, `Infrastructure`) are internal/private to the module.
2. **Public Contracts Only**:
   - Other modules may only reference public interfaces or DTOs located in `Shared/Contracts/` or a module's dedicated `Public/` contract package.
3. **No Cross-Module Database Joins**:
   - Modules must never join database tables belonging to another module.
   - Cross-module data queries occur via mediator queries or replicated read projections.
4. **Asynchronous / In-Process Events**:
   - Cross-module side-effects are decoupled using in-process domain event mediators (e.g., MediatR / Wolverine).

---

## Quality Checklist
- [ ] Module internal types not leaked to other modules.
- [ ] No direct SQL/EF joins across module schema boundaries.
- [ ] Inter-module coordination handled via explicit contracts or events.
