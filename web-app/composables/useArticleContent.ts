import { computed, type Ref } from 'vue'
import type { Locale } from '~/composables/useLocale'

export interface PillarItem {
  emoji?: string
  title?: string
  desc?: string
}

export interface ArticleFrontmatter {
  id: string
  title: string
  slug: string
  category?: string
  area_index?: number | string
  last_updated?: string
  summary?: string
  reading_time?: string
  tags?: string[]
  pillars?: PillarItem[]
  life_area_weights?: Record<string, number>
  [key: string]: any
}

export interface ArticleRecord {
  id: string
  locale: Locale
  collection: string
  slug: string
  frontmatter: ArticleFrontmatter
  markdownBody: string
  raw: string
  path: string
}

// Helper to strip quotes from YAML value strings
function stripQuotes(val: string): string {
  const trimmed = val.trim()
  if (
    (trimmed.startsWith('"') && trimmed.endsWith('"')) ||
    (trimmed.startsWith("'") && trimmed.endsWith("'"))
  ) {
    return trimmed.slice(1, -1)
  }
  return trimmed
}

// Light YAML frontmatter parser handling primitives, lists, and key-value maps
export function parseMarkdownDoc(rawContent: string): { frontmatter: ArticleFrontmatter; body: string } {
  const frontmatterRegex = /^---\r?\n([\s\S]*?)\r?\n---\r?\n([\s\S]*)$/
  const match = rawContent.match(frontmatterRegex)

  if (!match) {
    return {
      frontmatter: { id: '', title: '', slug: '' },
      body: rawContent
    }
  }

  const yamlBlock = match[1]
  const body = match[2]
  const meta: Record<string, any> = {}

  const lines = yamlBlock.split(/\r?\n/)
  let currentKey: string | null = null
  let currentList: any[] | null = null
  let currentMap: Record<string, any> | null = null
  let currentListItem: Record<string, any> | null = null

  for (const line of lines) {
    if (!line.trim() || line.trim().startsWith('#')) continue

    // List item start: e.g. "  - emoji: 🌙" or simple "  - some-tag"
    const listItemMatch = line.match(/^  -\s+(.*)$/)
    if (listItemMatch && currentKey) {
      if (!currentList) {
        currentList = []
        meta[currentKey] = currentList
      }
      const rest = listItemMatch[1].trim()
      const colonIdx = rest.indexOf(':')
      if (colonIdx > -1) {
        currentListItem = {}
        currentList.push(currentListItem)
        const k = rest.slice(0, colonIdx).trim()
        const v = stripQuotes(rest.slice(colonIdx + 1))
        currentListItem[k] = v
      } else {
        currentListItem = null
        currentList.push(stripQuotes(rest))
      }
      continue
    }

    // Sub-properties inside list item: e.g. "    title: Restorative Sleep"
    const subPropMatch = line.match(/^    ([a-zA-Z0-9_-]+):\s*(.*)$/)
    if (subPropMatch && currentListItem) {
      const k = subPropMatch[1].trim()
      const v = stripQuotes(subPropMatch[2])
      currentListItem[k] = v
      continue
    }

    // Key-value pair inside an object mapping: e.g. "  health_fitness: 5"
    const mapEntryMatch = line.match(/^  ([a-zA-Z0-9_-]+):\s*(.*)$/)
    if (mapEntryMatch && currentKey && !currentList) {
      if (!currentMap) {
        currentMap = {}
        meta[currentKey] = currentMap
      }
      const k = mapEntryMatch[1].trim()
      const rawV = stripQuotes(mapEntryMatch[2])
      const numV = Number(rawV)
      currentMap[k] = !isNaN(numV) && rawV !== '' ? numV : rawV
      continue
    }

    // Top-level key: e.g. "id: health_fitness", "pillars:", "life_area_weights:"
    const topKeyMatch = line.match(/^([a-zA-Z0-9_-]+):\s*(.*)$/)
    if (topKeyMatch) {
      const k = topKeyMatch[1].trim()
      const v = topKeyMatch[2].trim()

      currentKey = k
      currentList = null
      currentMap = null
      currentListItem = null

      if (v !== '') {
        const rawV = stripQuotes(v)
        const numV = Number(rawV)
        meta[k] = !isNaN(numV) && rawV !== '' ? numV : rawV
      }
    }
  }

  return {
    frontmatter: meta as ArticleFrontmatter,
    body
  }
}

// Automatic build-time & runtime discovery of all markdown documents via Vite glob
const rawMarkdownFiles = import.meta.glob('../../content/**/*.md', {
  query: '?raw',
  import: 'default',
  eager: true
}) as Record<string, string>

