# Feature Specification: 002 - Dimension Article Dynamic View

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-002` |
| **Status** | `Approved` |
| **Component Path** | [web-app/pages/[slug].vue](../../../web-app/pages/[slug].vue) |
| **Content Discovery** | [web-app/composables/useArticleContent.ts](../../../web-app/composables/useArticleContent.ts) |
| **Target Release** | Phase 1 (MVP) |
| **Related Specs** | [specs/domain/12-life-areas.spec.md](../../domain/12-life-areas.spec.md), [specs/features/001-landing-page/spec.md](../001-landing-page/spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The User Problem
As Bona Loko expands to cover all **12 Life Areas** across 3 languages (`en-US`, `pt-BR`, `eo`), authoring a dedicated `.vue` file per article introduces massive code duplication (~1,300 lines of template/CSS/parsing logic per file, totaling over 15,000 redundant lines). Authors and engineers need a **dynamic content architecture** where dropping markdown files into `./content/{locale}/...` automatically makes them accessible at their respective translated URLs without writing or maintaining any new Vue page components.

### 1.2 Alignment with Vision
Directly powers the educational and foundational knowledge layer for all 12 life areas defined in [specs/domain/12-life-areas.spec.md](../../domain/12-life-areas.spec.md) and [direction/VISION.md](../../../direction/VISION.md). It provides a scalable, zero-overhead publishing pipeline for rich philosophical and practical dimension guides.

---

## 2. Scope & Boundaries

### 2.1 In Scope
- [ ] **Unified Dynamic Template**: A single Vue page component (`web-app/pages/[slug].vue`) that renders any life area dimension article dynamically based on the active route slug and language.
- [ ] **Automated Content Discovery**:
  - Vite `import.meta.glob` scans all markdown files in `content/**/*.md`.
  - Parses frontmatter (`id`, `title`, `slug`, `category`, `area_index`, `last_updated`, `summary`, `pillars`).
  - Automatically indexes articles by locale, slug, and canonical article `id`.
- [ ] **Dynamic Multi-Language Routing**:
  - English (`en-US`): `/dimensions/:slug` (e.g. `/dimensions/health-and-physical-fitness`)
  - Portuguese (`pt-BR`): `/pt-br/dimensoes/:slug` (e.g. `/pt-br/dimensoes/saude-e-condicionamento-fisico`)
  - Esperanto (`eo`): `/eo/dimensioj/:slug` (e.g. `/eo/dimensioj/sano-kaj-fizika-taugeco`)
  - Localized route patterns registered dynamically in `nuxt.config.ts` via `pages:extend` pointing to `web-app/pages/[slug].vue`.
- [ ] **Dynamic Language Switching**:
  - `useLocale.ts` (`getEquivalentPathForLocale`) dynamically resolves corresponding translated slugs using shared frontmatter `id`.
  - Switching languages while reading an article smoothly transitions to that article's translated slug.
- [ ] **Data-Driven Chrome & Widgets**:
  - Interactive Table of Contents (TOC) generated from headings.
  - Pillars / Key Highlights widget dynamically populated from frontmatter data.
  - Safe 404 handling when a requested slug does not exist.
- [ ] **Retained High-Fidelity Rendering**:
  - Full support for GFM tables, blockquotes, ASCII architecture diagrams, LaTeX math banners, and copy link action.

### 2.2 Out of Scope
- Headless CMS or remote database storage (content remains version-controlled Git markdown).
- Multi-user editorial workflows or in-browser WYSIWYG editing.

---

## 3. User Flows & Interaction Journey

### 3.1 Dynamic Content Resolution Flow
```mermaid
flowchart TD
    A[Visitor visits URL, e.g. /pt-br/dimensoes/saude-e-condicionamento-fisico] --> B[Nuxt matches dynamic route :slug]
    B --> C[useArticleContent looks up article by slug & locale]
    C -->|Article Found| D[Extract frontmatter, TOC & body]
    C -->|Article Not Found| E[Nuxt throw createError 404]
    D --> F[Render [slug].vue with chrome & prose]
    F --> G{Language Switcher Clicked}
    G -->|Target: eo| H[Find counterpart slug sano-kaj-fizika-taugeco by shared id]
    H --> I[Navigate to /eo/dimensioj/sano-kaj-fizika-taugeco]
```

1. **Route Match**: Nuxt matches the incoming URL against the dynamic route pattern (`/dimensions/:slug`, `/pt-br/dimensoes/:slug`, or `/eo/dimensioj/:slug`).
2. **Article Resolution**: `useArticleContent` finds the markdown module matching the slug and locale.
3. **Render**: The single `[slug].vue` component parses frontmatter, extracts headings for the TOC, and formats the markdown body.
4. **Cross-Language Navigation**: Switching locale resolves the sibling translation via shared `id: health_fitness` and redirects to the appropriate translated slug.

---

## 4. Domain & State Modeling

### 4.1 Dimension Article Frontmatter Schema
| Field | Type | Description |
| :--- | :--- | :--- |
| `id` | `string` | Canonical area identifier across all languages (e.g., `health_fitness`) |
| `title` | `string` | Human-readable title of the dimension |
| `slug` | `string` | Localized URL slug for the dimension |
| `category` | `string` | Life category grouping (e.g., `vitality`) |
| `area_index` | `number` | Index 1..12 according to taxonomy |
| `last_updated` | `string` | ISO 8601 date string (`YYYY-MM-DD`) |
| `summary` | `string` | Executive introductory summary |
| `pillars` | `Array<{ emoji: string, title: string, desc: string }>` | Optional list of pillars/highlights for the sidebar widget |

### 4.2 Content Registry State (`useArticleContent`)
- `articlesById`: `Record<string, Record<Locale, ArticleData>>`
- `articlesBySlug`: `Record<Locale, Record<string, ArticleData>>`

---

## 5. Technical Contracts

### 5.1 Route Pattern Contract (`nuxt.config.ts`)
```ts
const slugPage = pages.find(p => p.path === '/:slug')
if (slugPage) {
  pages.push(
    { name: 'dimension-en', path: '/dimensions/:slug', file: slugPage.file },
    { name: 'dimension-pt-br', path: '/pt-br/dimensoes/:slug', file: slugPage.file },
    { name: 'dimension-eo', path: '/eo/dimensioj/:slug', file: slugPage.file }
  )
}
```

### 5.2 Dynamic Locale Resolution Contract (`useLocale.ts`)
```ts
// Resolves canonical route key OR dynamic article ID to localized URL
localePath('health_fitness') // => '/dimensions/health-and-physical-fitness' in en-US
                             // => '/pt-br/dimensoes/saude-e-condicionamento-fisico' in pt-BR
                             // => '/eo/dimensioj/sano-kaj-fizika-taugeco' in eo
