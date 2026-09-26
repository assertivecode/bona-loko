# Feature Specification: 011 - Mobile Onboarding Expectations Alignment

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-011` |
| **Status** | `Approved` |
| **Component Path** | `mobile/habit-builder` |
| **Target Release** | Mobile Onboarding & Mindset Grounding |
| **Related Specs** | [specs/features/005-mobile-life-areas-evaluation/spec.md](../005-mobile-life-areas-evaluation/spec.md), [specs/features/010-mobile-device-locale-auto-detection/spec.md](../010-mobile-device-locale-auto-detection/spec.md), [specs/domain/core-values.spec.md](../../domain/core-values.spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The User Problem
When first installing personal growth and habit applications, users frequently arrive with expectations conditioned by high-pressure, rapid-output productivity apps. If users expect immediate, rapid-fire streaks or hyper-speed fixes, they may experience premature frustration and burnout.

Bona Loko is intentionally architected around an unhurried, multi-dimensional philosophy of life balance, grounded in faith that small changes compound into lasting growth when given the proper time to mature.

### 1.2 The Solution
Introduce an **Expectations Alignment Screen** (`ExpectationsAlignmentScreen`) into the first-run onboarding sequence immediately after language selection and name entry, before the 12 Life Areas assessment wizard begins.

This screen articulates:
1. **Core Mindset & Principles**:
   - **Faith in Small Changes**: Designed for individuals with faith that small, mindful changes compound into immense transformation over time. Even when consistency falters, previous steps remain genuine progress.
   - **Sustainable Life Balance (Not High-Performance Pressure)**: While the app aims to sharpen focus and dissolve non-healthy distractions, it is not a high-pressure, rapid-output productivity engine. People hurried for instant results may feel disappointed; lasting growth takes root when granted its proper season.
   - **The Importance of Nurturing Calm**: Recommends reading the platform article on calm, providing a localized web link based on the user's selected language:
     - English: `https://bonaloko.com/thoughts-and-reflections/the-importance-of-nurturing-calm`
     - Portuguese: `https://bonaloko.com/pt-br/pensamentos-e-reflexoes/a-importancia-de-cultivar-a-calma`
     - Esperanto: `https://bonaloko.com/eo/pensoj-kaj-reflektoj/la-graveco-de-flegi-trankvilon`
2. **The Guided Path Ahead (Next Steps)**:
   - **Calm Life Areas Assessment**: Take the necessary time to reflect and evaluate each of the 12 areas of life at your current season.
   - **Prioritized Habit Suggestions**: The app will list and suggest habits tailored to your current life area priorities.
   - **Daily Habit Selection**: Select habits to practice daily (including positive habits you already do, to give you a clear, holistic view of your daily rhythms).
   - **Reflections at Your Own Pace**: Pick reflections to ponder whenever you have space, reaching your own conclusions with complete autonomy.

---

## 2. Technical & UI Architecture

### 2.1 Navigation Sequence
1. **Screen 1 (`WelcomeScreen`)**:
   - Language selector (Esperanto, Portuguese, English).
   - User name input.
   - Action button ("Continue" / "Next").
2. **Screen 2 (`ExpectationsAlignmentScreen`)**:
   - Mindset cards (Faith in small steps, unhurried pace, calm recommendation with localized article URL launcher).
   - Next steps overview (12-area assessment, prioritized habits, daily habits, personal reflections).
   - Call-to-action button: "Start Assessment" (`start_assessment_button`), triggering `setProfileConfigured(true)` and opening the assessment wizard.

### 2.2 Localization Keys
All copy must be fully localized in `app_en.arb`, `app_pt.arb`, and `app_eo.arb`.

---

## 3. Acceptance Criteria (Gherkin Scenarios)

```gherkin
Feature: Mobile Onboarding Expectations Alignment

  Scenario: Navigating from Welcome screen to Expectations screen
    Given a user opens the mobile application on first install
    When the user selects their language and enters their name on the Welcome screen
    And taps the continue button
    Then the app navigates to the Expectations Alignment screen
    And displays the core mindset cards regarding faith in small changes and measured pace

  Scenario: Localized article link reflects user language
    Given a user on the Expectations Alignment screen with selected language "pt" (Portuguese)
    When viewing the calm recommendation card
    Then the web article link points to "/pt-br/pensamentos-e-reflexoes/a-importancia-de-cultivar-a-calma"
    And when the language is "eo" (Esperanto)
    Then the web article link points to "/eo/pensoj-kaj-reflektoj/la-graveco-de-flegi-trankvilon"
    And when the language is "en" (English)
    Then the web article link points to "/thoughts-and-reflections/the-importance-of-nurturing-calm"

  Scenario: Starting assessment from Expectations screen
    Given a user on the Expectations Alignment screen
    When the user reviews the expectations and next steps
    And taps "Start Assessment"
    Then the user profile is marked as configured
    And the app navigates to Step 1 of the 12 Life Areas assessment wizard
```
