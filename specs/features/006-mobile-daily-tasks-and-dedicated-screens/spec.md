# Feature Specification: 006 - Mobile Daily Tasks & Dedicated Screens

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-006` |
| **Status** | `Approved` |
| **Component Path** | `mobile/habit-builder` |
| **Target Release** | Phase 2 (Presentation Layer, Daily Tasks & Navigation Refactoring) |
| **Related Specs** | [specs/features/005-mobile-life-areas-evaluation/spec.md](../005-mobile-life-areas-evaluation/spec.md), [specs/domain/12-life-areas.spec.md](../../domain/12-life-areas.spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The Problem
Following onboarding, presenting the full 12 Life Areas overview and deep gratitude history directly on the Home screen creates visual clutter and dilutes focus on immediate daily action. Users need:
1. A focused **Home Screen** dedicated to their current day's active commitments and tasks (starting with "Practice gratitude").
2. A **Dedicated Gratitude Practice Screen** where morning (1 min) and evening (5 min) rhythms, entry logging, and reflective history are maintained with full focus.
3. A **Dedicated Assessed Life Areas Screen** where their 12-area overview, top focus dimensions, individual re-evaluations, and full assessment retake are cleanly accessed via intentional navigation from the Home screen.

### 1.2 Invariants & Principles
- **Tone Invariant**: Gentle, non-prescriptive, respectful language without claiming personal incapacity or gatekeeping.
- **Tri-Lingual Parity**: All strings localized in English (`en-US`), Portuguese (`pt-BR`), and Esperanto (`eo`).
- **Habit Autonomy**: Practices remain self-contained invitations without rigid prerequisites or dependencies.

---

## 2. User Flows & Components

### 2.1 Streamlined Home Page (`HomeScreen`)
- **Header**: Branded logo + Profile & Settings button.
- **Greeting Banner**: Personalized greeting ("Hello, {name}").
- **Daily Tasks Section**:
  - Displays currently active daily habits/practices.
  - Initial task: **"Practice Gratitude"** (`home_daily_task_gratitude`), presenting morning/evening guidance or entry counter.
  - Tapping this task opens the `GratitudePracticeScreen`.
- **Life Areas Navigation**:
  - Prominent redirection button/card (`view_assessed_life_areas_button`).
  - Tapping this opens the `AssessedLifeAreasScreen`.

### 2.2 Dedicated Gratitude Practice Screen (`GratitudePracticeScreen`)
- **AppBar**: Back button + localized title ("Gratitude Practice").
- **2 Daily Checkable Rhythm Tasks**:
  - 🌅 **Morning Grounding (1 min)**: Checkable item to log morning grounding practice for the current day.
  - 🌙 **Evening Reflection (5 min)**: Checkable item to log bedtime reflection for the current day.
  - Tapping each checkbox toggles completion and persists the state for that calendar day (`daily_gratitude_completions`).
- **Ungrouped Reorderable Gratitude Entries**:
  - Date grouping headers are removed; entries are presented in a unified list.
  - Users can reorder entries to their personal preference via drag-and-drop.
  - Order is saved persistently in the database (`order_index`).
- **Entry Action**:
  - Button to open the bottom sheet modal to register a new gratitude reason.
  - Ability to delete entries.

### 2.3 Dedicated Assessed Life Areas Screen (`AssessedLifeAreasScreen`)
- **AppBar**: Back button + localized title ("Assessed Life Areas").
- **Energy Conservation Advisory**: Displayed when > 3 areas have priority 5.
- **Top Focus Areas**: Highlights areas with priority 5 with score, priority tag, and quick edit action.
- **12 Life Areas Overview**: Sorted by priority descending, then score ascending, with quick re-evaluation bottom sheet.
- **Retake Assessment Button**: Opens `AssessmentWizardScreen` to redo the full assessment.

---

## 3. Acceptance Criteria (Gherkin Scenarios)

### Scenario 1: Home Page shows only daily tasks and redirection button
```gherkin
Given a user who has completed the onboarding assessment
When the user views the Home Page
Then the page displays the greeting banner
And the page displays the Daily Tasks section containing "Practice Gratitude"
And the page displays the button to view Assessed Life Areas
And the full 12 Life Areas overview is not displayed directly on the Home Page
```

### Scenario 2: Checking morning and evening gratitude tasks for today
```gherkin
Given the user is on the Gratitude Practice screen
When the user checks the "Morning (1 min)" task
Then the morning task is marked as completed for today with a checkmark
And the daily completion is saved in the database
When the user checks the "Evening (5 min)" task
Then the evening task is marked as completed for today
And the Home screen daily task card reflects "2 of 2 completed today"
```

### Scenario 3: Custom reordering of gratitude entries without date grouping
```gherkin
Given the user has registered multiple gratitude entries
When the user views the gratitude entries list
Then entries are displayed without date headers or grouping
And the user can drag and drop entries to reorder them
And the new ordering is saved to the database and preserved on screen re-entry
```

### Scenario 4: Navigating from Home Page to Assessed Life Areas screen
```gherkin
Given the user is on the Home Page
When the user taps the button to view Assessed Life Areas
Then the app navigates to the dedicated Assessed Life Areas screen
And the user sees the Top Focus Areas
And the user sees the 12 Life Areas Overview
And the user can re-evaluate individual areas or retake the full assessment
```
