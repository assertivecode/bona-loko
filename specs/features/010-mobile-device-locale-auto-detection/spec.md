# Feature Specification: 010 - Mobile Device Locale & Region Auto-Detection

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-010` |
| **Status** | `Approved` |
| **Component Path** | `mobile/habit-builder` |
| **Target Release** | Mobile App Localization & First-Run Experience |
| **Related Specs** | [specs/domain/core-values.spec.md](../../domain/core-values.spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The Problem
When users first download and open the Bona Loko mobile application, the initial language defaults statically to English regardless of their device settings or geographic region. For users in Portuguese-speaking countries (e.g., Brazil, Portugal, Angola, Mozambique, Cape Verde, Guinea-Bissau, São Tomé and Príncipe, Timor-Leste) or users who already have their phone system language configured to Portuguese, encountering an English interface requires manual intervention, creating unnecessary cognitive friction during onboarding.

### 1.2 The Solution
Automatically detect the user's phone system language and geographic region on first launch:
1. If the device system language is Portuguese (`pt`), pre-select and render the app in Portuguese (`AppLanguage.portuguese`).
2. If the device system language is Esperanto (`eo`), pre-select and render the app in Esperanto (`AppLanguage.esperanto`).
3. If the device country code belongs to a Portuguese-speaking (Lusophone) territory (e.g., `BR`, `PT`, `AO`, `MZ`, `CV`, `GW`, `ST`, `TL`, `MO`), pre-select and render the app in Portuguese (`AppLanguage.portuguese`).
4. Otherwise, default to English (`AppLanguage.english`).
5. **Autonomy Invariant**: The user retains full freedom to change their preferred language at any time in the Welcome screen or later in their Profile settings.

---

## 2. Technical & Domain Design

### 2.1 Lusophone Country Codes (CPLP & Co-official)
The following ISO 3166-1 alpha-2 territory codes are recognized as Lusophone:
- `BR`: Brazil
- `PT`: Portugal
- `AO`: Angola
- `MZ`: Mozambique
- `CV`: Cape Verde
- `GW`: Guinea-Bissau
- `ST`: São Tomé and Príncipe
- `TL`: Timor-Leste
- `MO`: Macau

### 2.2 Resolution Precedence
The resolution function `AppLanguage.fromDeviceLocale([Locale? locale])`:
1. **Primary Check**: `locale.languageCode.toLowerCase() == 'pt'` $\rightarrow$ `AppLanguage.portuguese`
2. **Esperanto Check**: `locale.languageCode.toLowerCase() == 'eo'` $\rightarrow$ `AppLanguage.esperanto`
3. **Region Check**: `locale.countryCode.toUpperCase() \in LusophoneCodes` $\rightarrow$ `AppLanguage.portuguese`
4. **Fallback**: `AppLanguage.english`

---

## 3. Acceptance Criteria (Gherkin Scenarios)

```gherkin
Feature: Mobile Device Locale & Region Auto-Detection

  Scenario: Device language is Portuguese
    Given a user opens the mobile application for the first time
    And the device system language is "pt_BR" or "pt_PT"
    When the initial user state is initialized
    Then the selected language is AppLanguage.portuguese
    And the WelcomeScreen renders all copy in Portuguese

  Scenario: Device language is Esperanto
    Given a user opens the mobile application for the first time
    And the device system language is "eo"
    When the initial user state is initialized
    Then the selected language is AppLanguage.esperanto
    And the WelcomeScreen renders all copy in Esperanto

  Scenario: Device language is English but region is Brazil
    Given a user opens the mobile application for the first time
    And the device system language is "en" with country code "BR"
    When the initial user state is initialized
    Then the selected language is AppLanguage.portuguese
    And the WelcomeScreen renders all copy in Portuguese

  Scenario: Device language is English and region is United States
    Given a user opens the mobile application for the first time
    And the device system language is "en" with country code "US"
    When the initial user state is initialized
    Then the selected language is AppLanguage.english
    And the WelcomeScreen renders all copy in English

  Scenario: User changes language manually after auto-detection
    Given the app auto-detected AppLanguage.portuguese on first launch
    When the user selects "English" from the language dropdown on WelcomeScreen
    Then the selected language switches to AppLanguage.english
    And the preference is persisted to the local database
```
