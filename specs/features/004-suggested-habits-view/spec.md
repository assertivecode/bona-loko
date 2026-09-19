# Feature Specification: 004 - Suggested Habits Dynamic View & Frontend Integration

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-004` |
| **Status** | `Approved` |
| **Component Path** | [web-app/pages/[slug].vue](../../../web-app/pages/[slug].vue), [web-app/components/SuggestedHabitCard.vue](../../../web-app/components/SuggestedHabitCard.vue), [web-app/pages/index.vue](../../../web-app/pages/index.vue) |
| **Content Discovery** | [web-app/composables/useArticleContent.ts](../../../web-app/composables/useArticleContent.ts) |
| **Target Release** | Phase 1 (MVP) |
| **Related Specs** | [specs/domain/habit-loop.spec.md](../../domain/habit-loop.spec.md), [specs/features/002-dimension-article-view/spec.md](../002-dimension-article-view/spec.md), [specs/features/001-landing-page/spec.md](../001-landing-page/spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The User Problem
Bona Loko maintains seven rich, foundational suggested habit articles across all three platform languages (`en-US`, `pt-BR`, `eo`) within `content/` (`suggested-habits`, `habitos-sugeridos`, `sugestitaj-kutimoj`). However, the frontend currently has no links, route bindings, or showcase section for these habits. Visitors cannot discover, navigate to, or read any of the suggested habit guides from the web application.

### 1.2 Alignment with Vision & Operating Rules
- **Platform Execution Loop**: Bridges Step 3 (*Identify Gaps*) and Step 4 (*Define Habits*) directly to concrete, repeatable behaviors.
- **Habit Autonomy & Multi-Dimensional Synergy (Rule 8)**: Suggested habits stand independently on their own merits as open invitations without prerequisite ladders or single-area locks.
- **Spec-Driven Development (SDD)**: Enforces contract-first design with testable Gherkin scenarios prior to application code modifications.

---

## 2. Scope & Boundaries

### 2.1 In Scope
- [ ] **Dynamic Multi-Language Routing**:
  - English (`en-US`): `/suggested-habits/:slug` (e.g., `/suggested-habits/daily-guilt-free-micro-leisure`)
  - Portuguese (`pt-BR`): `/pt-br/habitos-sugeridos/:slug` (e.g., `/pt-br/habitos-sugeridos/microlazer-diario-sem-culpa`)
  - Esperanto (`eo`): `/eo/sugestitaj-kutimoj/:slug` (e.g., `/eo/sugestitaj-kutimoj/ciutaga-senkulpa-mikro-libertempo`)
  - Configured via `pages:extend` in `web-app/nuxt.config.ts` mapping to `web-app/pages/[slug].vue`.
- [ ] **Dynamic Article Content Discovery**:
  - Expose helper `getSuggestedHabits(locale)` in `web-app/composables/useArticleContent.ts` to retrieve and sort localized habit records.
- [ ] **Dynamic Article View Enhancements (`web-app/pages/[slug].vue`)**:
  - Detect habit collection context (`isHabit`).
  - Render habit breadcrumbs: `Home / Suggested Habits / [Habit Title]`.
  - Display habit principles in the sidebar widget.
  - Return CTA banner linking to `#suggested-habits` (`← All Suggested Habits`).
- [ ] **Reusable Habit Card Component (`web-app/components/SuggestedHabitCard.vue`)**:
  - In-component translation dictionaries (`en-US`, `pt-BR`, `eo`).
  - Displays habit emoji, title, reading time, summary, multi-dimensional tag pills, and direct "Read Habit Guide →" action link.
- [ ] **Landing Page Section (`web-app/pages/index.vue`)**:
  - Dedicated `#suggested-habits` showcase section featuring an overview and the 7 habit cards.
  - Deep links to `#suggested-habits` from Transformation Engine (Step 4) and Attention Mastery (Behavioral Bridge).
- [ ] **Global Header & Footer Links**:
  - `AppHeader.vue`: "Suggested Habits" link in desktop and mobile navigation.
  - `AppFooter.vue`: "Suggested Habits" link under platform links.

### 2.2 Out of Scope
- Interactive habit logging/check-in engine with database persistence (Phase 2).
- Streak counting and calendar check-in tracking.

---

## 3. User Flows & Interaction Journey

### 3.1 Suggested Habit Discovery Flow
```mermaid
flowchart TD
    A[Visitor on Landing Page / Header / Footer] -->|Clicks 'Suggested Habits'| B[Navigates to #suggested-habits Showcase]
    B -->|Selects Habit Card, e.g. Microlazer Diário| C[Clicks 'Ler Guia do Hábito →']
    C --> D[Nuxt navigates to /pt-br/habitos-sugeridos/microlazer-diario-sem-culpa]
    D --> E[Render [slug].vue with Habit Prose, TOC & Habit Principles]
    E -->|Language Switcher Clicked: eo| F[useLocale resolves counterpart slug ciutaga-senkulpa-mikro-libertempo]
    F --> G[Smooth transition to /eo/sugestitaj-kutimoj/ciutaga-senkulpa-mikro-libertempo]
    E -->|Clicks 'Todos os Hábitos Sugeridos'| H[Returns to /pt-br#suggested-habits]
```

