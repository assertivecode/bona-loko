# Agentic Skills Architecture

This directory houses the modular knowledge packages ("skills") that guide AI agents and developers throughout the engineering lifecycle of **Habit & Life Balance** (`bona-loko`).

---

## 1. Skill Organization & Taxonomy

Skills are organized into 10 specialized categories:

```text
skills/
├── product/              <-- Requirements analysis, feature specs, acceptance criteria
├── engineering/          <-- Implementation standards, refactoring, debugging, code-review
├── architecture/         <-- Modular monolith, CQRS, DDD, distributed patterns
├── quality/              <-- Testing strategies, unit/integration/e2e/performance tests
├── security/             <-- Secure coding, threat modeling, auth & authorization
├── devops/               <-- CI/CD, containers, deployments, infrastructure as code
├── sre/                  <-- Observability, incident runbooks, SLOs, resilience
├── data/                 <-- Data modeling, migrations, data quality
├── capabilities/         <-- Multi-tenancy, auditing, payments, notifications
└── technology/           <-- .NET, ASP.NET Core, EF Core, Nuxt, TypeScript, Postgres, etc.
```

> **Note**: Repository meta-tooling and agent administration skills reside in [.agents/skills/](../.agents/skills/) (such as `meta-skill-builder`) to preserve strict separation between platform product code and agent infrastructure.

---

## 2. Currently Active Shell Skills

| Category | Skill Directory | Skill Identifier | Purpose |
| :--- | :--- | :--- | :--- |
| **Product** | [product/requirements-analysis](./product/requirements-analysis/SKILL.md) | `prod-requirements-analysis` | Elicits user needs, edge cases, domain invariants, and non-functional requirements. |
| **Product** | [product/feature-design](./product/feature-design/SKILL.md) | `prod-feature-design` | Designs user flows, state machines, API contracts, and UX specs. |
| **Product** | [product/acceptance-criteria](./product/acceptance-criteria/SKILL.md) | `prod-acceptance-criteria` | Formulates executable Gherkin scenarios and verification checklists. |
| **Engineering** | [engineering/implementation](./engineering/implementation/SKILL.md) | `eng-implementation` | Directs writing clean, idiomatic, SOLID-compliant code. |
| **Architecture**| [architecture/modular-monolith](./architecture/modular-monolith/SKILL.md) | `arch-modular-monolith` | Governs module boundaries, shared kernels, and in-process contracts. |
| **Architecture**| [architecture/cqrs](./architecture/cqrs/SKILL.md) | `arch-cqrs` | Governs Command/Query segregation, handlers, Aggregate Roots, and projections. |
| **Meta (Agent)**| [.agents/skills/skill-builder](../.agents/skills/skill-builder/SKILL.md) | `meta-skill-builder` | Automates adding new skills and synchronizing all consuming and referencing files. |

---

## 3. How the Agent Selects Skills

1. All skill directories are dynamically registered in [.agents/skills.json](../.agents/skills.json).
2. The agent executes the **2-Pass Resolution Protocol** defined in [.agents/rules/skill-orchestration.md](../.agents/rules/skill-orchestration.md).
3. The agent cross-references [skills/CATALOG.md](./CATALOG.md) to discover matching triggers, keywords, and synergistic bundles.

---

## 4. Expanding the Skill Suite

To add a new skill to any category, prompt the agent:
> *"Create a new skill for `<skill-name>` under `<category>`"*

The agent will activate `meta-skill-builder` ([.agents/skills/skill-builder/SKILL.md](../.agents/skills/skill-builder/SKILL.md)), scaffolding the directory, drafting standard sections, and synchronizing `skills/CATALOG.md`, `skills/README.md`, and `.agents/skills.json`.
