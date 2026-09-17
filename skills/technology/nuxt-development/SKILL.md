---
name: tech-nuxt-development
description: >-
  Enforces Nuxt 3 development standards, specifically requiring that every page and component implements
  in-component translation dictionaries supporting en-US, pt-BR, and eo (Esperanto).
  Use when creating, modifying, or refactoring Nuxt 3 pages, components, layouts, or composables.
---

# Nuxt 3 Development & Multi-Language Standards

## Purpose
Establishes clear, consistent patterns for building client-side views and user interfaces in **Bona Loko** using Nuxt 3. A core architectural invariant is that **every new page and component must be self-contained and implement multi-language support locally** using in-file translation dictionaries.

---

## When to Use
- Creating any new `.vue` page inside `pages/`.
- Creating any new `.vue` component inside `components/`.
- Designing or adjusting layouts in `layouts/`.
- Working with localization or text strings in the frontend.

---

## Core Invariant: In-Component Translations

> [!IMPORTANT]
> **No global language JSON files for component-level text.**
> Each `.vue` file must define its own translation dictionary supporting the canonical locales:
> 1. `en-US` (English - US)
> 2. `pt-BR` (Português - Brasil)
> 3. `eo` (Esperanto)

### Why In-Component Translations?
1. **Locality of Behavior**: When modifying a component, UI copy and structure remain in the exact same file.
2. **Modular Encapsulation**: Components can be copied, deleted, or refactored without dangling or missing keys in distant JSON blobs.
3. **Type Safety & Immediate Feedback**: TypeScript checks that all three locales provide matching or compatible dictionary shapes.

---

## Standard Component Template

When authoring a page or component, follow this structure:

```vue
<template>
  <div class="my-component">
    <h2>{{ t('title') }}</h2>
    <p>{{ t('description') }}</p>
    <button type="button">{{ t('actions.submit') }}</button>
  </div>
</template>

<script setup lang="ts">
import { useComponentI18n } from '~/composables/useLocale'

// Component-Scoped Translation Dictionary (en-US, pt-BR, eo)
const componentTranslations = {
  'en-US': {
    title: 'Welcome',
    description: 'This is an example component.',
    actions: {
      submit: 'Confirm'
    }
  },
  'pt-BR': {
    title: 'Bem-vindo',
    description: 'Este é um componente de exemplo.',
    actions: {
      submit: 'Confirmar'
    }
  },
  'eo': {
    title: 'Bonvenon',
    description: 'Ĉi tio estas ekzempla komponanto.',
    actions: {
      submit: 'Konfirmi'
    }
  }
}

const { t } = useComponentI18n(componentTranslations)
</script>

<style scoped>
/* Scoped styles adhering to design tokens */
</style>
```

---

## Supported Locales & Fallback Rule
- **Canonical Locale Identifiers**:
  - `'en-US'`: Default / Fallback locale.
  - `'pt-BR'`: Portuguese (Brazil).
  - `'eo'`: Esperanto.
- If a specific key path is omitted in `'pt-BR'` or `'eo'`, the `useComponentI18n` composable automatically falls back to `'en-US'`.

---

## Localized Routing & URL Slugs Standard

Routing adheres to the **Prefix-Except-Default** strategy, mapping canonical routes to translated URL slugs:

| Page Purpose | English (`en-US`, Default) | Português (`pt-BR`) | Esperanto (`eo`) |
| :--- | :--- | :--- | :--- |
| **Home** | `/` | `/pt-br` | `/eo` |
| **About** | `/about` | `/pt-br/sobre` | `/eo/pri-ni` |
| **Mission** | `/mission` | `/pt-br/missao` | `/eo/misio` |

### Rules for Route Slugs & Navigation
1. **Never Hardcode Non-Default Route Paths**: Always use `useLocalePath()` when navigating between application pages.
   ```vue
   <script setup lang="ts">
   import { useLocalePath } from '~/composables/useLocale'
   const { localePath } = useLocalePath()
   </script>

   <template>
     <!-- Resolves to /about, /pt-br/sobre, or /eo/pri-ni based on active locale -->
     <NuxtLink :to="localePath('about')">About</NuxtLink>
     <!-- Also works with canonical route keys: 'home', 'about', 'mission' -->
     <NuxtLink :to="localePath('mission')">Mission</NuxtLink>
   </template>
   ```
2. **Persistence**: Locale preferences are stored in both `localStorage` and `useCookie('bona_loko_locale')` to guarantee SSR consistency and preserve preference across refreshes.
3. **Route Definition**: Localized routes are registered using the `pages:extend` hook in `nuxt.config.ts`, mapping clean translated slugs back to existing `pages/*.vue` files without duplicating page logic.
4. **Language Switching**: When the user switches languages, the application transitions to the equivalent translated slug for the current page.

---

## Page Head & Browser Tab Titles (`useHead`)

Every `.vue` page inside `pages/` must dynamically update the browser tab title based on the active language:

1. Define a `meta: { title: '...' }` entry inside the component-scoped dictionary for each locale:
   ```ts
   const pageTranslations = {
     'en-US': { meta: { title: 'Page Title — Bona Loko' } },
     'pt-BR': { meta: { title: 'Título da Página — Bona Loko' } },
     'eo': { meta: { title: 'Paĝa Titolo — Bona Loko' } }
   }
   ```
2. Bind the title reactively using Nuxt's `useHead()` composable:
   ```ts
   import { computed } from 'vue'
   import { useHead } from '#app'

   const { t } = useComponentI18n(pageTranslations)

   useHead({
     title: computed(() => t('meta.title'))
   })
   ```

---

## Quality Checklist for Nuxt Development
- [ ] Every user-visible string in `<template>` uses `{{ t('path.to.key') }}` or `:attr="t('path.to.key')"`.
- [ ] The script block contains a dictionary object declaring all three locales: `'en-US'`, `'pt-BR'`, and `'eo'`.
- [ ] Component imports `useComponentI18n` from `~/composables/useLocale`.
- [ ] Every page sets a reactive, localized browser title using `useHead({ title: computed(() => t('meta.title')) })`.
- [ ] Internal navigation links use `:to="localePath('route_key')"` instead of hardcoded English paths.
- [ ] Semantic HTML and accessible elements (`aria-label`, `button[type="button"]`, etc.) are used.
- [ ] No hardcoded English or Portuguese strings in template bodies.
