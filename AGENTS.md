# AGENTS.md - Agent Charter & Operating Manual

Welcome to **Bona Loko** (Habit & Life Balance). This repository is engineered for structured pair-programming between humans and AI agents.

---

## 1. Project Domain & Context

`Bona Loko` is a personal development platform focused on **Habit & Life Balance**:
- **Core Purpose**: Helping people understand where they want to invest their time and energy, identify priority gaps, and build sustainable daily behaviors.
- **Moral Bedrock**: 7 Core Values ($\text{Faith} \rightarrow \text{Gratitude} \rightarrow \text{Humility} \rightarrow \text{Integrity} \rightarrow \text{Respect} \rightarrow \text{Empathy} \rightarrow \text{Freedom}$) defined in [FOUNDATION.md](./FOUNDATION.md) and [specs/domain/core-values.spec.md](./specs/domain/core-values.spec.md).
- **Humility $\rightarrow$ Integrity Invariant**: Humility is permanently situated at the 3rd position directly preceding Integrity: *"True integrity naturally takes root in humility: seeing ourselves honestly and gently as we genuinely are creates the foundation for authentic alignment between our inner thoughts and outer actions."*
- **Foundational Model**: 12 Life Areas with a multi-dimensional priority model:
  $$\text{Current Priority} \rightarrow \text{Current State} \rightarrow \text{Current Investment} \rightarrow \text{Desired Investment} \rightarrow \text{Priority Gap}$$
- **Execution Loop**: $\text{Assess} \rightarrow \text{Prioritize} \rightarrow \text{Identify Gaps} \rightarrow \text{Define Habits} \rightarrow \text{Practice} \rightarrow \text{Reflect} \rightarrow \text{Adjust}$.
- Full vision and roadmap are maintained in [direction/VISION.md](./direction/VISION.md) and [direction/ROADMAP.md](./direction/ROADMAP.md).

---

## 2. Agent Skill Discovery & Routing

All agent skills are centralized in [`.agents/skills/`](./.agents/skills/) across 10 categories, registered via [.agents/skills.json](./.agents/skills.json).

### The Skill Selection Protocol:
Whenever receiving a prompt:
1. **Classify Intent**: Identify whether the request requires product analysis, architectural design, implementation, refactoring, or testing.
2. **Consult Catalog**: Look up matching triggers in [.agents/skills/CATALOG.md](./.agents/skills/CATALOG.md).
3. **Read Skill Guidelines**: Open the matching `SKILL.md` using `view_file` to review instructions, constraints, and checklists.
4. **Cite Skills**: Explicitly mention activated skills in your implementation plan or explanation.

---

## 3. Spec-Driven Development (SDD)

All engineering work follows the mandatory **Spec-Driven Development Rule** defined in [.agents/rules/spec-driven-development.md](./.agents/rules/spec-driven-development.md).

- **Spec-First Invariant**: Never author or modify application code for new features or altered domain logic without an approved living specification in [`specs/`](./specs/).
- **3-Tier Hierarchy**:
  1. Strategic Intent -> [`direction/`](./direction/)
  2. Domain Invariants & Formulas -> [`specs/domain/`](./specs/domain/)
  3. Feature Living Specs & Scenarios -> [`specs/features/`](./specs/features/)
- **Acceptance Verification**: Every task completion must verify compliance against the Gherkin scenarios defined in the corresponding specification.

---

## 4. Creating New Skills (`skill-builder`)

Whenever a new skill is requested or created:
- Follow [.agents/skills/skill-builder/SKILL.md](./.agents/skills/skill-builder/SKILL.md).
- **Mandatory Synchronization**: You MUST update all consumer and reference files:
  1. `.agents/skills/CATALOG.md` (Add new skill entry, triggers, and bundle mappings)
  2. `.agents/skills/README.md` (Update taxonomy hierarchy and counts)
  3. `.agents/skills.json` (Ensure the category directory path is registered)

---

## 5. Architectural Standards

- Architecture follows a **Modular Monolith** pattern with **CQRS** (Command Query Responsibility Segregation) as defined in:
  - [.agents/skills/architecture/modular-monolith/SKILL.md](./.agents/skills/architecture/modular-monolith/SKILL.md)
  - [.agents/skills/architecture/cqrs/SKILL.md](./.agents/skills/architecture/cqrs/SKILL.md)
  - [direction/ARCHITECTURE_VISION.md](./direction/ARCHITECTURE_VISION.md)
- Domain core remains framework-agnostic and free from external dependencies.

---

