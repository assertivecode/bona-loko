# Feature Specification: 007 - Mobile Daily Physical Activities

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-007` |
| **Status** | `Approved` |
| **Component Path** | `mobile/habit-builder` |
| **Target Release** | Phase 2 (Physical Activity Habit Management & Daily Tracking) |
| **Related Specs** | [specs/features/006-mobile-daily-tasks-and-dedicated-screens/spec.md](../006-mobile-daily-tasks-and-dedicated-screens/spec.md), [specs/domain/12-life-areas.spec.md](../../domain/12-life-areas.spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The Problem
Cultivating physical vitality through daily movement is a foundational pillar of life balance (anchored in the Health & Physical Fitness life area). Users need a compassionate, intuitive way to define their daily physical activities—such as walking and running—specifying either a target **duration in minutes** or a target **number of repetitions**, and to track their completion throughout the day. This functionality must be directly accessible from their daily Home Page dashboard.

### 1.2 Invariants & Principles
- **Habit Autonomy**: Any physical activity can be initiated independently without artificial gatekeeping or mandatory prerequisite hierarchies.
- **Multidimensional Synergy**: Physical activity is presented constructively as nurturing somatic ease, emotional calm, focus mastery, and cardiovascular vitality.
- **Tri-Lingual Parity**: All strings, activity labels, metric types, and tooltips are localized across English (`en-US`), Portuguese (`pt-BR`), and Esperanto (`eo`).
- **Persistence Table Names**:
  - SQLite table for physical activities: `physical_activities`
  - SQLite table for daily completions: `daily_activities_completions`

---

## 2. Domain & Data Requirements

### 2.1 Table: `workout_groups`
- `id` (Text / UUID primary key)
- `name` (Text, e.g. "Grupo Padrão", "Full Body", "Hipertrofia ABC")
- `description` (Text, nullable)
- `created_at` (DateTime timestamp)
- `is_active` (Boolean: default `true`)
- `order_index` (Integer: default `0`)

### 2.2 Table: `workout_routines`
- `id` (Text / UUID primary key)
- `group_id` (Text foreign key referencing `workout_groups.id` ON DELETE CASCADE)
- `name` (Text: e.g. "Treino A - Peito & Tríceps", "Treino B - Costas & Bíceps", "Upper Body")
- `description` (Text, nullable)
- `created_at` (DateTime timestamp)
- `order_index` (Integer: default `0`)

### 2.3 Table: `training_exercises`
- `id` (Text / UUID primary key)
- `routine_id` (Text foreign key referencing `workout_routines.id` ON DELETE CASCADE)
- `name` (Text: e.g. "Walking", "Running", "Push-ups", "Squats", "Bench Press")
- `activity_type` (Text: `'duration'` | `'repetition'`)
- `target_sets` (Integer: default `3`)
- `target_duration_seconds` (Integer, nullable)
- `target_repetitions` (Integer, nullable)
- `target_weight_kg` (Real/Double, nullable)
- `order_index` (Integer: position in the routine)

### 2.4 Table: `daily_training_sessions`
- `id` (Text / UUID primary key)
- `routine_id` (Text foreign key referencing `workout_routines.id`, nullable)
- `routine_name` (Text)
- `group_name` (Text, nullable)
- `date` (DateTime timestamp normalized to day YYYY-MM-DD)
- `started_at` (DateTime timestamp)
- `concluded_at` (DateTime timestamp, nullable)
- `status` (Text: `'in_progress'` | `'completed'`)

### 2.5 Table: `daily_training_records`
- `id` (Text / UUID primary key)
- `session_id` (Text foreign key referencing `daily_training_sessions.id` ON DELETE CASCADE)
- `exercise_name` (Text)
- `activity_type` (Text)
- `sets` (Integer, default `3`)
- `duration_seconds` (Integer, nullable)
- `repetitions` (Integer, nullable)
- `weight_kg` (Real/Double, nullable)
- `is_completed` (Boolean: default `false`)
- `order_index` (Integer)

---

## 3. User Flows & Components

### 3.1 Home Page Daily Task Entry
- The **Daily Tasks** section on `HomeScreen` presents **"Daily Physical Activities"**.
- Displays activity icon (`Icons.directions_run_rounded`), localized title, and subtitle summary indicating whether training is not started, in progress, or concluded for today.
- Tapping navigates via `Navigator.push` to `PhysicalActivitiesScreen`.

### 3.2 3-Tier Training Structure
1. **Groups Selector & Management (Grupos de Treino)**:
   - The user views their list of Groups (e.g. "Grupo Padrão", "Full Body", "Hipertrofia ABC").
   - Can select which Group to view.
   - Can create new Groups, rename, or delete Groups.
2. **Workout Routines (Rotinas de Treino)**:
   - For the selected Group, the user views all associated workout routines (e.g., "Treino A", "Treino B").
   - Can select which Routine to view and manage.
   - Can add a new routine, rename, or delete routines.
   - Can tap **"Treinar Rotina" / "Start Workout"** to train this specific routine.
3. **Individual Exercises with Sets (Exercícios Individuais com Sets)**:
   - Within the selected routine, the user views all configured individual exercises.
   - For each exercise:
     - Exercise name (e.g. "Squats / Agachamentos", "Push-ups / Flexões", "Running", or custom).
     - Target settings: **Sets** (e.g. 3 sets), **Repetitions** (e.g. 25 reps) or **Duration** (e.g. 20 min), and **Weight** in kg.
     - Display format: *"Agachamentos - 3 sets de 25 repetições"*.
     - Can reorder, edit, or delete exercises.
     - Can add new exercises to the routine with sets, reps/duration, and weights.

### 3.3 Starting a Daily Training Session for a Routine
- When the user selects a routine and taps **"Treinar Rotina" / "Start Workout"**:
  - The system creates a `daily_training_sessions` record referencing the selected routine and Group.
  - Initializes `daily_training_records` snapshotting the routine's exercises with their target values (sets, repetitions/duration, weight).
  - The UI transitions into active workout mode.
  - The user can adjust actual values performed today (sets, minutes, reps, weight) and check exercises off.

### 3.4 Concluding the Daily Training
- When the user finishes, they tap **"Conclude Training"**:
  - Sets `concluded_at = DateTime.now()` and `status = 'completed'`.
  - Persists all final exercise settings for that day.
  - Updates Home screen daily task to show the training was completed today.

---

## 4. Acceptance Criteria (Gherkin Scenarios)

### Scenario 1: Creating and selecting a Workout Group
```gherkin
Given the user is on the Daily Physical Activities screen
When the user creates a new Group named "Hipertrofia ABC"
Then the Group "Hipertrofia ABC" appears in the user's groups list
And selecting "Hipertrofia ABC" displays its associated workout routines
```

### Scenario 2: Adding and selecting a Workout Routine within a Group
```gherkin
Given a selected Group "Hipertrofia ABC"
When the user adds a new routine named "Treino A - Peito e Tríceps"
Then the routine appears in the Group's routines list
And selecting "Treino A - Peito e Tríceps" displays its individual exercises
```

### Scenario 3: Adding individual exercises with sets to a Workout Routine
```gherkin
Given a selected Workout Routine "Treino A - Peito e Tríceps"
When the user adds "Agachamentos" with 3 sets of 25 repetitions
And the user adds "Walking" with 1 set of 20 minutes duration
Then the routine displays "Agachamentos - 3 sets de 25 repetições"
And the exercises are persisted in "training_exercises" linked to the routine
```

### Scenario 4: Selecting a routine and starting training
```gherkin
Given a Workout Routine with configured exercises
When the user taps "Treinar Rotina" / "Start Workout"
Then a new session is created in "daily_training_sessions" with status "in_progress"
And individual records are created in "daily_training_records" with planned sets and targets
And the user can adjust actual sets, reps, duration, and weight, check off exercises, and conclude the workout
```

### Scenario 5: Accessing physical activities from the Home page
```gherkin
Given a user viewing the Home Page
When the user views the Daily Tasks section
Then the task "Daily Physical Activities" is visible
And tapping the task opens the dedicated Daily Physical Activities screen with the Groups list
```
