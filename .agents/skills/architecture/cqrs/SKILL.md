---
name: arch-cqrs
description: >-
  Guides the separation of Command (write/mutation) and Query (read/projection) responsibilities.
  Use when designing application endpoints, handlers, state mutations, aggregate root operations, or specialized read models.
---

# CQRS (Command Query Responsibility Segregation) Shell

## Purpose
Decouple data write operations (focusing on domain invariants, transactional consistency, and business validation) from data read operations (focusing on projection speed, UI view models, and querying flexibility).

---

## When to Use
- When adding a new user action that changes state (Commands: e.g., `SubmitLifeAssessment`, `DefineHabit`, `LogDistraction`).
- When fetching data for UI display (Queries: e.g., `GetLifeBalanceWheel`, `GetActiveHabitChecklist`).
- When decoupling write-side aggregate roots from read-side dashboards.

---

## Pattern Guidelines

### 1. Commands (Writes & Mutations)
- **Characteristics**: Imperative verbs, represent user intent (e.g., `CreateHabitCommand`).
- **Flow**:
  1. Input validated (fluent validation / schema checks).
  2. Handler loads Aggregate Root from repository.
  3. Aggregate Root executes domain method, enforcing invariants.
  4. Repository saves changes; Domain events dispatched.
- **Return Type**: `Result<T>` or `Result` indicating success or failure reasons.

### 2. Queries (Reads & Projections)
- **Characteristics**: Noun phrases or questions (e.g., `GetLifeAssessmentQuery`).
- **Flow**:
  1. Read-only access directly to persistence or optimized projections.
  2. Bypasses domain aggregate overhead and change tracking (`AsNoTracking()`).
  3. Returns flat DTOs tailored specifically to the requesting UI view.
- **Rule**: Queries MUST NEVER mutate system state.

---

## Quality Checklist
- [ ] Commands strictly separated from Queries.
- [ ] Queries perform zero state modifications.
- [ ] Commands route through aggregate roots to protect invariants.
