# Agentic Skills Architecture

This directory houses the modular knowledge packages ("skills") that guide AI agents and developers throughout the engineering lifecycle of **Habit & Life Balance** (**Bona Loko**).

---

## 1. Skill Organization & Taxonomy

All agent skills are centralized under `.agents/skills/` across 10 specialized categories plus agent meta-tooling:

```text
.agents/skills/
├── product/              <-- Requirements analysis, feature specs, acceptance criteria
├── engineering/          <-- Implementation standards, refactoring, debugging, code-review
├── architecture/         <-- Modular monolith, CQRS, DDD, distributed patterns
├── quality/              <-- Testing strategies, unit/integration/e2e/performance tests
├── security/             <-- Secure coding, threat modeling, auth & authorization
├── devops/               <-- CI/CD, containers, deployments, infrastructure as code
├── sre/                  <-- Observability, incident runbooks, SLOs, resilience
├── data/                 <-- Data modeling, migrations, data quality
├── capabilities/         <-- Multi-tenancy, auditing, payments, notifications
├── technology/           <-- .NET, ASP.NET Core, EF Core, Nuxt, TypeScript, Postgres, etc.
└── skill-builder/        <-- Meta-skill for authoring and synchronizing skills
```

---

## 2. Currently Active Shell Skills

| Category | Skill Directory | Skill Identifier | Purpose |
| :--- | :--- | :--- | :--- |
| **Product** | [product/requirements-analysis](./product/requirements-analysis/SKILL.md) | `prod-requirements-analysis` | Elicits user needs, edge cases, domain invariants, and non-functional requirements. |
| **Product** | [product/feature-design](./product/feature-design/SKILL.md) | `prod-feature-design` | Designs user flows, state machines, API contracts, and UX specs. |
| **Product** | [product/acceptance-criteria](./product/acceptance-criteria/SKILL.md) | `prod-acceptance-criteria` | Formulates executable Gherkin scenarios and verification checklists. |
| **Engineering** | [engineering/implementation](./engineering/implementation/SKILL.md) | `eng-implementation` | Directs writing clean, idiomatic, SOLID-compliant code. |
| **Engineering** | [engineering/seo-implementation](./engineering/seo-implementation/SKILL.md) | `eng-seo-implementation` | Governs SEO standards, tri-lingual tag registries, metadata injection, and dynamic sitemap generation. |
| **Architecture**| [architecture/modular-monolith](./architecture/modular-monolith/SKILL.md) | `arch-modular-monolith` | Governs module boundaries, shared kernels, and in-process contracts. |
| **Architecture**| [architecture/cqrs](./architecture/cqrs/SKILL.md) | `arch-cqrs` | Governs Command/Query segregation, handlers, Aggregate Roots, and projections. |
| **Technology**  | [technology/nuxt-development](./technology/nuxt-development/SKILL.md) | `tech-nuxt-development` | Governs Nuxt 3 development, in-component translations (en-US, pt-BR, eo), and frontend UI patterns. |
| **Meta (Agent)**| [skill-builder](./skill-builder/SKILL.md) | `meta-skill-builder` | Automates adding new skills and synchronizing all consuming and referencing files. |

---

## 3. How the Agent Selects Skills

1. Skill directories are registered in [.agents/skills.json](../skills.json).
2. The agent executes the **2-Pass Resolution Protocol** defined in [.agents/rules/skill-orchestration.md](../rules/skill-orchestration.md).
3. The agent cross-references [CATALOG.md](./CATALOG.md) to discover matching triggers, keywords, and synergistic bundles.

---

## 4. Expanding the Skill Suite

To add a new skill to any category, prompt the agent:
> *"Create a new skill for `<skill-name>` under `<category>`"*

The agent will activate `meta-skill-builder` ([skill-builder/SKILL.md](./skill-builder/SKILL.md)), scaffolding the directory, drafting standard sections, and synchronizing [CATALOG.md](./CATALOG.md), [README.md](./README.md), and [.agents/skills.json](../skills.json).

