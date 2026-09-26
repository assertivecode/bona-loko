# Feature Specification: 009 - Habit & Life Area Weighted Relations & Prioritized Suggestions

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-009` |
| **Status** | `Approved` |
| **Component Paths** | [web-app/composables/useArticleContent.ts](../../../web-app/composables/useArticleContent.ts), [web-app/components/SuggestedHabitCard.vue](../../../web-app/components/SuggestedHabitCard.vue), [mobile/habit-builder/lib/domain/models/suggested_habit.dart](../../../mobile/habit-builder/lib/domain/models/suggested_habit.dart), [mobile/habit-builder/lib/domain/engine/priority_engine.dart](../../../mobile/habit-builder/lib/domain/engine/priority_engine.dart), [mobile/habit-builder/lib/presentation/evaluation/assessed_life_areas_screen.dart](../../../mobile/habit-builder/lib/presentation/evaluation/assessed_life_areas_screen.dart) |
| **Target Release** | Phase 1 |
| **Related Specs** | [specs/domain/habit-life-area-weights.spec.md](../../domain/habit-life-area-weights.spec.md), [specs/domain/12-life-areas.spec.md](../../domain/12-life-areas.spec.md), [specs/domain/priority-model.spec.md](../../domain/priority-model.spec.md), [specs/features/004-suggested-habits-view/spec.md](../004-suggested-habits-view/spec.md), [specs/features/005-mobile-life-areas-evaluation/spec.md](../005-mobile-life-areas-evaluation/spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The User Problem
In human development, sustainable habits are rarely isolated tasks confined to a single life area. For example, regular exercise directly enhances physical fitness, but also significantly regulates emotional calm, reduces stress cortisol, and restores attention stamina. 

Previously, the platform lacked an explicit quantitative relationship between habits and the 12 Life Areas. Without this relationship, the web and mobile platforms could only display habits in a static list rather than suggesting the most impactful habits tailored to a person's current life area priorities.

### 1.2 Alignment with Vision & Operating Rules
- **Multi-Dimensional Habit Framing (Rule 8)**: Formalizes the multi-area ripple effects of each habit without locking any habit to a single compartment.
- **Habit Autonomy (Rule 8)**: Users retain complete autonomy to adopt any habit; weighted scores provide gentle guidance rather than prescriptive gatekeeping.
- **Life Balance Multi-Dimensional Priority Model**: Connects the user's priority assessment ($P_A \in [1, 5]$) directly to actionable suggested habits ($w \in [1, 5]$).

---

## 2. Scope & Boundaries

### 2.1 In Scope
- [ ] **Content Layer Folder Renaming & Path Updates**:
  - English: `content/en-us/dimensions/` $\rightarrow$ `content/en-us/life-areas/` (route `/life-areas/:slug`)
  - Portuguese: `content/pt-br/dimensoes/` $\rightarrow$ `content/pt-br/areas-da-vida/` (route `/pt-br/areas-da-vida/:slug`)
  - Esperanto: `content/eo/dimensioj/` $\rightarrow$ `content/eo/viv-areoj/` (route `/eo/viv-areoj/:slug`)
  - Backwards-compatible route aliases preserved for old URLs.
- [ ] **Habit Frontmatter Life Area Weights**:
  - Frontmatter schema includes `life_area_weights: Record<string, number>` with weights strictly between 1 and 5.
  - Mirrored across all suggested habits in `en-us`, `pt-br`, and `eo`.
- [ ] **Web Application Habit Ranking Engine**:
  - `calculateHabitRelevanceScore(habit, userPriorities)` in `web-app/composables/useArticleContent.ts`.
  - Display life area synergy pills with weights on `SuggestedHabitCard.vue`.
  - Filter/sort habits by relevance score when user priorities are provided.
- [ ] **Mobile Domain Model & Recommendation Engine**:
  - `SuggestedHabit` domain model with `Map<LifeArea, int> areaWeights` verifying weights $\in [1, 5]$.
  - `PriorityEngine.calculateHabitRelevanceScore(habit, evaluations)` and `PriorityEngine.rankHabitsByPriority(habits, evaluations)`.
  - Built-in canonical suggested habits (including daily workout/exercise, consistent sleep, mindful reading, etc.).
- [ ] **Mobile UI Integration**:
  - Display "Suggested Habits for Your Priorities" section in `AssessedLifeAreasScreen`.
  - Ranks habits dynamically based on the user's saved life area priorities.
  - Multi-language localization in `app_en.arb`, `app_pt.arb`, `app_eo.arb`.

### 2.2 Out of Scope
- Machine learning or telemetry-based recommendation weights (weights remain deterministic and human-centered).
- Direct habit streak tracking and database check-ins (Phase 2).

---

## 3. Technical Contracts

### 3.1 Mobile Domain Model (`SuggestedHabit`)
```dart
class SuggestedHabit {
  final String id;
  final String title;
  final String description;
  final Map<LifeArea, int> areaWeights; // Values must be 1..5

