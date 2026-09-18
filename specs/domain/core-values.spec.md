# Domain Specification: The 7 Core Values & Moral Architecture

| Metadata | Details |
| :--- | :--- |
| **Domain Component** | Core Ethical Bedrock & Inviolable Invariants |
| **Status** | `Approved` |
| **Related Foundation** | [FOUNDATION.md](../../FOUNDATION.md) |
| **Related Vision** | [direction/VISION.md](../../direction/VISION.md) |

---

## 1. Domain Concept Overview

The **7 Core Values** constitute the ethical and philosophical foundation of `Bona Loko`. They govern every UX interaction, algorithmic design choice, habit formulation, community guideline, and architectural boundary in the system.

### 1.1 The Sequential Architecture

The core values are not an arbitrary list; they follow an intentional, non-negotiable sequential architecture:

$$\text{Faith} \longrightarrow \text{Gratitude} \longrightarrow \text{Humility} \longrightarrow \text{Integrity} \longrightarrow \text{Respect} \longrightarrow \text{Empathy} \longrightarrow \text{Freedom}$$

```
       ⭐ Faith         ☀️ Gratitude       🌱 Humility
   (Belief in Growth)    (Seeing Abundance)   (Grounded Self-Awareness)

       🛡️ Integrity        🤝 Respect        ❤️ Empathy          ⚓ Freedom
    (True Inner Alignment) (Honoring Dignity) (Listening with Care) (Responsible Autonomy)
```

### 1.2 The Humility $\longrightarrow$ Integrity Invariant

The third position occupied by **Humility** is a foundational invariant of the platform:

> **The Humility $\rightarrow$ Integrity Principle:**
> *"True integrity naturally takes root in humility: seeing ourselves honestly and gently as we genuinely are creates the foundation for authentic alignment between our inner thoughts and outer actions."*

- **Epistemological Basis**: Authentic alignment between principles and actions flourishes when grounded in a calm, compassionate appraisal of current reality. Humility provides the gentle foundation that keeps integrity organic and true, preventing it from hardening into performative posturing, moralistic rigidity, or defensive self-delusion.
- **Application in Assessment**: Self-assessment and priority gap discovery are practiced through humility: welcoming an honest, gentle view of where time, attention, and energy currently flow, completely free from shame or denial.
- **Application in Software**: The system never generates fake metrics, exaggerated progress graphics, or vanity scores that cater to ego. It presents reality with absolute gentleness, honesty, and clarity.

---

## 2. The 7 Core Values Taxonomy

| Position | Value Key | Canonical English | Portuguese (`pt-BR`) | Esperanto (`eo`) | Core Invariant |
| :---: | :--- | :--- | :--- | :--- | :--- |
| 1 | `faith` | ⭐ Faith | Fé | Fido | Unconditional belief in human renewal, potential for change, and mutual support. |
| 2 | `gratitude` | ☀️ Gratitude | Gratidão | Dankemo | Appreciation for existing goodness and seeing abundance even in simplicity. |
| 3 | `humility` | 🌱 Humility | Humildade | Humileco | Grounded self-awareness; the prerequisite for honest inner alignment without defensive pretense. |
| 4 | `integrity` | 🛡️ Integrity | Integridade | Integreco | Authentic congruence between thoughts and actions, built in quiet, unseen everyday choices. |
| 5 | `respect` | 🤝 Respect | Respeito | Respekto | Honoring individual dignity, diverse worldviews, and human biological boundaries without distinction. |
| 6 | `empathy` | ❤️ Empathy | Empatia | Empatio | Radical compassion for struggle; transforming judgment into listening and eliminating guilt. |
| 7 | `freedom` | ⚓ Freedom | Liberdade | Libereco | Responsible sovereignty over attention, schedule, and personal definitions of a balanced life. |

---

## 3. Localization & In-Component Invariants

1. **Exact Ordering**: In every page, component, article, and translation dictionary across `en-US`, `pt-BR`, and `eo`, the values must appear in the strict sequence: $1 \rightarrow 2 \rightarrow 3 \rightarrow 4 \rightarrow 5 \rightarrow 6 \rightarrow 7$.
2. **Humility Position Invariant**: Humility must always be position #3, directly preceding Integrity (#4).
3. **Tri-Lingual Parity**: Any user-facing presentation of the core values must provide complete translations in English, Portuguese, and Esperanto without missing keys.

---

## 4. Acceptance Criteria (Gherkin Scenarios)

### Scenario 1: Preserving Value Order and Transitional Logic
```gherkin
Given a user or developer inspects the platform's core values
Then the values are presented in the exact sequence: Faith, Gratitude, Humility, Integrity, Respect, Empathy, Freedom
And Humility occupies the 3rd position
And Integrity occupies the 4th position
And the rationale explains that true integrity requires the humility to see oneself genuinely as one is
```

### Scenario 2: Dimension Articles Tri-Lingual Parity
```gherkin
Given any dimension article across "en-us", "pt-br", or "eo"
When Section 6 (Grounding in Core Values) is rendered
Then all 7 values must be enumerated with their respective symbols and definitions
And Humility (Humildade / Humileco) must be listed at position 3
```