```

---

## 6. UI / UX Specifications

### 6.1 Layout Hierarchy
1. **Breadcrumb & Category Bar**: Back link (`← All Life Areas`), category pill (`Vitality`), reading time indicator (~8 min read).
2. **Hero Header**: Article Title, Tagline Quote, Executive Summary Card, and Last Updated date.
3. **Article Grid**:
   - **Main Article Content (Col 8/12)**:
     - Formatted typography (`prose` styles): headers with anchor links, styled blockquotes with decorative borders, GFM tables with subtle cell zebra striping, monospace preformatted diagram boxes with horizontal scroll capability.
   - **Sticky Sidebar (Col 4/12)**:
     - Table of Contents with active heading highlight.
     - Quick Reference Card: 4 Pillars summary, Core Values alignment badges.
4. **Article Footer**:
   - Navigation links: Back to Life Areas, Explore Core Values (`/mission`), Foundation link.

### 6.2 Responsive Behavior
- **Desktop (>= 1024px)**: Dual column (Article Content + Sticky Table of Contents).
- **Tablet & Mobile (< 1024px)**: Single column with collapsible Table of Contents accordion at the top of the article.

---

## 7. Acceptance Criteria (Gherkin Scenarios)

### Scenario 1: English Route Happy Path
```gherkin
Given the user navigates to "http://localhost:3000/dimensions/health-and-physical-fitness"
When the page loads
Then the page title in the browser tab should be "Health & Physical Fitness — Bona Loko"
And the article headline should display "Health & Physical Fitness: The Biological Foundation of Living Well"
And the summary card should display the summary from "content/en-us/dimensions/health-and-physical-fitness.md"
And all 8 numbered sections should be rendered with proper HTML heading structure
```

### Scenario 2: Tables and Diagrams Rendering
```gherkin
Given the article page is rendered
When the user views Section 2 ("The Four Pillars of Physical Vitality")
Then the ASCII pillar architecture diagram is rendered in a styled preformatted block
And when the user views Section 3 ("The Multi-Dimensional Priority Model in Health")
Then the 5-dimension evaluation table is rendered as an HTML table with header and cell styling
And the mathematical formula "Current Priority -> Current State..." is legibly formatted
```

### Scenario 3: Localized Portuguese Route
```gherkin
Given the user navigates to "http://localhost:3000/pt-br/dimensoes/saude-e-condicionamento-fisico"
When the page loads
Then the active locale is detected as "pt-BR"
And the article title displays "Saúde & Condicionamento Físico: O Santuário Biológico do Bem-Viver"
And all page chrome (breadcrumbs, TOC title, reading time label) is displayed in Portuguese
```

### Scenario 4: Localized Esperanto Route
```gherkin
Given the user navigates to "http://localhost:3000/eo/dimensioj/sano-kaj-fizika-taugeco"
When the page loads
Then the active locale is detected as "eo"
And the article title displays "Sano & Fizika Taŭgeco: La Biologia Sanktejo de Bonfarta Vivo"
And all page chrome is displayed in Esperanto
```

### Scenario 5: Dynamic Locale Switching
```gherkin
Given the user is on "/dimensions/health-and-physical-fitness" in English
When the user clicks the language selector in the header and selects "Português"
Then the application transitions to "/pt-br/dimensoes/saude-e-condicionamento-fisico"
And the content switches to Portuguese without full page reload
```

### Scenario 6: Table of Contents Jump Navigation
```gherkin
Given the user is viewing the article
When the user clicks "4. Distraction Inventory & Attention Leaks" in the Table of Contents
Then the viewport smoothly scrolls to Section 4
And the URL hash updates to "#distraction-inventory--attention-leaks"
```

### Scenario 7: Unknown Slug 404 Handling
```gherkin
Given the user navigates to "/dimensions/unknown-dimension-slug"
When the route resolution executes
Then Nuxt renders a 404 error page with status code 404
And indicates that the dimension article was not found
```

### Scenario 8: Extensibility Without New Vue Components
```gherkin
Given a new markdown file is added to "content/en-us/dimensions/career-and-calling.md"
And its counterpart "content/pt-br/dimensoes/carreira-e-vocacao.md" is added
When a user navigates to "/dimensions/career-and-calling"
Then the unified "[slug].vue" template renders the new article dynamically without creating a new Vue file
And navigating to "/pt-br/dimensoes/carreira-e-vocacao" renders the Portuguese version
```