---

## 4. Domain & State Modeling

### 4.1 Suggested Habit Frontmatter Schema
| Field | Type | Description | Invariant |
| :--- | :--- | :--- | :--- |
| `id` | `string` | Canonical habit identifier (e.g. `habit_daily_guilt_free_micro_leisure`) | Unique across languages |
| `title` | `string` | Localized title of the habit | Non-empty |
| `slug` | `string` | URL-safe slug | Matches file basename |
| `category` | `string` | "Suggested Habits" / "Hábitos Sugeridos" / "Sugestitaj Kutimoj" | Localized category |
| `reading_time` | `string` | Estimated reading duration (e.g. "5 min read") | Non-empty |
| `summary` | `string` | Executive introductory summary | Non-empty |
| `tags` | `string[]` | 3–6 market-aligned kebab-case tags | Validated in allowed-tags |
| `pillars` | `Array<{ emoji: string, title: string, desc: string }>` | Key principles/highlights | 3–4 items |
| `area_index` | `undefined` | Omitted per Rule 8 (Multi-Dimensional Habit Framing) | Must NOT be set |

---

## 5. Technical Contracts

### 5.1 Localized Route Registration (`nuxt.config.ts`)
```ts
pages.push(
  { name: 'habit-en', path: '/suggested-habits/:slug', file: slugFile },
  { name: 'habit-pt-br', path: '/pt-br/habitos-sugeridos/:slug', file: slugFile },
  { name: 'habit-eo', path: '/eo/sugestitaj-kutimoj/:slug', file: slugFile }
)
```

### 5.2 Helper Contract (`useArticleContent.ts`)
```ts
export function getSuggestedHabits(locale: Locale): ArticleRecord[]
```

---

## 6. UI / UX Specifications

### 6.1 Suggested Habits Showcase (`#suggested-habits`)
- Section Header:
  - Badge: `🌱 Keystone Routines` / `Hábitos de Referência` / `Ŝlosilaj Kutimoj`
  - Title: Multi-dimensional, autonomous habits
  - Subtitle: Explains habit autonomy (begin anywhere, no mandatory prerequisites)
- Responsive Grid: 3 columns on desktop, 2 on tablet, 1 on mobile
- Cards: Elevated subtle shadow, hover micro-interaction, clear typography, tag pills, read action button

### 6.2 In-Component Localization Dictionaries
All new components implement localized copy for `en-US`, `pt-BR`, and `eo`.

---

## 7. Acceptance Criteria (Gherkin Scenarios)

### Scenario 1: English Habit Navigation and Article View
```gherkin
Given the user is on the home page in English ("/")
When the user clicks the "Suggested Habits" link in the header navigation
Then the viewport scrolls to the "#suggested-habits" section
And 7 suggested habit cards are displayed with titles and summaries
When the user clicks "Read Habit Guide →" on "Daily Guilt-Free Micro-Leisure"
Then the browser navigates to "/suggested-habits/daily-guilt-free-micro-leisure"
And the page title contains "Daily Guilt-Free Micro-Leisure — Bona Loko"
And the breadcrumb displays "Home / Suggested Habits / Daily Guilt-Free Micro-Leisure"
```

### Scenario 2: Portuguese Localized Habit Flow
```gherkin
Given the user is on the Portuguese home page ("/pt-br")
When the user navigates to "#suggested-habits"
Then all habit cards display Portuguese titles and summaries
When the user clicks "Ler Guia do Hábito →" on "Microlazer Diário Sem Culpa"
Then the browser navigates to "/pt-br/habitos-sugeridos/microlazer-diario-sem-culpa"
And the breadcrumb displays "Início / Hábitos Sugeridos / Microlazer Diário Sem Culpa"
And the return button links back to "/pt-br#suggested-habits"
```

### Scenario 3: Esperanto Localized Habit Flow
```gherkin
Given the user is on the Esperanto home page ("/eo")
When the user views the "#suggested-habits" section
Then the section displays Esperanto titles and summaries
When the user clicks "Legi Gvidilon de Kutimo →" on "Ĉiutaga Senkulpa Mikro-Libertempo"
Then the browser navigates to "/eo/sugestitaj-kutimoj/ciutaga-senkulpa-mikro-libertempo"
And the breadcrumb displays "Ĉefpaĝo / Sugestitaj Kutimoj / Ĉiutaga Senkulpa Mikro-Libertempo"
```

### Scenario 4: Dynamic Language Switching on Habit Article
```gherkin
Given the user is reading "/pt-br/habitos-sugeridos/microlazer-diario-sem-culpa"
When the user opens the language switcher and selects "Esperanto"
Then the application navigates to "/eo/sugestitaj-kutimoj/ciutaga-senkulpa-mikro-libertempo"
And the content switches to Esperanto without a 404 error
```

### Scenario 5: Header and Footer Navigation Links
```gherkin
Given the user is on any page of the web application
When the user views the header navigation or footer platform links
Then a link to "Suggested Habits" (localized) is clearly present
And clicking it directs to the suggested habits section
```