// In-memory index of discovered articles
const articles: ArticleRecord[] = []
const articlesById: Record<string, Partial<Record<Locale, ArticleRecord>>> = {}
const articlesBySlugAndLocale: Record<string, ArticleRecord> = {}
const articlesByPath: Record<string, ArticleRecord> = {}

function initializeContentRegistry(force = false) {
  if (articles.length > 0 && !force && !import.meta.dev) return
  if (import.meta.dev) {
    articles.length = 0
    for (const k in articlesById) delete articlesById[k]
    for (const k in articlesBySlugAndLocale) delete articlesBySlugAndLocale[k]
    for (const k in articlesByPath) delete articlesByPath[k]
  }

  for (const [filepath, raw] of Object.entries(rawMarkdownFiles)) {
    // Normalize path separators to forward slash
    const normalizedPath = filepath.replace(/\\/g, '/')
    
    // Path structure: ../../content/<locale-folder>/<collection>/<file>.md
    const segments = normalizedPath.split('/')
    const contentIdx = segments.indexOf('content')
    if (contentIdx === -1 || segments.length < contentIdx + 3) continue

    const localeFolder = segments[contentIdx + 1].toLowerCase()
    const collection = segments[contentIdx + 2]

    let locale: Locale = 'en-US'
    if (localeFolder === 'pt-br') locale = 'pt-BR'
    else if (localeFolder === 'eo') locale = 'eo'

    const { frontmatter, body } = parseMarkdownDoc(raw)
    const id = frontmatter.id || segments[segments.length - 1].replace(/\.md$/, '')
    const slug = frontmatter.slug || segments[segments.length - 1].replace(/\.md$/, '')

    let urlPath = ''
    if (locale === 'en-US') {
      urlPath = `/${collection}/${slug}`
    } else if (locale === 'pt-BR') {
      urlPath = `/pt-br/${collection}/${slug}`
    } else if (locale === 'eo') {
      urlPath = `/eo/${collection}/${slug}`
    }

    const record: ArticleRecord = {
      id,
      locale,
      collection,
      slug,
      frontmatter,
      markdownBody: body,
      raw,
      path: urlPath
    }

    articles.push(record)

    // Index by ID
    if (!articlesById[id]) articlesById[id] = {}
    articlesById[id][locale] = record

    // Alias life_area_xxx and dimension_xxx id
    const lifeAreaAliasId = `life_area_${id}`
    if (!articlesById[lifeAreaAliasId]) articlesById[lifeAreaAliasId] = {}
    articlesById[lifeAreaAliasId][locale] = record

    const dimensionAliasId = `dimension_${id}`
    if (!articlesById[dimensionAliasId]) articlesById[dimensionAliasId] = {}
    articlesById[dimensionAliasId][locale] = record

    // Index by slug and locale
    articlesBySlugAndLocale[`${locale}:${slug}`] = record

    // Index by direct path
    articlesByPath[urlPath] = record
  }
}

// Initialize on module load
initializeContentRegistry()

export function useAllArticles() {
  initializeContentRegistry()
  return {
    articles,
    articlesById,
    articlesBySlugAndLocale,
    articlesByPath
  }
}

const HABIT_ORDER = [
  'habit_nurture_of_gratitude',
  'habit_regular_exercise_workout',
  'habit_consistent_sleep_evening_transition',
  'habit_morning_screen_free_window',
  'habit_daily_protected_reading',
  'habit_mindful_daily_expense_tracking',
  'habit_daily_family_connection_ritual',
  'habit_weekly_personal_outreach',
  'habit_daily_guilt_free_micro_leisure'
]

/**
 * Returns all suggested habit articles for a given locale, in canonical order
 */
export function getSuggestedHabits(locale: Locale): ArticleRecord[] {
  initializeContentRegistry()
  const habitArticles = articles.filter(a =>
    a.locale === locale &&
    (a.collection === 'suggested-habits' || a.collection === 'habitos-sugeridos' || a.collection === 'sugestitaj-kutimoj' || a.id.startsWith('habit_'))
  )

  return habitArticles.sort((a, b) => {
    const idxA = HABIT_ORDER.indexOf(a.id)
    const idxB = HABIT_ORDER.indexOf(b.id)
    if (idxA !== -1 && idxB !== -1) return idxA - idxB
    if (idxA !== -1) return -1
    if (idxB !== -1) return 1
    return (a.frontmatter.title || '').localeCompare(b.frontmatter.title || '')
  })
}

