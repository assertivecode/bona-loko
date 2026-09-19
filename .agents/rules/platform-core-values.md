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
1. **Humility in the 3rd Position & Taxonomy Preservation**:
   - In any taxonomy, enumeration, or architectural listing of the values, **Humility** must be placed in the **3rd position**, directly before **Integrity** in the 4th position.
2. **Zero Value Comparison in Content ("Humility before Integrity" Prohibited)**:
   - When creating articles, documentation, prompts, or UI copy, **NEVER** compare one core value to another. Phrases like *"Humility before Integrity"*, *"Humility comes before Integrity"*, or claims that one virtue is superior, prior, or a prerequisite condition for another are strictly prohibited.
   - Comparing one value to another is not the way the platform produces content. Present each virtue affirmatively on its own merits and in complementary, mutual harmony.
3. **Honest Self-Assessment Without Defense**:
   - Self-assessment and priority gap discovery must be framed through humility: recognizing one's current baseline honestly, welcoming what is not working, and dropping pretensions or defensive rationalizations.
4. **Integrity Built on Reality**:
   - Integrity cannot be forced through perfectionism, vanity streaks, or rigid self-punishment. True integrity is the organic outgrowth of a humble appraisal of reality.
5. **Gentle, Non-Coercive UX & Algorithms**:
   - In accordance with Empathy and Freedom, software should never employ shame, punitive scoring, artificial urgency, or dark patterns. Setbacks must be treated as quiet invitations to reflect and adjust.
6. **Respectful, Non-Prescriptive Tone (No Inferences of Incapacity)**:
   - In accordance with [.agents/rules/humble-non-prescriptive-tone.md](./humble-non-prescriptive-tone.md), agents must never infer or declare what someone can or cannot do (e.g., avoiding *"You cannot act with true integrity unless you first possess..."*). Express all teachings with humility, respect, and invitation.

---

## Scope of Application

This standard applies universally across:
- **Living Specifications**: All documents in [`specs/`](../../specs/).
- **Dimension Content**: All living articles in [`content/`](../../content/) across `en-US`, `pt-BR`, and `eo`.
- **Frontend & Localization**: All Vue components, layouts, and translation dictionaries in [`web-app/`](../../web-app/).
- **Agent Reasoning**: Every plan, requirement breakdown, and architectural decision formulated by AI agents.
