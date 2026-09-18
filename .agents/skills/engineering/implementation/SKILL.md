---
name: eng-implementation
description: >-
  Directs writing clean, idiomatic, SOLID-compliant code and domain models.
  Use when generating code, implementing business logic, writing services, handlers, or refactoring existing modules.
---

# Implementation Standards Shell

## Purpose
Enforce production-grade engineering standards, maintainability, and clean code principles across all layers of the codebase.

---

## When to Use
- Writing new commands, queries, handlers, entities, or value objects.
- Implementing UI components, state stores, or client-side utilities.
- Refactoring existing implementations for better clarity and separation of concerns.

---

## Core Engineering Principles
1. **SOLID Principles**:
   - Single Responsibility: Each class or module does exactly one job well.
   - Open/Closed: Extensible via abstractions without modifying proven core logic.
   - Liskov Substitution & Interface Segregation: Keep contracts small and cohesive.
   - Dependency Inversion: Depend upon abstractions, not concrete implementations.
2. **Explicit Domain Modeling**:
   - Favor rich domain models over anemic data bags.
   - Encapsulate invariants inside entity constructors or factory methods.
   - Use Value Objects for concepts with no independent identity (e.g., Rating, TimeInvestment, LifeAreaId).
3. **Defensive Coding & Immutability**:
   - Validate arguments at the system boundaries.
   - Prefer immutable records and read-only collections where possible.

---

## Quality Checklist
- [ ] No direct ORM/framework leakage into domain entities.
- [ ] Meaningful variable and function names matching ubiquitous domain language.
- [ ] Invariants enforced with clear domain exceptions or Result objects.
- [ ] System logic, logs, and error messaging honor user privacy, compassionate feedback, and the 7 Core Values ([.agents/rules/platform-core-values.md](../../rules/platform-core-values.md)).
