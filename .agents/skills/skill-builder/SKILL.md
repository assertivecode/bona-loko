---
name: meta-skill-builder
description: >-
  Automates the creation of new agentic skills and synchronizes all referencing and consuming files in the project.
  Use whenever the user asks to create, scaffold, add, or register a new skill in skills/<category>/<skill-name>.
---

# Skill Builder (Meta-Skill)

## Purpose
Enforces consistency and complete architectural synchronization when adding new skills to the `Bona Loko` skill suite. Beyond creating the `SKILL.md` file itself, this meta-skill guarantees that every file referencing, cataloging, or discovering skills is automatically updated.

---

## When to Use
- When the user prompts: *"Create a new skill for [name] under [category]"*
- When scaffolding new technology, quality, security, devops, or domain capability skills.
- When reorganizing or upgrading an existing skill.

---

## The Synchronization Invariant
> [!IMPORTANT]
> A skill is **NOT** finished until all referencing files are updated:
> 1. `skills/<category>/<skill-name>/SKILL.md` is created.
> 2. `.agents/skills.json` contains `{ "path": "skills/<category>" }`.
> 3. `skills/CATALOG.md` includes the skill in the Active Registry and Trigger Matrix.
> 4. `skills/README.md` reflects the updated skill count and table entry.

---

## Step-by-Step Creation Playbook

### Step 1: Parse Inputs & Assign Identifier
- Determine `<category>` (one of: `product`, `engineering`, `architecture`, `quality`, `security`, `devops`, `sre`, `data`, `capabilities`, `technology`, or a validated new category).
- Determine `<skill-name>` in kebab-case (e.g., `unit-testing`, `postgresql`, `multi-tenancy`).
- Derive the global identifier: `<prefix>-<skill-name>`:
  - `product/` -> `prod-<name>`
  - `engineering/` -> `eng-<name>`
  - `architecture/` -> `arch-<name>`
  - `quality/` -> `qual-<name>`
  - `security/` -> `sec-<name>`
  - `devops/` -> `devops-<name>`
  - `sre/` -> `sre-<name>`
  - `data/` -> `data-<name>`
  - `capabilities/` -> `cap-<name>`
  - `technology/` -> `tech-<name>`

### Step 2: Scaffold `SKILL.md`
Create `skills/<category>/<skill-name>/SKILL.md` using the standard structure:
```markdown
---
name: <identifier>
description: >-
  <Third-person action-oriented summary of what the skill does.>
  Use when <specific trigger scenarios, file types, keywords, or phases>.
---

# <Skill Title> Shell

## Purpose
<Why this skill exists and what value it provides.>

---

## When to Use
- <Trigger 1>
- <Trigger 2>

---

## Workflow Playbook
1. <Step 1>
2. <Step 2>
3. <Step 3>

---

## Quality Checklist
- [ ] <Invariant 1>
- [ ] <Invariant 2>
```

### Step 3: Synchronize `.agents/skills.json`
Inspect [.agents/skills.json](../../../.agents/skills.json). If the category is not yet listed in `entries`, add it:
```json
{ "path": "skills/<category>" }
```

### Step 4: Synchronize `skills/CATALOG.md`
Open [skills/CATALOG.md](../../../skills/CATALOG.md):
1. Add a new row to the **Active Skill Registry** table:
   ```markdown
   | `<identifier>` | `<category>` | [<category>/<skill-name>/SKILL.md](../../../skills/<category>/<skill-name>/SKILL.md) | <keyword triggers> |
   ```
2. If applicable, add the skill to an existing or new **Synergy Bundle**.

### Step 5: Synchronize `skills/README.md`
Open [skills/README.md](../../../skills/README.md):
1. Add the skill to the **Currently Active Shell Skills** table.
2. Verify that the directory tree under section 1 correctly represents the category.

---

## Verification Checklist
- [ ] `SKILL.md` YAML frontmatter is valid (`name` and `description` present, no unescaped quotes).
- [ ] `.agents/skills.json` parses as valid JSON.
- [ ] `skills/CATALOG.md` table rendered with correct markdown link.
- [ ] `skills/README.md` table updated.
- [ ] Link target verified to exist on disk.