## 6. Content & Tone Invariant: Self-Contained Purpose (No Platform Comparisons)

All documentation, articles, marketing copy, specifications, and UI strings follow the mandatory rule defined in [.agents/rules/no-platform-comparisons.md](./.agents/rules/no-platform-comparisons.md).
- **Comparing to others is NOT a platform purpose**: Bona Loko stands entirely on its own merits, foundational values, and intentional design.
- **Zero App Comparisons**: Never write copy contrasting Bona Loko with "traditional apps", "simplistic surveys", "conventional habit trackers", or external products.
- **Affirmative Presentation**: Describe all features, models, and philosophies self-containedly and constructively.

---

## 7. Platform Core Values Invariant

All features, UI copy, and agent suggestions must strictly embody the **7 Core Values** governed by [.agents/rules/platform-core-values.md](./.agents/rules/platform-core-values.md):
- **Preserve the Order**: $\text{Faith} \rightarrow \text{Gratitude} \rightarrow \text{Humility} \rightarrow \text{Integrity} \rightarrow \text{Respect} \rightarrow \text{Empathy} \rightarrow \text{Freedom}$.
- **The Humility $\rightarrow$ Integrity Principle**: Humility occupies the 3rd position directly preceding Integrity (#4). True integrity naturally takes root in humility: seeing ourselves honestly and gently as we genuinely are creates the foundation for authentic alignment between our inner thoughts and outer actions.

---

## 8. Tone & Communication Invariant: Respectful, Non-Prescriptive Teachings (No Inferences of Incapacity)

All documentation, articles, marketing copy, specifications, and UI strings follow the mandatory rule defined in [.agents/rules/humble-non-prescriptive-tone.md](./.agents/rules/humble-non-prescriptive-tone.md):
- **Never infer or decree what someone can or cannot do**: Avoid prescriptive negations such as *"You cannot act with...", "One cannot...", "It is impossible for you to...",* or *"Unless you first possess X, you cannot Y"*.
- **Teach with humility and invitation**: Frame wisdom affirmatively, respectfully, and gently, emphasizing how virtues and habits support and nurture human flourishing without gatekeeping or judging personal capability.

---

## 9. Vocabulary Invariant: Growth-Focused Language (No Default Religious/Sanctity Vocabulary)

All documentation, articles, marketing copy, specifications, and UI strings follow the mandatory rule defined in [.agents/rules/secular-growth-tone.md](./.agents/rules/secular-growth-tone.md):
- **Default-avoid religious/sanctity vocabulary**: Words like *sanctuary, sacred, holy, sabbath, blessing, prayer, sanctity, devotion, spiritual, divine* should not be used as default vocabulary in general personal-growth content. Prefer grounded alternatives (e.g., haven, cherished, renewal, gift, dedication, inner).
- **Context-appropriate exceptions**: Religious/sanctity vocabulary is acceptable when the content subject genuinely requires it (e.g., faith-related articles, religious traditions, or user-requested religious topics).
- **Growth framing**: Language should frame becoming a better person as an intentional, daily human practice — step by step, day by day.

---

## 10. SEO, Tag Registry & Sitemap Invariant

All articles, web application pages, and route definitions follow the mandatory rule defined in [.agents/rules/seo-implementation.md](./.agents/rules/seo-implementation.md) and the operational procedures in [.agents/skills/engineering/seo-implementation/SKILL.md](./.agents/skills/engineering/seo-implementation/SKILL.md):
- **Tri-Lingual Tag Registry Synchronization**: Every tag used in an article's frontmatter `tags` array must exist in the approved tag registry of that locale ([`content/en-us/allowed-tags.md`](./content/en-us/allowed-tags.md), [`content/pt-br/tags-permitidas.md`](./content/pt-br/tags-permitidas.md), [`content/eo/permesitaj-etikedoj.md`](./content/eo/permesitaj-etikedoj.md)). When adding new tags, mirror their translations across all three registries simultaneously.
- **Article Metadata & Tags**: Each article must feature 3–6 kebab-case tags (including its canonical dimension tag), a descriptive `summary`, valid `slug`, and ISO `last_updated`.
- **Page Head Metadata**: Every web application page must inject localized `<title>`, `<meta name="description">`, `<meta name="keywords">`, `<meta property="article:tag">`, and OpenGraph metadata via `useHead`.
- **Dynamic Sitemap Accuracy**: Verify that `/sitemap.xml` dynamically reflects all static hubs across the 3 languages and automatically crawls all markdown content across `en-US`, `pt-BR`, and `eo`.


