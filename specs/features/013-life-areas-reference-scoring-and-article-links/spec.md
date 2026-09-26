# Feature Specification: 013 - Life Areas Scoring Reference Guides & Article Links

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-013` |
| **Status** | `Approved` |
| **Component Path** | `mobile/habit-builder`, `content/` |
| **Target Release** | Life Areas Self-Assessment Guidance & Grounded Educational Synergy |
| **Related Specs** | [specs/domain/12-life-areas.spec.md](../../domain/12-life-areas.spec.md), [specs/features/005-mobile-life-areas-evaluation/spec.md](../005-mobile-life-areas-evaluation/spec.md), [specs/features/011-mobile-onboarding-expectations-alignment/spec.md](../011-mobile-onboarding-expectations-alignment/spec.md), [specs/features/012-mobile-suggested-habits-selection-and-home-sync/spec.md](../012-mobile-suggested-habits-selection-and-home-sync/spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The User Problem
When users assess their 12 Life Areas in Bona Loko (both during initial onboarding and periodic re-evaluations):
1. **Subjective Ambiguity**: Users often struggle to know what a score (e.g., 3, 6, 10) actually represents in concrete daily practice. Without clear reference anchors, individuals may either severely under-evaluate or overestimate their condition.
2. **Risk of Perfectionism / Self-Condemnation**: Without explicit contextual framing, users might treat examples as rigid universal scorecards or feel guilty about not meeting an arbitrary benchmark.
3. **Disconnection from Deep Educational Content**: While rich, authoritative web articles exist for each of the 12 Life Areas across English, Portuguese, and Esperanto, mobile users during assessment lack a direct path to explore the philosophical foundations, pillars, and transformation steps of each area.

### 1.2 The Solution
1. **Scoring Reference Guides Across Web Articles**:
   - Add a standardized, non-prescriptive **Self-Assessment & Scoring Reference Guide (1–10)** to all 12 Life Area articles across English (`content/en-us/life-areas/`), Portuguese (`content/pt-br/areas-da-vida/`), and Esperanto (`content/eo/viv-areoj/`).
   - Define concrete, grounded daily rhythm examples for Score 3 (Initial / Occasional), Score 6 (Consistent / Mindful), and Score 10 (Flourishing / Integrated).
   - Prominently remind the reader: *"These benchmarks are illustrative personal references, not absolute metrics. Compare your condition solely to your own past and personal values across different seasons of life."*
2. **Mobile Life Area Evaluation Integration (`LifeAreaEvaluationCard`)**:
   - Present a dedicated **Scoring Reference Guide** component for the currently active life area, detailing the 3 reference tiers (Score 3, 6, 10) with localized text.
   - Include the gentle, non-prescriptive disclaimer honoring platform values (Humility before Integrity, zero gatekeeping, personal self-comparison).
   - Provide a direct link/button (`Key('read_life_area_article_button_${lifeArea.key}')`) redirecting the user to the web article for that specific life area in their active language (`en`, `pt-BR`, `eo`).

---

## 2. Ubiquitous Language & Scoring Tiers

| Tier Anchor | Meaning & Life Rhythm | Core Principle |
| :--- | :--- | :--- |
| **Score 3 / 10** | **Initial / Occasional / Developing**: Sporadic, reactive actions; emerging awareness without established routines. | *Humility*: Seeing reality honestly without judgment. |
| **Score 6 / 10** | **Consistent / Regular / Mindful**: Steady rhythmic practice; conscious boundaries and intentional effort. | *Integrity*: Aligning daily actions with personal priorities. |
| **Score 10 / 10** | **Flourishing / Deeply Integrated / Exemplary**: Harmonious integration into daily living; deep peace, vitality, or joyful service. | *Freedom & Generativity*: Living in unforced, sustainable balance. |

---

## 3. Localization & Web URL Contracts

### 3.1 Web Article Canonical Paths
- **English**: `https://bonaloko.com/life-areas/{slug}`
- **Portuguese**: `https://bonaloko.com/pt-br/areas-da-vida/{slug}`
- **Esperanto**: `https://bonaloko.com/eo/viv-areoj/{slug}`

### 3.2 12 Life Area Slugs

| Life Area | English Slug | Portuguese Slug | Esperanto Slug |
| :--- | :--- | :--- | :--- |
| `healthFitness` (1) | `health-and-physical-fitness` | `saude-e-condicionamento-fisico` | `sano-kaj-fizika-taugeco` |
| `emotionalWellbeing` (2) | `mental-and-emotional-wellbeing` | `bem-estar-mental-e-emocional` | `mensa-kaj-emocia-bonfarto` |
| `personalGrowth` (3) | `personal-growth-and-learning` | `crescimento-pessoal-e-aprendizado` | `persona-kresko-kaj-lernado` |
| `careerCalling` (4) | `career-and-professional-calling` | `carreira-e-vocacao-profissional` | `kariero-kaj-profesia-vokigo` |
| `financesWealth` (5) | `finances-and-wealth` | `financas-e-prosperidade` | `financoj-kaj-rico` |
| `relationshipsIntimacy` (6) | `relationships-and-intimacy` | `relacionamentos-e-intimidade` | `rilatoj-kaj-intimeco` |
| `familyParenting` (7) | `family-and-parenting` | `familia-e-parentalidade` | `familio-kaj-gepatreco` |
| `friendshipsCommunity` (8) | `friendships-and-community` | `amizades-e-comunidade` | `amikecoj-kaj-komunumo` |
| `physicalEnvironment` (9) | `physical-environment-and-spaces` | `ambiente-fisico-e-espacos` | `fizika-medio-kaj-spacoj` |
| `recreationPlay` (10) | `recreation-hobbies-and-play` | `recreacao-hobbies-e-lazer` | `distrado-satokupoj-kaj-ludo` |
| `focusMastery` (11) | `focus-and-attention-mastery` | `dominio-do-foco-e-atencao` | `majstreco-pri-atento-kaj-fokuso` |
| `contributionLegacy` (12) | `contribution-and-legacy` | `contribuicao-e-legado` | `kontribuo-kaj-heredajo` |

---

## 4. Acceptance Criteria (Gherkin Scenarios)

### Scenario 1: Web Articles Include Non-Prescriptive Scoring Reference Guides
```gherkin
Given any of the 12 Life Area web articles in English, Portuguese, or Esperanto
When the reader navigates to the assessment guidance section
Then a scoring reference table detailing anchors 3, 6, and 10 is displayed
And a prominent disclaimer clarifies that benchmarks are personal reflective references rather than absolute metrics
And the language respects platform tone invariants (no superiority, no gatekeeping, secular growth vocabulary).
```

### Scenario 2: Mobile Evaluation Screen Renders Scoring Reference Guide
```gherkin
Given a user evaluating a life area in AssessmentWizardScreen or AssessedLifeAreasScreen
When the LifeAreaEvaluationCard is rendered
Then the user sees the "Scoring Reference Guide" section for that specific life area
And anchor descriptions for 3, 6, and 10 are visible
And the disclaimer reminding that these are personal references is displayed
And all texts are translated according to the user's selected language (en, pt-BR, eo).
```

### Scenario 3: Launching External Life Area Article from Mobile Evaluation
```gherkin
Given a user viewing the LifeAreaEvaluationCard for any life area
When the user taps the "Read Life Area Guide" button
Then the external browser is invoked with the canonical URL for that life area matching the user's active language
And the button has the key `read_life_area_article_button_${lifeArea.key}`.
```
