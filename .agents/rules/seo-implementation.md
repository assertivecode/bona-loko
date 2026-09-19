# Agent Rule: SEO, Tag Registry & Sitemap Implementation

This rule establishes mandatory **Search Engine Optimization (SEO)**, **Tri-Lingual Tag Registry Mirroring**, and **Dynamic Sitemap Validation** standards across the entire repository.

---

## 1. Tri-Lingual Tag Registry Invariant

Whenever writing, modifying, or refactoring articles in `./content/`:
1. **Approved Tags Only**: The article frontmatter `tags` array **MUST ONLY** contain tags present in the approved tag registry for that language:
   - English (`en-us`): [`content/en-us/allowed-tags.md`](file:///c:/github_accounts/assertivecode/bona-loko/content/en-us/allowed-tags.md)
   - Portuguese (`pt-br`): [`content/pt-br/tags-permitidas.md`](file:///c:/github_accounts/assertivecode/bona-loko/content/pt-br/tags-permitidas.md)
   - Esperanto (`eo`): [`content/eo/permesitaj-etikedoj.md`](file:///c:/github_accounts/assertivecode/bona-loko/content/eo/permesitaj-etikedoj.md)
2. **Mirrored Evolution**: If an article requires a new tag, that tag must be synchronously added in all three registries with appropriate localization under the correct dimension/foundation section.
3. **Format & Bounds**:
   - Strictly `kebab-case` and lowercased.
   - Normalized without diacritics or special characters for URL and indexing safety.
   - Between **3 and 6 tags** per article.
   - Every dimension article must include its canonical dimension tag (e.g. `physical-health`, `saude-fisica`, `fizika-sano`).

---

## 2. Assertive Tag Selection & Market Search Intent Criteria

To maximize organic search discoverability and ensure articles connect with users actively looking for solutions to their habit and life balance challenges, tag choices must be **assertive, market-aligned, and grounded in user search intent**:

### 2.1 Search Intent Mapping & Market Query Patterns
1. **Real-World Search Phrasing**: Tags must reflect terms that people actually type into search engines (Google, Bing, DuckDuckGo) when researching habits, challenges, or life balance.
   - 🟢 **High-Intent Search Terms**: Prefer recognized phrasing such as `sleep-hygiene`, `restorative-sleep`, `burnout-recovery`, `work-life-balance`, `deep-work`, `habit-building`.
   - ❌ **Avoid Idiosyncratic / Obscure Jargon**: Never use invented neologisms or overly academic jargon that carry zero search volume (e.g., `circadian-ontological-repair`, `temporal-habit-calculus`, `lifestyle-paradigm-alignment`).
2. **Problem-to-Solution Resonance**: Prioritize tags that naturally complete common search queries:
   - *"how to improve [tag]"*
   - *"best practices for [tag]"*
   - *"[tag] guide"* or *"tips for [tag]"*

### 2.2 The 3-Tier Tag Architecture (Cardinality: 3–6 Tags)
Every article's frontmatter `tags` array must balance broad discoverability and targeted intent using a 3-tier distribution:
- **Tier 1: Canonical Topic Anchor (1 tag)**:
  - The high-level market domain recognized across industry indexing (e.g., `physical-health`, `personal-finance`, `emotional-wellbeing`, `habit-building`).
  - *Must include the canonical dimension tag for dimension guides.*
- **Tier 2: Core Problem & Target Query (2–3 tags)**:
  - The specific challenge, subject, or practice being addressed that users actively search for (e.g., `restorative-sleep`, `circadian-rhythm`, `debt-freedom`, `stress-resilience`, `deep-work`).
- **Tier 3: Contextual Action & Habit Anchor (1–2 tags)**:
  - Action-oriented or contextual modifiers that capture long-tail search intent (e.g., `daily-routines`, `morning-routine`, `evening-routine`, `active-listening`, `mindful-spending`).

### 2.3 Cross-Lingual Search Market Equivalence
When proposing new tags to be mirrored across the tri-lingual registry:
- Do not perform rigid, literal word-for-word translations if they fail to reflect how native speakers actually search.
- Align each localized tag with the natural search habits of that linguistic market (e.g., in Portuguese, searchers look for `sono-reparador` or `higiene-do-sono` rather than a literal transcription).

---

## 3. Page & Component SEO Invariant

Whenever creating or modifying pages in `web-app/pages/` or layout wrappers:
1. **Dynamic Metadata (`useHead`)**:
   - Ensure `<title>` follows the pattern: `<Page/Article Title> — Bona Loko`.
   - Ensure `<meta name="description">` is populated from the summary or component i18n dictionary.
   - Ensure `<meta name="keywords">` and `<meta property="article:tag">` are dynamically populated with comma-separated tags.
   - Ensure OpenGraph tags (`og:title`, `og:description`, `og:type`) are injected.
2. **Semantic Structure**:
   - Maintain a single `<h1>` per page.
   - Follow strict heading hierarchy (`<h2>`, `<h3>`) without level skipping.
   - Ensure all images have descriptive, non-empty `alt` attributes.

---

## 4. Dynamic Sitemap Invariant

The application provides a dynamic XML sitemap endpoint at `web-app/server/routes/sitemap.xml.ts`:
1. **Static Routes**: Any newly created static route in `web-app/pages/` must be registered in `useLocale.ts` (`ROUTE_SLUGS`) and confirmed to be included in `web-app/server/routes/sitemap.xml.ts`.
2. **Dynamic Content**: Newly authored `.md` articles in `./content/` are automatically discovered across all 3 languages. Ensure the article includes a valid `slug` (or clean filename) and a valid `last_updated` date in `YYYY-MM-DD` format.
3. **Verification**: After adding new routes or articles, verify that `/sitemap.xml` responds with HTTP 200 and properly includes the new URLs.

---

## 5. Associated Skill

For full workflow playbooks, tag categorization, and testing commands, consult the dedicated skill:
- [`eng-seo-implementation`](file:///c:/github_accounts/assertivecode/bona-loko/.agents/skills/engineering/seo-implementation/SKILL.md)