/**
 * Calculates relevance score between a habit and user's current life area priorities.
 * Score = sum(weight_A * priority_A)
 * If priority_A is not provided in userPriorities, defaults to neutral priority 3.
 */
export function calculateHabitRelevanceScore(
  habit: ArticleRecord,
  userPriorities: Record<string, number> = {}
): number {
  const weights = habit.frontmatter.life_area_weights || {}
  let totalScore = 0
  for (const [areaKey, rawWeight] of Object.entries(weights)) {
    const weight = typeof rawWeight === 'number' ? rawWeight : parseInt(String(rawWeight), 10) || 0
    if (weight < 1 || weight > 5) continue
    const priority = userPriorities[areaKey] !== undefined ? userPriorities[areaKey] : 3
    totalScore += weight * priority
  }
  return totalScore
}

/**
 * Returns suggested habit articles ranked by relevance score according to user life area priorities.
 * Highest score has highest suggestion precedence.
 */
export function getSuggestedHabitsRanked(
  locale: Locale,
  userPriorities?: Record<string, number>
): ArticleRecord[] {
  const habits = getSuggestedHabits(locale)
  if (!userPriorities || Object.keys(userPriorities).length === 0) {
    return habits
  }

  return [...habits].sort((a, b) => {
    const scoreA = calculateHabitRelevanceScore(a, userPriorities)
    const scoreB = calculateHabitRelevanceScore(b, userPriorities)
    if (scoreB !== scoreA) {
      return scoreB - scoreA
    }
    return (a.frontmatter.title || '').localeCompare(b.frontmatter.title || '')
  })
}

/**
 * Finds an article record matching a route slug and active locale
 */
export function findArticleBySlug(slug: string, locale: Locale): ArticleRecord | null {
  initializeContentRegistry()

  // 1. Direct match by locale + slug
  const directMatch = articlesBySlugAndLocale[`${locale}:${slug}`]
  if (directMatch) return directMatch

  // 2. Fallback: match by slug regardless of locale (e.g. if user opened an English slug while in pt-BR)
  for (const article of articles) {
    if (article.slug === slug) {
      // If we have the counterpart in the requested locale, return that
      const counterpart = articlesById[article.id]?.[locale]
      if (counterpart) return counterpart
      return article
    }
  }

  // 3. Fallback: match by article ID
  const byId = articlesById[slug]?.[locale] || articlesById[`life_area_${slug}`]?.[locale] || articlesById[`dimension_${slug}`]?.[locale]
  if (byId) return byId

  return null
}

/**
 * Finds an article record matching a clean URL path
 */
export function findArticleByPath(path: string): ArticleRecord | null {
  initializeContentRegistry()
  const cleanPath = path.split('#')[0].split('?')[0].replace(/\/+$/, '') || '/'

  // 1. Exact path match
  if (articlesByPath[cleanPath]) {
    return articlesByPath[cleanPath]
  }

  // 2. Match by ending slug segment
  const segments = cleanPath.split('/').filter(Boolean)
  if (segments.length > 0) {
    const lastSegment = segments[segments.length - 1]
    for (const article of articles) {
      if (article.slug === lastSegment) {
        return article
      }
    }
  }

  return null
}

/**
 * Resolves the counterpart path for an article in another target locale
 */
export function getArticleCounterpartPath(currentPath: string, targetLocale: Locale): string | null {
  initializeContentRegistry()
  const article = findArticleByPath(currentPath)
  if (!article) return null

  const targetArticle = articlesById[article.id]?.[targetLocale]
  return targetArticle ? targetArticle.path : null
}

/**
 * Resolves an article ID into a localized path
 */
export function getArticlePathById(id: string, locale: Locale): string | null {
  initializeContentRegistry()
  const target = articlesById[id]?.[locale] || articlesById[`life_area_${id}`]?.[locale] || articlesById[`dimension_${id}`]?.[locale]
  return target ? target.path : null
}

/**
 * Primary composable for article view pages
 */
export function useArticleContent(slug: Ref<string> | string, locale: Ref<Locale> | Locale) {
  initializeContentRegistry()

  const currentSlug = computed(() => (typeof slug === 'string' ? slug : slug.value))
  const currentLocale = computed(() => (typeof locale === 'string' ? locale : locale.value))

  const article = computed<ArticleRecord | null>(() => {
    return findArticleBySlug(currentSlug.value, currentLocale.value)
  })

  const notFound = computed(() => !article.value)

  return {
    article,
    notFound,
    allArticles: articles
  }
}
