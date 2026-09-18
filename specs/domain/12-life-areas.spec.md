# Domain Specification: 12 Life Areas

| Metadata | Details |
| :--- | :--- |
| **Domain Component** | Core Ubiquitous Language & Classification |
| **Status** | `Approved` |
| **Related Vision** | [direction/VISION.md](../../direction/VISION.md) |

---

## 1. Domain Concept Overview

The **12 Life Areas** represent the foundational taxonomy of human life balance in `Bona Loko`. Every assessment, priority calculation, habit definition, and reflection prompt links back to one of these 12 immutable area entities.

---

## 2. The 12 Life Areas Taxonomy

| Index | Area Key | Canonical English Name | Domain Scope & Invariants |
| :---: | :--- | :--- | :--- |
| 1 | `health_fitness` | Health & Physical Fitness | Vitality, regular movement/exercise, restorative sleep, nutrition, recovery. |
| 2 | `emotional_wellbeing` | Mental & Emotional Wellbeing | Mindfulness, emotional stability, peace of mind, stress resilience, presence. |
| 3 | `personal_growth` | Personal Growth & Learning | Acquiring craft skills, intellectual curiosity, self-education, reading, reflection. |
| 4 | `career_calling` | Career & Professional Calling | Meaningful vocational pursuit, craft mastery, professional impact, mission. |
| 5 | `finances_wealth` | Finances & Wealth | Financial security, intentional spending, saving, investing, debt freedom. |
| 6 | `relationships_intimacy` | Relationships & Intimacy | Romantic partnership, mutual trust, vulnerable communication, romantic depth. |
| 7 | `family_parenting` | Family & Parenting | Kinship bonds, parenting presence, ancestral connections, family care. |
| 8 | `friendships_community` | Friendships & Community | Social circles, meaningful camaraderie, belonging, shared experiences. |
| 9 | `physical_environment` | Physical Environment & Spaces | Restful home, organized workspaces, aesthetic harmony, decluttering. |
| 10 | `recreation_play` | Recreation, Hobbies & Play | Playfulness, spontaneous joy, non-productive creative pursuits, restorative leisure. |
| 11 | `focus_mastery` | Focus & Attention Mastery | Digital hygiene, deliberate screen boundaries, deep work, protecting attention. |
| 12 | `contribution_legacy` | Contribution & Legacy | Community service, mentorship, philanthropic giving, societal impact. |

---

## 3. Localization Invariants

1. All entities must be stored internally using the canonical snake_case `Area Key` (e.g., `health_fitness`).
2. Display names and descriptions must be fetched from localized dictionaries (`en-US`, `pt-BR`, `eo`).
3. Under no circumstances should the key set vary or be dynamically deleted by users; individual users may choose to *deprioritize* areas, but all 12 areas always exist in the model.
