# Feature Specification: 001 - Public Landing Page

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-001` |
| **Status** | `Implemented` |
| **Component Path** | [web-app/pages/index.vue](../../../web-app/pages/index.vue) |
| **Target Release** | Phase 1 (MVP) |
| **Related Specs** | [specs/domain/12-life-areas.spec.md](../../domain/12-life-areas.spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The Problem
Prospective users arriving at the platform need to immediately grasp Bona Loko's value proposition as a holistic life balance and priority realignment ecosystem. Additionally, organizations looking for balanced, high-performing talent need to understand the recruitment business model.

### 1.2 Alignment with Vision
Introduces the **12 Life Areas**, the **Priority Gap** concept, and the **Life Transformation Cycle** as outlined in [direction/VISION.md](../../../direction/VISION.md).

---

## 2. Scope & Boundaries

### 2.1 In Scope
- [x] Hero Section: Punchy value proposition headline, subtitle, and primary/secondary CTAs.
- [x] Interactive 12 Life Areas Grid: Displaying all 12 areas with icons, badges, descriptions, and hover micro-animations.
- [x] Recruitment & Talent Section: Explaining the business model connecting self-aware talent with values-aligned companies.
- [x] Tri-Language In-Component Localization: Instant language switcher supporting English (`en-US`), Brazilian Portuguese (`pt-BR`), and Esperanto (`eo`).
- [x] Responsive glassmorphic dark-mode design conforming to Web Application Development standards.

### 2.2 Out of Scope
- User authentication and persistent user profiles (scheduled for later phases).
- Full interactive assessment questionnaire (spec: `feat-002`).

---

## 3. User Flows & Interaction Journey

### 3.1 Primary Browsing Journey
1. **Landing**: Visitor visits `/`. Page loads in default or persisted locale (default `en-US`).
2. **Exploration**: Visitor scrolls through the Hero, reviews the 12 Life Areas grid, and views the Talent/Recruitment value proposition.
3. **Locale Selection**: Visitor toggles the header language selector to change language on-the-fly.
4. **Call to Action**: Visitor clicks "Get Started" or "Explore Assessment", initiating the onboarding flow.

---

## 4. UI / UX Specifications

### 4.1 Visual Hierarchy
1. **Header / Navbar**: Brand Logo ("Bona Loko"), navigation links, and Language Switcher dropdown/toggle.
2. **Hero Section**: Eyebrow badge, primary `h1`, lead paragraph, CTA action group.
3. **12 Areas Grid**: 3-column or 4-column responsive grid with card hover elevation, category badges, and area descriptions.
4. **Talent & Recruitment Section**: Dual-column card layout contrasting Candidate benefits vs Employer benefits.
5. **Footer**: Copyright, manifesto link, and language repeat.

### 4.2 Tri-Language Dictionary Keys
Every text node must map to dictionary keys inside `index.vue`:
- `hero_title`, `hero_subtitle`, `hero_cta_primary`, `hero_cta_secondary`
- `areas_title`, `areas_subtitle`
- Area keys: `health_fitness_title`, `health_fitness_desc`, etc.
- Recruitment keys: `recruitment_badge`, `recruitment_title`, `recruitment_desc`, etc.

---

## 5. Acceptance Criteria (Gherkin Scenarios)

### Scenario 1: Initial Page Render
```gherkin
Given an unauthenticated visitor visits the root "/"
Then the page header displays the "Bona Loko" brand
And the Hero section renders an h1 title and two CTA buttons
And all 12 Life Areas are visible within the areas grid
```

### Scenario 2: Tri-Language Switching
```gherkin
Given the landing page is rendered with locale "en-US"
When the user selects "Português (Brasil)" from the language toggle
Then all headings, area titles, and CTA buttons translate to Portuguese immediately without a page reload
When the user selects "Esperanto"
Then all content translates to Esperanto immediately without a page reload
```

### Scenario 3: Responsive Behavior
```gherkin
Given a user viewing the landing page on a mobile device (width < 768px)
Then the 12 Life Areas grid collapses to a single column layout
And the navigation bar adapts smoothly to mobile dimensions
```
