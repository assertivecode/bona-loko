# Rule: Platform Core Values & Moral Invariants

This rule establishes the inviolable standard for how AI agents, developers, and platform systems represent and enforce the **7 Core Values** of **Bona Loko**.

---

## Core Invariant

All platform features, copy, prompts, UI states, algorithms, and agent outputs must strictly align with the 7 Core Values defined in [FOUNDATION.md](../../FOUNDATION.md) and [specs/domain/core-values.spec.md](../../specs/domain/core-values.spec.md):

$$\text{Faith} \longrightarrow \text{Gratitude} \longrightarrow \text{Humility} \longrightarrow \text{Integrity} \longrightarrow \text{Respect} \longrightarrow \text{Empathy} \longrightarrow \text{Freedom}$$

---

## The Humility $\longrightarrow$ Integrity Invariant

> **The Humility $\rightarrow$ Integrity Principle**:
> *"True integrity naturally takes root in humility: seeing ourselves honestly and gently as we genuinely are creates the foundation for authentic alignment between our inner thoughts and outer actions."*

### Agent Directives:
1. **Humility Must Always Precede Integrity**:
   - In any taxonomy, enumeration, or architectural listing of the values, **Humility** must be placed in the **3rd position**, directly before **Integrity** in the 4th position.
2. **Honest Self-Assessment Without Defense**:
   - Self-assessment and priority gap discovery must be framed through humility: recognizing one's current baseline honestly, welcoming what is not working, and dropping pretensions or defensive rationalizations.
3. **Integrity Built on Reality**:
   - Integrity cannot be forced through perfectionism, vanity streaks, or rigid self-punishment. True integrity is the organic outgrowth of a humble appraisal of reality.
4. **Gentle, Non-Coercive UX & Algorithms**:
   - In accordance with Empathy and Freedom, software should never employ shame, punitive scoring, artificial urgency, or dark patterns. Setbacks must be treated as quiet invitations to reflect and adjust.
5. **Respectful, Non-Prescriptive Tone (No Inferences of Incapacity)**:
   - In accordance with [.agents/rules/humble-non-prescriptive-tone.md](./humble-non-prescriptive-tone.md), agents must never infer or declare what someone can or cannot do (e.g., avoiding *"You cannot act with true integrity unless you first possess..."*). Express all teachings with humility, respect, and invitation.

---

## Scope of Application

This standard applies universally across:
- **Living Specifications**: All documents in [`specs/`](../../specs/).
- **Dimension Content**: All living articles in [`content/`](../../content/) across `en-US`, `pt-BR`, and `eo`.
- **Frontend & Localization**: All Vue components, layouts, and translation dictionaries in [`web-app/`](../../web-app/).
- **Agent Reasoning**: Every plan, requirement breakdown, and architectural decision formulated by AI agents.
