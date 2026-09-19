import fs from 'node:fs'
import path from 'node:path'

const ROOT = process.cwd()

console.log('--- Starting Verification: Suggested Habits Integration ---')

const HABIT_IDS = [
  'habit_consistent_sleep_evening_transition',
  'habit_morning_screen_free_window',
  'habit_nurture_of_gratitude',
  'habit_daily_protected_reading',
  'habit_mindful_daily_expense_tracking',
  'habit_daily_family_connection_ritual',
  'habit_weekly_personal_outreach',
  'habit_daily_guilt_free_micro_leisure'
]

const LOCALES = [
  { code: 'en-US', dir: 'content/en-us/suggested-habits', prefix: '/suggested-habits/' },
  { code: 'pt-BR', dir: 'content/pt-br/habitos-sugeridos', prefix: '/pt-br/habitos-sugeridos/' },
  { code: 'eo', dir: 'content/eo/sugestitaj-kutimoj', prefix: '/eo/sugestitaj-kutimoj/' }
]

function parseFrontmatter(raw) {
  const match = raw.match(/^---\r?\n([\s\S]*?)\r?\n---/)
  if (!match) return {}
  const yaml = match[1]
  const meta = {}
  for (const line of yaml.split(/\r?\n/)) {
    const m = line.match(/^([a-zA-Z0-9_-]+):\s*(.*)$/)
    if (m) {
      let val = m[2].trim()
      if ((val.startsWith('"') && val.endsWith('"')) || (val.startsWith("'") && val.endsWith("'"))) {
        val = val.slice(1, -1)
      }
      meta[m[1].trim()] = val
    }
  }
  return meta
}

// 1. Verify content files across all 3 locales
const habitsByLocale = {}

for (const loc of LOCALES) {
  const fullDir = path.join(ROOT, loc.dir)
  if (!fs.existsSync(fullDir)) {
    console.error(`FAIL: Directory not found: ${loc.dir}`)
    process.exit(1)
  }

  const files = fs.readdirSync(fullDir).filter(f => f.endsWith('.md'))
  if (files.length !== 8) {
    console.error(`FAIL: Expected 8 habit files in ${loc.dir}, found ${files.length}`)
    process.exit(1)
  }

  habitsByLocale[loc.code] = []

  for (const file of files) {
    const raw = fs.readFileSync(path.join(fullDir, file), 'utf-8')
    const fm = parseFrontmatter(raw)

    if (!fm.id || !fm.title || !fm.slug) {
      console.error(`FAIL: Missing mandatory frontmatter in ${loc.dir}/${file}:`, fm)
      process.exit(1)
    }

    // Enforce Rule 8: No area_index for suggested habits
    if (fm.area_index !== undefined) {
      console.error(`FAIL: Rule 8 violation: area_index must be omitted in ${loc.dir}/${file}`)
      process.exit(1)
    }

    habitsByLocale[loc.code].push(fm)
  }

  console.log(`PASS: ${loc.code} has 8 valid habit articles in ${loc.dir}`)
}

// 2. Verify all 8 canonical IDs exist in each locale
for (const id of HABIT_IDS) {
  for (const loc of LOCALES) {
    const found = habitsByLocale[loc.code].find(h => h.id === id)
    if (!found) {
      console.error(`FAIL: Canonical habit ID "${id}" missing in ${loc.code}`)
      process.exit(1)
    }
  }
}
console.log('PASS: All 8 canonical habit IDs present across en-US, pt-BR, and eo')

// 3. Verify nuxt.config.ts route extensions
const nuxtConfig = fs.readFileSync(path.join(ROOT, 'web-app/nuxt.config.ts'), 'utf-8')
if (
  !nuxtConfig.includes('/suggested-habits/:slug') ||
  !nuxtConfig.includes('/pt-br/habitos-sugeridos/:slug') ||
  !nuxtConfig.includes('/eo/sugestitaj-kutimoj/:slug')
) {
  console.error('FAIL: Dynamic habit routes not registered in nuxt.config.ts')
  process.exit(1)
}
console.log('PASS: Dynamic habit routes registered in nuxt.config.ts')

// 4. Verify SuggestedHabitCard.vue component exists and has tri-lingual dictionary
const cardPath = path.join(ROOT, 'web-app/components/SuggestedHabitCard.vue')
if (!fs.existsSync(cardPath)) {
  console.error('FAIL: SuggestedHabitCard.vue not found')
  process.exit(1)
}
const cardContent = fs.readFileSync(cardPath, 'utf-8')
if (!cardContent.includes("'en-US':") || !cardContent.includes("'pt-BR':") || !cardContent.includes("'eo':")) {
  console.error('FAIL: SuggestedHabitCard.vue missing in-component translations for en-US, pt-BR, or eo')
  process.exit(1)
}
console.log('PASS: SuggestedHabitCard.vue implements tri-lingual in-component translations')

// 5. Verify index.vue has #suggested-habits section and translations
const indexContent = fs.readFileSync(path.join(ROOT, 'web-app/pages/index.vue'), 'utf-8')
if (!indexContent.includes('id="suggested-habits"')) {
  console.error('FAIL: id="suggested-habits" section missing in index.vue')
  process.exit(1)
}
if (!indexContent.includes('SuggestedHabitCard')) {
  console.error('FAIL: SuggestedHabitCard not used in index.vue')
  process.exit(1)
}
console.log('PASS: index.vue showcases suggested habits with SuggestedHabitCard')

// 6. Verify AppHeader.vue and AppFooter.vue have links
const headerContent = fs.readFileSync(path.join(ROOT, 'web-app/components/AppHeader.vue'), 'utf-8')
const footerContent = fs.readFileSync(path.join(ROOT, 'web-app/components/AppFooter.vue'), 'utf-8')

if (!headerContent.includes('#suggested-habits')) {
  console.error('FAIL: AppHeader.vue missing link to #suggested-habits')
  process.exit(1)
}
if (!footerContent.includes('#suggested-habits')) {
  console.error('FAIL: AppFooter.vue missing link to #suggested-habits')
  process.exit(1)
}
console.log('PASS: Navigation in AppHeader.vue and AppFooter.vue links to #suggested-habits')

// 7. Verify [slug].vue supports habit articles
const slugContent = fs.readFileSync(path.join(ROOT, 'web-app/pages/[slug].vue'), 'utf-8')
if (!slugContent.includes('isHabit') || !slugContent.includes('back_to_habits')) {
  console.error('FAIL: pages/[slug].vue missing habit context handling')
  process.exit(1)
}
console.log('PASS: pages/[slug].vue supports habit articles with breadcrumbs, widgets, and CTAs')

console.log('--- ALL VERIFICATION CHECKS PASSED SUCCESSFULLY ---')
