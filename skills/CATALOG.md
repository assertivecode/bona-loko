# Master Skills Catalog & Synergy Matrix

This catalog serves as the primary routing index for AI agents and developers to quickly match user requests to the appropriate skills.

---

## 1. Active Skill Registry

| Skill ID | Category | Relative Path | Trigger Keywords & Cues |
| :--- | :--- | :--- | :--- |
| `prod-requirements-analysis` | `product` | [product/requirements-analysis/SKILL.md](./product/requirements-analysis/SKILL.md) | requirements, user needs, domain invariants, edge cases, scope, problem definition |
| `prod-feature-design` | `product` | [product/feature-design/SKILL.md](./product/feature-design/SKILL.md) | feature spec, user flows, state machine, UX, wireframe, interaction design |
| `prod-acceptance-criteria` | `product` | [product/acceptance-criteria/SKILL.md](./product/acceptance-criteria/SKILL.md) | acceptance criteria, gherkin, given when then, verification checklist, scenario |
| `eng-implementation` | `engineering` | [engineering/implementation/SKILL.md](./engineering/implementation/SKILL.md) | implement, write code, build, function, class, refactor, clean code, SOLID |
| `arch-modular-monolith` | `architecture` | [architecture/modular-monolith/SKILL.md](./architecture/modular-monolith/SKILL.md) | module, modular monolith, boundary, shared kernel, in-process contract, encapsulation |
| `arch-cqrs` | `architecture` | [architecture/cqrs/SKILL.md](./architecture/cqrs/SKILL.md) | cqrs, command, query, handler, aggregate root, projection, mediatr, event |
| `tech-nuxt-development` | `technology` | [technology/nuxt-development/SKILL.md](./technology/nuxt-development/SKILL.md) | nuxt, vue, i18n, translations, multi-language, pages, components, frontend |
| `meta-skill-builder` | `meta (agent)` | [.agents/skills/skill-builder/SKILL.md](../.agents/skills/skill-builder/SKILL.md) | create skill, new skill, add skill, scaffold skill, register skill, update catalog |

---

## 2. Standard Synergy Bundles

When tackling complex user requests, activate synergistic skill bundles:

### 🧩 Bundle A: Product Feature Specification
*Use when starting a new user story or feature concept.*
- `prod-requirements-analysis` (Extract domain requirements and edge cases)
- `prod-feature-design` (Model user flows and states)
- `prod-acceptance-criteria` (Write testable Gherkin scenarios)

### 🏗️ Bundle B: Backend Domain & CQRS Implementation
*Use when building a new business feature or API endpoint.*
- `arch-modular-monolith` (Ensure module isolation and contract clarity)
- `arch-cqrs` (Structure into Command/Handler or Query/Handler)
- `eng-implementation` (Write clean, production-grade domain logic)

### ⚡ Bundle C: Skill Authoring & Evolution
*Use when user asks to create or expand a skill in the project.*
- `meta-skill-builder` (Scaffolds skill and synchronizes catalog, readme, and json configs)

---

## 3. Planned Skills Runway (To Be Built via `meta-skill-builder`)

The following skills can be created on-demand as the project evolves:
- **Quality**: `testing-strategy`, `unit-testing`, `integration-testing`, `e2e-testing`, `performance-testing`
- **Security**: `secure-coding`, `threat-modeling`, `authentication`, `authorization`
- **DevOps / SRE**: `ci-cd`, `deployment`, `containers`, `observability`, `resilience`
- **Technology**: `dotnet`, `aspnet-core`, `entity-framework`, `nuxt`, `typescript`, `postgresql`, `redis`, `docker`
- **Capabilities**: `multi-tenancy`, `notifications`, `auditing`
