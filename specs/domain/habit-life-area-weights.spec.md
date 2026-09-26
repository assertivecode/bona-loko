# Domain Specification: Habit & Life Area Weighted Relations

| Metadata | Details |
| :--- | :--- |
| **Domain Component** | Core Habit & Life Area Cross-Cutting Affinity |
| **Status** | `Approved` |
| **Related Vision** | [direction/VISION.md](../../direction/VISION.md) |
| **Related Specs** | [specs/domain/12-life-areas.spec.md](./12-life-areas.spec.md), [specs/domain/habit-loop.spec.md](./habit-loop.spec.md), [specs/domain/priority-model.spec.md](./priority-model.spec.md) |

---

## 1. Domain Concept Overview

In `Bona Loko`, human habits are not isolated silos locked to a single life compartment. Human actions naturally ripple across multiple dimensions of life (e.g., physical exercise revitalizes health, clears mental fog, and boosts cognitive stamina).

The **Habit & Life Area Weighted Relation** formalizes the multi-dimensional affinity between any habit and each of the 12 Life Areas using an explicit weight scale ($1 \dots 5$). This mathematical relation powers habit recommendation algorithms to suggest the most appropriate habits based on the user's current life area priorities.

---

## 2. Weight Scale & Invariants

Each relation between a habit $H$ and a Life Area $A$ is assigned a scalar weight $w_{H, A} \in \{1, 2, 3, 4, 5\}$:

| Weight ($w$) | Synergy Level | Qualitative Meaning | Example (Exercise) |
| :---: | :--- | :--- | :--- |
| **5** | **Core Driver** | Primary, transformative impact; fundamental reason to practice. | `health_fitness` (5) |
| **4** | **High Impact** | Strong direct synergy and physiological/psychological boost. | `emotional_wellbeing` (4) |
| **3** | **Moderate Synergy**| Meaningful indirect catalyst; enhances execution capacity. | `focus_mastery` (3) |
| **2** | **Gentle Resonance** | Light positive secondary influence. | `recreation_play` (2) |
| **1** | **Auxiliary Touch** | Minor or contextual connection. | `physical_environment` (1) |
| *(Omitted)* | **Zero Synergy** | No direct or significant impact on this life area ($w = 0$). | *Other areas* |

### Invariants
1. **Weight Range**: The weight $w$ must be an integer between 1 and 5 inclusive. Any value outside $[1, 5]$ is invalid.
2. **Habit Autonomy**: A habit's weights reflect its inherent multidimensional nature. They do not dictate a prerequisite sequence or gatekeep when a user may adopt it.
3. **No Single-Area Restriction**: Suggested habits should ideally connect to at least one primary area ($w \ge 4$) and may touch multiple secondary areas.

---

## 3. Habit Relevance & Recommendation Formula

When suggesting habits to a user, the system evaluates the user's current life area priorities:
- $P_A \in [1, 5]$: The user's self-reported current priority for Life Area $A$ (where 5 = highest priority to focus/practice).

### 3.1 Relevance Score Calculation ($R$)
For a candidate habit $H$ with weights $w_{H, A}$, the overall Relevance Score $R(H)$ is computed as the inner product:

$$R(H) = \sum_{A \in \text{LifeAreas}} w_{H, A} \times P_A$$

If a life area has not yet been evaluated by the user, a baseline neutral priority $P_{\text{default}} = 3$ is applied.

### 3.2 Precedence & Ranking Rules
1. **Primary Sort Key**: Habits are ranked descending by $R(H)$. The higher the score, the higher the suggestion precedence.
2. **Secondary Sort Key (Tie-breaker 1)**: For habits with equal $R(H)$, precedence is given to the habit with the highest individual weight on the user's highest-priority life area ($\max_{A \in \text{TopAreas}} w_{H, A}$).
3. **Tertiary Sort Key (Tie-breaker 2)**: Localized title alphabetical order.

---

## 4. Canonical Suggested Habits & Default Weight Matrix

| Habit ID | Canonical English Title | Primary Area ($w = 5$) | Secondary Areas ($w = 4$) | Tertiary Areas ($w = 3 \text{ or } 2$) |
| :--- | :--- | :--- | :--- | :--- |
| `habit_regular_exercise_workout` | Daily Physical Exercise & Training | `health_fitness` (5) | `emotional_wellbeing` (4) | `focus_mastery` (3), `recreation_play` (2) |
| `habit_consistent_sleep_evening_transition` | Consistent Sleep & Evening Transition | `health_fitness` (5) | `emotional_wellbeing` (4) | `focus_mastery` (3) |
| `habit_morning_screen_free_window` | Morning Screen-Free Window | `focus_mastery` (5) | `emotional_wellbeing` (4) | `health_fitness` (3) |
| `habit_nurture_of_gratitude` | Cultivation of Gratitude | `emotional_wellbeing` (5) | `relationships_intimacy` (4) | `family_parenting` (3), `personal_growth` (3) |
| `habit_daily_protected_reading` | Daily Protected Reading | `personal_growth` (5) | `focus_mastery` (4) | `career_calling` (3) |
| `habit_mindful_daily_expense_tracking` | Mindful Daily Expense Tracking | `finances_wealth` (5) | `focus_mastery` (3) | `emotional_wellbeing` (3) |
| `habit_daily_family_connection_ritual` | Daily Family Connection Ritual | `family_parenting` (5) | `relationships_intimacy` (4) | `emotional_wellbeing` (3) |
| `habit_weekly_personal_outreach` | Weekly Personal Outreach | `friendships_community` (5) | `relationships_intimacy` (3) | `contribution_legacy` (3) |
| `habit_daily_guilt_free_micro_leisure` | Daily Guilt-Free Micro-Leisure | `recreation_play` (5) | `emotional_wellbeing` (4) | `health_fitness` (2) |
