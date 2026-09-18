# Acceptance Criteria Template

| Metadata | Details |
| :--- | :--- |
| **Feature Reference** | [specs/features/...](../features/) |
| **Coverage Area** | Functional, Edge Case, Performance, Localization |
| **Status** | `Draft` \| `Approved` |

---

## Guidelines for Authoring

1. Use **Gherkin Syntax** (`Given`, `When`, `Then`, `And`, `But`).
2. Scenarios must be **atomic and deterministic** (reproducible with known state).
3. Cover at minimum:
   - 1x Primary Happy Path
   - 1x Boundary / Validation Scenario
   - 1x Error / Recovery Scenario
   - 1x Localization / Internationalization Assertion

---

## Scenario Suite

### Feature: [Feature Name]
As a [user role]
I want [capability]
So that [business outcome / benefit]

#### Scenario 1: [Happy Path Title]
- **Given** [initial state / prerequisites]
- **When** [user triggers action]
- **Then** [expected observable state change]
- **And** [secondary expectation]

#### Scenario 2: [Boundary or Validation Failure]
- **Given** [initial state]
- **When** [user enters invalid data / boundary condition]
- **Then** [validation error message displayed]
- **And** [state remains unchanged]

#### Scenario 3: [Edge Case or Recovery]
- **Given** [unusual system state / network fault]
- **When** [operation occurs]
- **Then** [graceful recovery or informational notice]

#### Scenario 4: [Tri-Language Verification]
- **Given** [component is mounted]
- **When** [locale is changed between 'en-US', 'pt-BR', and 'eo']
- **Then** [all visible text labels correctly match the active language dictionary]
- **And** [no missing translation keys or placeholders appear]
