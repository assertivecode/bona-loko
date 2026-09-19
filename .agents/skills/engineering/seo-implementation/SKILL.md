---
name: eng-seo-implementation
description: >-
  Enforces search engine optimization (SEO) standards, tri-lingual tag registry mirroring, article frontmatter metadata, page meta tags, and dynamic sitemap synchronization across English, Portuguese, and Esperanto.
  Use when authoring or modifying articles in ./content/, creating or editing web-app pages/components, updating allowed tags registries, or maintaining sitemap.xml.
---

# SEO Standards & Implementation

## Purpose
Establishes a unified, automated, and cross-lingual SEO standard for **Bona Loko**. Guarantees that every article published across the 3 supported locales (`en-US`, `pt-BR`, `eo`), as well as every web application page, adheres to comprehensive search engine discoverability standards, synchronized tag registries, verified metadata injection, and dynamic XML sitemap generation.

---

## When to Use
- **Authoring / Editing Content**: Writing or revising articles inside `./content/en-us/`, `./content/pt-br/`, or `./content/eo/`.
- **Introducing New Tags**: Adding or modifying topic/habit tags for articles.
- **Scaffolding / Modifying Pages & Components**: Creating or changing pages in `web-app/pages/` or layout wrappers in `web-app/layouts/` or `web-app/components/`.
- **Sitemap Maintenance**: Validating that all static and dynamic localized routes are accurately reflected in `/sitemap.xml`.
- **SEO Auditing**: Verifying `<title>`, `<meta name="description">`, `<meta name="keywords">`, `<meta property="article:tag">`, canonical URLs, and heading hierarchy.

---

## Core SEO Invariants

