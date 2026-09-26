# Feature Specification: 012 - Mobile Suggested Habits Selection & Home Sync

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-012` |
| **Status** | `Approved` |
| **Component Path** | `mobile/habit-builder` |
| **Target Release** | Mobile Habits Architecture & Dynamic Routine Management |
| **Related Specs** | [specs/domain/habit-life-area-weights.spec.md](../../domain/habit-life-area-weights.spec.md), [specs/features/005-mobile-life-areas-evaluation/spec.md](../005-mobile-life-areas-evaluation/spec.md), [specs/features/011-mobile-onboarding-expectations-alignment/spec.md](../011-mobile-onboarding-expectations-alignment/spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The User Problem
Previously:
1. The "Suggested Habits For Your Priorities" section was hardcoded inline inside `AssessedLifeAreasScreen`, showing only an unlocalized English preview of the top 3 habits without allowing users to choose or adopt them.
2. The Home Screen hardcoded static tasks (Gratitude, Physical Activity, Financial Management) for all users regardless of what habits they actually chose to adopt, violating the core principle of **Habit Autonomy** (Rule 8) and user agency.
3. Habit cards lacked full localization across English, Portuguese, and Esperanto.

### 1.2 The Solution
1. **Full Localization**: Translate all 9 canonical habits (titles and descriptions) across English, Portuguese, and Esperanto, matching the platform content repository.
2. **Dedicated Habits Screen (`SuggestedHabitsScreen`)**: Move the suggested habits section from `AssessedLifeAreasScreen` to a dedicated screen listing all existing canonical habits ranked dynamically by user priorities via `PriorityEngine.rankHabitsByPriority(...)`.
3. **Interactive Habit Selection**: Allow users to pick/select (and unselect) habits in this screen to add to or remove from their daily routine.
4. **Home Page Routine Synchronization**:
   - On the Home page, once onboarding is complete, **only** list habits that the user has actively selected.
   - Display a prominent navigation card/button redirecting to the dedicated Habits Screen.
   - When a habit is selected, its interactive card appears in the daily routine (linking to specialized feature screens such as `GratitudePracticeScreen`, `PhysicalActivitiesScreen`, or `FinancialManagementScreen`, or showing a standard daily practice card).
   - If no habits are selected yet, display an encouraging invitation state prompting the user to explore and pick habits.

---

## 2. Technical Architecture

### 2.1 Database Schema (`user_habits`)
```sql
CREATE TABLE IF NOT EXISTS "user_habits" (
  "id" TEXT NOT NULL PRIMARY KEY,
  "selected_at" INTEGER NOT NULL,
  "is_active" INTEGER NOT NULL DEFAULT 1
);
```

### 2.2 Domain & Localization Mapping
Each canonical habit maps to localized title and description resources:
- `habit_regular_exercise_workout`: Daily Physical Exercise & Movement / Exercício Físico Diário & Movimento / Ĉiutaga Fizika Ekzercado & Movado
- `habit_consistent_sleep_evening_transition`: Consistent Sleep & Evening Transition / Sono Consistente & Transição Noturna / Konsekvenca Dormo & Vespera Transiro
- `habit_morning_screen_free_window`: Morning Screen-Free Window / Janela Matinal Livre de Telas / Matena Senekrana Fenestro
- `habit_nurture_of_gratitude`: Cultivation of Gratitude / Cultivo da Gratidão / Kultivado de Dankemo
- `habit_daily_protected_reading`: Daily Protected Reading / Leitura Diária Protegida / Ĉiutaga Protektita Legado
- `habit_mindful_daily_expense_tracking`: Mindful Daily Expense Tracking / Registro Consciente de Despesas Diárias / Konscia Ĉiutaga Elspez-Spurado
- `habit_daily_family_connection_ritual`: Daily Family Connection Ritual / Ritual Diário de Conexão Familiar / Ĉiutaga Familia Rilata Rito
- `habit_weekly_personal_outreach`: Weekly Personal Outreach / Contato Pessoal Semanal / Semajna Persona Kontakto
- `habit_daily_guilt_free_micro_leisure`: Daily Guilt-Free Micro-Leisure / Microlazer Diário Sem Culpa / Ĉiutaga Senkulpa Mikro-Libertempo

### 2.3 Navigation Flows
- `HomeScreen` -> contains `Key('view_habits_screen_button')` -> pushes `SuggestedHabitsScreen`.
- `AssessedLifeAreasScreen` -> contains `Key('view_suggested_habits_button')` -> pushes `SuggestedHabitsScreen`.
- `SuggestedHabitsScreen` -> contains `Key('toggle_habit_{habitId}')` to toggle habit selection into SQLite.

### 2.4 Home Screen Visual Hierarchy
To center user experience on immediate daily action while maintaining clear access to strategic discovery:
1. **Greeting Banner** (`Key('home_greeting_card')`): Personalized welcome and daily mindfulness subtitle.
2. **Daily Tasks / Routine Section** (`Key('daily_tasks_section_title')`): First content block, rendering the user's active picked habits (or the empty state invitation if none selected).
3. **Suggested Habits Card** (`Key('view_habits_screen_button')`): Positioned immediately below the habit list, inviting discovery of additional practices.
4. **Life Areas & Priorities Card** (`Key('view_assessed_life_areas_button')`): Positioned lastly, providing access to holistic life balance review.

---

## 3. Acceptance Criteria (Gherkin Scenarios)

```gherkin
Feature: Mobile Suggested Habits Selection & Home Routine Synchronization

  Scenario: Suggested habits are fully localized and ranked by user priorities
    Given a user with completed life area evaluations
    When the user navigates to the dedicated Suggested Habits screen
    Then all canonical habits are displayed ordered by relevance weights to user priorities
    And each habit card displays its localized title, localized description, and life area synergies
    And in Portuguese ("pt"), titles and descriptions match the Portuguese registry
    And in Esperanto ("eo"), titles and descriptions match the Esperanto registry

  Scenario: Selecting and unselecting habits updates daily routine
    Given a user on the Suggested Habits screen
    When the user taps "Add to Routine" on a suggested habit
    Then the habit selection state updates to active in the database
    And the button indicates the habit is added to the routine
    When the user taps the button again to remove the habit
    Then the habit is unselected and marked inactive in the database

  Scenario: Home Page only lists habits the user has picked
    Given a user has completed the onboarding life areas assessment
    When no habits have been selected yet
    Then the Home page displays a navigation button to the habits screen
    And displays an encouraging empty state inviting the user to pick daily habits
    When the user navigates to the habits screen and selects "Cultivation of Gratitude"
    And returns to the Home page
    Then the Home page displays "Cultivation of Gratitude" in the Daily Tasks section
    And unselected habits are not displayed in the Daily Tasks section
    And tapping the gratitude card navigates to the Gratitude Practice screen

  Scenario: Home Page displays daily tasks first, then suggested habits, and lastly life areas
    Given a user on the Home page
    Then the Daily Tasks section is positioned above the Suggested Habits card
    And the Suggested Habits card is positioned below the user's habits list
    And the Life Areas & Priorities card is positioned lastly at the bottom

  Scenario: Only conceptually defined and implemented habits offer Add to Routine button
    Given a user on the Suggested Habits screen
    Then implemented habits ("Cultivation of Gratitude", "Daily Physical Exercise & Movement", "Mindful Daily Expense Tracking") display an interactive "Add to Routine" / "In Routine" toggle button
    And unbuilt habits without an interactive mobile implementation do not display an "Add to Routine" button
    And unbuilt habits display a respectful "Coming Soon" indicator instead
```
