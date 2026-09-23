# Feature Specification: 005 - Mobile Life Areas Evaluation & Priority Engine

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-005` |
| **Status** | `Draft` |
| **Component Path** | `mobile/habit-builder` |
| **Target Release** | Phase 2 (Domain Layer, Evaluations Persistence & Home Page Gating) |
| **Related Specs** | [specs/domain/12-life-areas.spec.md](../../domain/12-life-areas.spec.md), [specs/domain/priority-model.spec.md](../../domain/priority-model.spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The Problem
Users need a structured, compassionate, and frictionless way to assess their lives across the 12 canonical life areas. The evaluation must capture both current satisfaction/state (0.0 to 10.0 in 0.5 increments) and urgency to focus/practice (1 to 5 priority rating). Once the baseline assessment is completed, the user must land on their daily Home Page dashboard rather than repeating the onboarding setup.

### 1.2 Alignment with Vision & Values
- **Taxonomy Invariant**: Faith -> Gratitude -> Humility (#3) -> Integrity (#4) -> Respect -> Empathy -> Freedom.
- **Tone Invariant**: Gentle, non-prescriptive, respectful language without claiming personal incapacity or gatekeeping.
- **12 Life Areas Canonical Taxonomy**: Health & Fitness, Emotional Wellbeing, Personal Growth, Career & Calling, Finances & Wealth, Relationships & Intimacy, Family & Parenting, Friendships & Community, Physical Environment, Recreation & Play, Focus Mastery, Contribution & Legacy.

---

## 2. Domain & Data Requirements

### 2.1 Integer Enum: `LifeArea`
- An integer enum representing the 12 areas from `1` to `12`.
- Canonical keys: `health_fitness`, `emotional_wellbeing`, `personal_growth`, `career_calling`, `finances_wealth`, `relationships_intimacy`, `family_parenting`, `friendships_community`, `physical_environment`, `recreation_play`, `focus_mastery`, `contribution_legacy`.

### 2.2 Table: `life_areas_evaluations`
SQLite persistence schema:
- `id` (Text / UUID primary key)
- `life_area` (Integer mapped to `LifeArea` enum, 1 to 12)
- `score` (Real, 0.0 to 10.0 with 0.5 decimal increments)
- `current_priority` (Integer, 1 to 5, where 5 is highest priority to focus/practice)
- `evaluated_at` (DateTime timestamp)

### 2.3 Mathematical Priority Engine
- **Weighted Deficit Score**:
  $$W = (10.0 - \text{score}) \times \left(\frac{\text{current\_priority}}{5.0}\right)$$
- **Deficit Categorization**:
  - High Priority Deficit: $W \ge 4.0$ or $\text{current\_priority} = 5$
  - Moderate Deficit: $1.0 \le W < 4.0$
  - Aligned / Low Deficit: $W < 1.0$
- **Energy Conservation**: Warn if more than 3 areas have priority 5 or sum of priorities indicates potential overextension.

---

## 3. User Flows & Components

### 3.1 Centralized Evaluation Component (`LifeAreaEvaluationCard`)
- Reusable across both the onboarding wizard and on-demand individual area evaluations.
- Renders:
  1. Area title and icon.
  2. Short grounding description explaining what is being evaluated in that specific area.
  3. Score slider (0.0 to 10.0 with 0.5 increments and live value display).
  4. Priority selector (1 to 5, where 5 is higher priority to focus/practice).

### 3.2 Gated Navigation Flow
1. **First Run (Onboarding Incomplete)**:
   - User sees Welcome Screen (Language selector, user name, description, "Start Assessment" button).
   - Tapping "Start Assessment" opens the 12 Life Areas Evaluation Wizard.
   - User steps through all 12 areas using the centralized evaluation component.
   - Concluding the assessment persists all 12 records to `life_areas_evaluations` and marks `onboarding_completed = true`.
2. **Post-Onboarding (Home Page)**:
   - App launches directly into the Home Page screen.
   - Shows personalized greeting and highlights top priority focus areas (priority 5 or highest weighted deficit).
   - Lists all 12 life areas with current scores and priority levels.
   - Tapping any life area opens the centralized evaluation component to update that individual area.

---

## 4. Acceptance Criteria (Gherkin Scenarios)

### Scenario 1: Initial 12-area assessment saves to SQLite and displays Home Page
```gherkin
Given a first-time user who has entered their name on the Welcome screen
When they complete the 12 Life Areas assessment wizard and submit
Then 12 records are inserted into the "life_areas_evaluations" table
And the user profile has "onboarding_completed" set to true
And the app transitions immediately to the Home Page screen displaying their top priority areas
```

### Scenario 2: Centralized evaluation component captures score and priority
```gherkin
Given the centralized LifeAreaEvaluationCard for "health_fitness"
When the user adjusts the score to 7.5 and current priority to 5
Then the component renders the short description for Health & Physical Fitness
And the selected score is 7.5
And the selected priority is 5
And the data is formatted for persistence in "life_areas_evaluations"
```

### Scenario 3: Priority engine calculates weighted deficit and energy warning
```gherkin
Given an evaluation with score 4.0 and current_priority 5
When the priority engine calculates the weighted deficit
Then the weighted deficit is (10.0 - 4.0) * (5 / 5.0) = 6.0
And the area is classified as "High Priority Deficit"
```

### Scenario 4: Subsequent app launch opens Home Page directly
```gherkin
Given a user who has previously completed the onboarding assessment
When the user launches the application
Then the app displays the Home Page screen directly without showing the Welcome onboarding screen
And all evaluated life areas are loaded from the "life_areas_evaluations" table
```
