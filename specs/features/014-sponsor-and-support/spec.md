# Feature Specification: 014 - GitHub Sponsorship, Web & Mobile Support Hub

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-014` |
| **Status** | `Implemented` |
| **Component Path** | `web-app/pages/sponsor.vue`, `web-app/components/AppHeader.vue`, `web-app/components/AppFooter.vue`, `mobile/habit-builder/lib/presentation/profile/`, `mobile/habit-builder/lib/l10n/` |
| **Target Release** | Community Stewardship & Unconditional Sponsorship Support |
| **Related Specs** | [FOUNDATION.md](../../../FOUNDATION.md) (Rule 4: Incorruptibility & Unconditional Anonymous Donations), [specs/domain/core-values.spec.md](../../domain/core-values.spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The User Problem
1. **Uncompromised Ethical Independence**: Bona Loko is an open-source personal development platform with a strict moral constitution ([FOUNDATION.md](../../../FOUNDATION.md)):
   - Categorically barred from commercial advertising, behavioral monetization, selling personal data, and political or governmental funding.
   - Grounded in 7 Core Values (Faith ➔ Gratitude ➔ Humility ➔ Integrity ➔ Respect ➔ Empathy ➔ Freedom).
2. **Operational Sustainability via Voluntary Patronage**: Maintaining mobile app store distributions (Apple Developer, Google Play), serverless infrastructure, continuous trilingual content (English, Portuguese, Esperanto), and active software engineering requires sustainable resources without compromising sovereignty.
3. **Absence of Dedicated In-App & Web Sponsorship Gateways**: Supporters who resonate with the mission and want to champion independent, ethical open-source software lack clear, transparent avenues in both the web and mobile applications to sponsor the creator (`assertivecode`) via GitHub Sponsors.

### 1.2 The Solution
1. **GitHub Sponsor Profile Assets**:
   - Provide a compelling short bio and rich introduction story for the GitHub Sponsors account emphasizing Bona Loko's open-source stewardship, habit & life balance mission, moral foundation, and unconditional giving principles.
2. **Web Application Support Hub (`/sponsor`, `/pt-br/apoiar`, `/eo/subteni`)**:
   - Implement a dedicated Nuxt 3 page with in-component translations across `en-US`, `pt-BR`, and `eo`.
   - Adhere to Rule 4 from the Moral Constitution (Rule of Incorruptibility & Unconditional Giving).
   - Display transparent usage of funds, sponsorship tiers, and direct CTAs to `https://github.com/sponsors/assertivecode`.
   - Integrate links in `AppHeader.vue` and `AppFooter.vue`.
3. **Mobile Application Sponsor Screen (`SponsorScreen`)**:
   - Dedicated Flutter screen inside `mobile/habit-builder/lib/presentation/profile/sponsor_screen.dart`.
   - Accessible from `ProfileScreen` via an inviting tile (`profile_sponsor_tile`).
   - Localized across English, Portuguese, and Esperanto (`app_en.arb`, `app_pt.arb`, `app_eo.arb`).
   - Action button (`sponsor_github_button`) launching `https://github.com/sponsors/assertivecode` externally.

---

## 2. Inviolable Governance Principles (Rule 4 Alignment)

Under Rule 4 of [FOUNDATION.md](../../../FOUNDATION.md):
- **Zero Quid-Pro-Quo**: Contributions confer zero editorial influence, algorithmic favoritism, or commercial endorsements.
- **Unconditional Support**: Sponsorship is treated as an unconditional gift supporting free, accessible software for humanity.
- **Zero Commercial Perks or Transactional Promises**: Sponsorship plans never promise deliverables, features, commercial rewards, or tiered perks. Descriptions express warm, non-prescriptive gratitude for voluntary stewardship.
- **Standardized Tier Taxonomy**:
  1. `Friendly Supporter` ($5 / mo or one-time)
  2. `Mindful Steward` ($15 / mo or one-time)
  3. `Open Source Guardian` ($50 / mo or one-time)
  4. `Platform Hero` ($100+ / mo or one-time)
- **Clear Pre-Clearance**: Visitors are affirmatively reminded of these ethical guardrails before donating.

---

## 3. Localization & URL Contracts

### 3.1 Web Canonical Slugs
| Language | Route | Slug |
| :--- | :--- | :--- |
| **English (US)** | `/sponsor` | `sponsor` |
| **Portuguese (Brazil)** | `/pt-br/apoiar` | `apoiar` |
| **Esperanto** | `/eo/subteni` | `subteni` |

### 3.2 External Sponsor URL
- Canonical GitHub Sponsors URL: `https://github.com/sponsors/assertivecode`

---

## 4. Acceptance Criteria (Gherkin Scenarios)

### Scenario 1: Web Sponsorship Hub Renders with In-Component Translations
```gherkin
Given a user visits the sponsorship page on the web application
When the user accesses `/sponsor` (or `/pt-br/apoiar`, or `/eo/subteni`)
Then the page renders the hero section, the inviolable guardrails explanation, fund allocation transparency, and sponsor tiers
And all visible copy is localized according to the active locale
And the browser tab title and meta tags dynamically match the active language via useHead
And the primary action button opens `https://github.com/sponsors/assertivecode` in a new tab.
```

### Scenario 2: Web Navigation Header & Footer Inclusion
```gherkin
Given any page on the web application
When the user views the header or footer
Then a localized link to the Sponsor page is present
And clicking the link routes to the corresponding localized path without hardcoded non-default URLs.
```

### Scenario 3: Mobile Profile Screen Provides Entry to Sponsor Screen
```gherkin
Given a user navigates to ProfileScreen on mobile
When the user scrolls through the settings options
Then a "Support & Sponsor" tile with key `profile_sponsor_tile` is visible
And tapping the tile navigates to the dedicated `SponsorScreen`.
```

### Scenario 4: Mobile Sponsor Screen Renders and Launches GitHub Sponsors
```gherkin
Given a user is on `SponsorScreen` on mobile
When the screen loads
Then the core ethical pillars (Ad-free & Privacy-first, Independent & Uncorruptible, Trilingual & Open Source) are displayed
And the disclaimer clarifying unconditional sponsorship (Rule 4) is present
And tapping the button with key `sponsor_github_button` opens `https://github.com/sponsors/assertivecode` in the external browser.
```

### Scenario 5: Assertive Code Open Source Initiative Links Across Web and Mobile
```gherkin
Given a user viewing the web header, web footer, or mobile ProfileScreen
When the user inspects the bottom of the screen or header brand bar
Then a localized link to "Assertive Code Open Source Initiative" is visible
And tapping the link opens `https://assertivecode.com/#portfolio` in the external browser.
```