### 1. Tri-Lingual Tag Registry Synchronization Invariant
Every tag used in an article's frontmatter `tags` array **MUST** be explicitly listed in the corresponding language's approved tags registry:
- English (`en-US`): [`content/en-us/allowed-tags.md`](file:///c:/github_accounts/assertivecode/bona-loko/content/en-us/allowed-tags.md)
- Portuguese (`pt-BR`): [`content/pt-br/tags-permitidas.md`](file:///c:/github_accounts/assertivecode/bona-loko/content/pt-br/tags-permitidas.md)
- Esperanto (`eo`): [`content/eo/permesitaj-etikedoj.md`](file:///c:/github_accounts/assertivecode/bona-loko/content/eo/permesitaj-etikedoj.md)

> [!IMPORTANT]
> **Mirrored Evolution Invariant**: When a new tag is introduced to support a new topic, habit, or concept, its translated counterpart **MUST** be added synchronously across all three files under the matching dimension/foundation section.
>
> - **Format**: Lowercased, hyphen-separated (`kebab-case`). No special characters or diacritics (ASCII/URL-safe).
> - **Cardinality**: Each article must contain between **3 and 6** approved tags.
> - **Canonical Dimension Tag**: Every dimension article must include its canonical dimension tag (e.g. `physical-health` / `saude-fisica` / `fizika-sano`) plus 2 to 5 habit/theme tags.

### 2. Assertive Tag Selection & Market Search Intent Criteria
Tag choices must align directly with terms users actually type into search engines when seeking personal development, habit formation, and life balance guidance:
- **High-Intent Market Phrasing**: Favor established, high-volume search terms (e.g., `sleep-hygiene`, `restorative-sleep`, `deep-work`, `burnout-recovery`, `work-life-balance`) over obscure academic or internal jargon (e.g., avoid `circadian-ontological-repair`, `temporal-habit-calculus`).
- **3-Tier Tag Architecture (3–6 tags per article)**:
  1. **Tier 1 (1 tag)**: Canonical Topic / Dimension Anchor (e.g., `physical-health`, `personal-finance`, `habit-building`).
  2. **Tier 2 (2–3 tags)**: Core Problem & Target Search Query (e.g., `restorative-sleep`, `circadian-rhythm`, `debt-freedom`, `stress-resilience`).
  3. **Tier 3 (1–2 tags)**: Action & Habit Modifiers (e.g., `daily-routines`, `morning-routine`, `evening-routine`, `mindful-spending`).
- **Natural Language Search Fit**: Prefer tags that seamlessly complete common search patterns like *"how to improve [tag]"*, *"best practices for [tag]"*, or *"[tag] guide"*.
- **Cross-Lingual Cultural Equivalence**: Localize mirrored tags to the natural search idiom of each target locale (e.g., `sono-reparador` in pt-BR instead of a forced literal transliteration).

### 3. Article Frontmatter Metadata Contract
Every markdown article authored in `./content/` must provide:
```yaml
---
id: <dimension_or_article_id>
title: "<Localized Title>"
slug: <localized-url-slug>
category: <vitality | prosperity | connection | environment | attention>
area_index: <1-12 or omitted for standalone articles>
last_updated: "YYYY-MM-DD"
summary: "<1-2 sentence compelling summary for search engine snippet and social previews>"
tags:
  - <canonical-dimension-tag>
  - <topic-tag-1>
  - <topic-tag-2>
  - <topic-tag-3>
---
```

### 4. Page & Component SEO Metadata Contract
Every Nuxt page (`web-app/pages/`) must configure `useHead`:
```typescript
useHead({
  title: computed(() => frontmatter.value.title ? `${frontmatter.value.title} — Bona Loko` : t('meta.title')),
  meta: [
    { name: 'description', content: computed(() => frontmatter.value.summary || t('meta.description')) },
    { name: 'keywords', content: computed(() => tags.value.join(', ')) },
    { property: 'article:tag', content: computed(() => tags.value.join(', ')) },
    { property: 'og:title', content: computed(() => frontmatter.value.title || t('meta.title')) },
    { property: 'og:description', content: computed(() => frontmatter.value.summary || t('meta.description')) },
    { property: 'og:type', content: 'article' }
  ]
})
```
- **Heading Hierarchy**: Exactly one `<h1>` per page. Subsections must follow semantic `<h2>`, `<h3>` order without skipping levels.
- **Images**: All `<img>` tags must feature descriptive, accessible `alt` text.

### 5. Dynamic XML Sitemap Synchronization Invariant
The dynamic sitemap endpoint at [`web-app/server/routes/sitemap.xml.ts`](file:///c:/github_accounts/assertivecode/bona-loko/web-app/server/routes/sitemap.xml.ts) serves `/sitemap.xml` and must automatically include:
1. **Static Routes**: All root and canonical static hubs for all 3 supported languages:
   - Home: `/`, `/pt-br`, `/eo` (priority `1.0`, `daily`)
   - About: `/about`, `/pt-br/sobre`, `/eo/pri-ni` (priority `0.8`, `weekly`)
   - Mission: `/mission`, `/pt-br/missao`, `/eo/misio` (priority `0.8`, `weekly`)
2. **Dynamic Content Articles**: Crawls `./content/` to dynamically map every `.md` article for all 3 locales:
   - English: `/dimensions/<slug>`
   - Portuguese: `/pt-br/dimensoes/<slug>`
   - Esperanto: `/eo/dimensioj/<slug>`
3. **Last-Modified (`<lastmod>`)**: Derived from the article's `last_updated` frontmatter or file `mtime`.
4. **Clean Exclusion**: Excludes non-article registries (e.g. `allowed-tags.md`, `tags-permitidas.md`, `permesitaj-etikedoj.md`).

> [!NOTE]
> When adding a new static route or modifying route definitions in `useLocale.ts`, verify that `sitemap.xml.ts` is updated to include the new static route keys. For dynamic markdown articles, no code change is required; the crawler discovers new articles automatically.

---

## Workflow Playbook

### Scenario A: Writing a New Article
1. **Assertive Tag Selection (3-Tier Distribution)**: Select 3–6 tags from the corresponding language registry using market search intent:
   - **Tier 1 (1 tag)**: Canonical Dimension / Domain anchor (e.g., `physical-health`).
   - **Tier 2 (2–3 tags)**: High-intent problem / solution query terms (e.g., `restorative-sleep`, `circadian-rhythm`).
   - **Tier 3 (1–2 tags)**: Action or context modifiers (e.g., `daily-routines`, `vitality`).
   - Registries: `content/en-us/allowed-tags.md` (EN), `content/pt-br/tags-permitidas.md` (PT), `content/eo/permesitaj-etikedoj.md` (EO).
2. **Synchronize Missing Tags**: If the article requires a new tag that does not yet exist, execute **Scenario C** first.
3. **Format Frontmatter**: Add `id`, `title`, `slug`, `last_updated`, `summary`, and the `tags` array.
4. **Verify Rendered Head**: Navigate to the rendered URL in the browser / SSR output and verify `<meta name="keywords">` and `<meta property="article:tag">`.
5. **Verify Sitemap**: Request `/sitemap.xml` and confirm the article URL is present with its correct `<lastmod>`.

### Scenario B: Creating or Modifying a Web Application Page
1. **In-Component i18n**: Ensure all meta strings (`title`, `description`, `keywords`) are provided in `en-US`, `pt-BR`, and `eo` inside the component dictionary.
2. **Call `useHead`**: Inject localized `<title>`, `<meta name="description">`, and Open Graph tags.
3. **Register Route in `useLocale.ts`**: If adding a new page, add its path mapping to `ROUTE_SLUGS`.
4. **Update `sitemap.xml.ts`**: If adding a new static route key, add it to `staticKeys` in `web-app/server/routes/sitemap.xml.ts`.

### Scenario C: Adding New Allowed Tags
1. Open all three registries simultaneously:
   - `content/en-us/allowed-tags.md`
   - `content/pt-br/tags-permitidas.md`
   - `content/eo/permesitaj-etikedoj.md`
2. Locate the appropriate Life Dimension or Platform Foundation section.
3. Add the kebab-case, URL-normalized tag in each file with appropriate localization.
4. Keep the lists alphabetical or grouped logically by habit theme.

### Scenario D: Verifying `/sitemap.xml`
1. Request `/sitemap.xml` locally via `curl` or `Invoke-WebRequest`.
2. Ensure HTTP `200 OK` with `Content-Type: application/xml; charset=utf-8`.
3. Check the total `<loc>` entry count matches the expected formula:
   $$\text{Total URLs} = (\text{Static Routes} \times 3) + (\text{Articles in en-US} + \text{pt-BR} + \text{eo})$$
4. Ensure no duplicate URLs, broken paths, or 404 targets exist.

---

## Quality Checklist

- [ ] All tags in frontmatter exist in the respective locale's registry (`allowed-tags.md` / `tags-permitidas.md` / `permesitaj-etikedoj.md`).
- [ ] Tag count per article is between 3 and 6, including the canonical dimension tag.
- [ ] Tags are formatted in kebab-case without accents or special characters.
- [ ] New tags are mirrored across all 3 language registries simultaneously.
- [ ] Article frontmatter includes `last_updated` in valid `YYYY-MM-DD` ISO format.
- [ ] Page renders `<title>`, `<meta name="description">`, and `<meta name="keywords">`.
- [ ] Semantic heading hierarchy (`<h1>` followed by `<h2>`/`<h3>`) is intact.
- [ ] `/sitemap.xml` yields HTTP 200 and lists all static routes and articles across all 3 languages.
