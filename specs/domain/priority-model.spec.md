# Domain Specification: Multi-Dimensional Priority Model

| Metadata | Details |
| :--- | :--- |
| **Domain Component** | Core Engine Mathematical & Evaluation Model |
| **Status** | `Approved` |
| **Related Vision** | [direction/VISION.md](../../direction/VISION.md) |

---

## 1. Domain Concept Overview

The **Priority Model** evaluates life areas along five quantitative and qualitative dimensions rather than single-metric satisfaction scores. It formalizes the delta between what someone desires to invest in a life area versus their actual current behavior.

$$\text{Current Priority} \longrightarrow \text{Current State} \longrightarrow \text{Current Investment} \longrightarrow \text{Desired Investment} \longrightarrow \text{Priority Gap}$$

---

## 2. Dimension Definitions & Ranges

| Dimension | Type | Range / Domain | Meaning |
| :--- | :--- | :---: | :--- |
| `Current Priority` ($P$) | Integer | $[1, 10]$ | How critical this area is during the user's current season of life. |
| `Current State` ($S$) | Integer | $[1, 10]$ | Current satisfaction with the present condition of this area. |
| `Current Investment` ($I_{curr}$) | Integer | $[1, 10]$ | Self-reported energy, attention, and time currently allocated. |
| `Desired Investment` ($I_{des}$) | Integer | $[1, 10]$ | Target energy, attention, and time the user wishes to allocate. |
| `Intent` | Enum | `Improve` \| `Maintain` \| `Deprioritize` | Deliberate directional posture for the upcoming cycle. |

---

## 3. Mathematical Formulations

### 3.1 Investment Delta ($\Delta I$)
$$\Delta I = I_{des} - I_{curr}$$
- $\Delta I > 0$: Under-investment (aspirational gap).
- $\Delta I = 0$: Balanced equilibrium.
- $\Delta I < 0$: Over-investment (opportunity to reclaim time/energy).

### 3.2 Weighted Priority Gap Score ($G$)
The Priority Gap reflects the urgency of closing an under-investment gap, weighted by how important the area is to the individual:

$$G = \max(0, \Delta I) \times \left(\frac{P}{10}\right)$$

- Range: $[0.0, 9.0]$
- $G \ge 4.0$: **High-Priority Deficit** — primary candidate for habit intervention.
- $1.0 \le G < 4.0$: **Moderate Deficit** — secondary candidate.
- $G < 1.0$: **Aligned / Negligible Deficit**.

---

## 4. Invariants & Business Rules

1. **Non-Judgmental Feedback**: The model never flags a low $I_{curr}$ as a defect if $P$ is also low or if the user's intent is `Deprioritize`.
2. **Conservation of Energy**: When a user selects multiple areas for `Improve` with large gaps ($\sum \Delta I > 15$), the system must advise deprioritizing or maintaining other areas to prevent burnout.
3. **Audit Trail**: Every assessment iteration is snapshot with a timestamp, enabling time-series tracking across monthly/quarterly reflections.