  const SuggestedHabit({
    required this.id,
    required this.title,
    required this.description,
    required this.areaWeights,
  });
}
```

### 3.2 Mobile Priority Engine Scoring
```dart
static double calculateHabitRelevanceScore({
  required SuggestedHabit habit,
  required List<LifeAreaEvaluation> evaluations,
});

static List<SuggestedHabit> rankHabitsByPriority({
  required List<SuggestedHabit> habits,
  required List<LifeAreaEvaluation> evaluations,
});
```

### 3.3 Web App Composable Contract
```ts
export function calculateHabitRelevanceScore(
  habit: ArticleRecord,
  userPriorities: Record<string, number>
): number;

export function getSuggestedHabitsRanked(
  locale: Locale,
  userPriorities?: Record<string, number>
): ArticleRecord[];
```

---

## 4. Acceptance Criteria (Gherkin Scenarios)

### Scenario 1: Weight Scale Validation (1 to 5)
```gherkin
Given a habit definition with a life area relation
When the assigned weight is less than 1 or greater than 5
Then the model rejects the construction with an ArgumentError
And when the assigned weight is an integer between 1 and 5
Then the relation is accepted and immutable
```

### Scenario 2: Exercise Habit Multi-Area Relevance Scoring
```gherkin
Given the exercise habit with weights:
  | Life Area                     | Weight |
  | health_fitness                | 5      |
  | emotional_wellbeing           | 4      |
  | focus_mastery                 | 3      |
  | recreation_play               | 2      |
And a user with current priorities:
  | Life Area                     | Priority |
  | health_fitness                | 5        |
  | emotional_wellbeing           | 4        |
  | focus_mastery                 | 3        |
  | recreation_play               | 2        |
When calculateHabitRelevanceScore is invoked
Then the relevance score is (5*5) + (4*4) + (3*3) + (2*2) = 54.0
```

### Scenario 3: Precedence Ranking of Suggested Habits
```gherkin
Given User A with high priority (5) on "health_fitness" and low priority (1) on "personal_growth"
And Habit 1 (Exercise) with weight 5 on "health_fitness"
And Habit 2 (Reading) with weight 5 on "personal_growth"
When the system ranks suggested habits for User A
Then Habit 1 (Exercise) is ranked with higher precedence than Habit 2 (Reading)
```

### Scenario 4: Renamed Content Paths on Web App
```gherkin
Given the visitor visits "/life-areas/health-and-physical-fitness"
Then the English life area article is rendered with status 200
When the visitor visits "/pt-br/areas-da-vida/saude-e-condicionamento-fisico"
Then the Portuguese life area article is rendered with status 200
When the visitor visits "/eo/viv-areoj/sano-kaj-fizika-taugeco"
Then the Esperanto life area article is rendered with status 200
```
