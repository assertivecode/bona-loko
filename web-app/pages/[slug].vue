<template>
  <div v-if="article" class="dimension-page">
    <!-- Breadcrumb & Sub-nav -->
    <nav class="breadcrumb-bar" aria-label="Breadcrumbs">
      <div class="container container-wide">
        <ol class="breadcrumb-list">
          <li class="breadcrumb-item">
            <NuxtLink :to="localePath('home')">
              {{ t('breadcrumb.home') }}
            </NuxtLink>
          </li>
          <li class="breadcrumb-separator" aria-hidden="true">/</li>
          <li class="breadcrumb-item">
            <NuxtLink :to="localePath('home') + '#life-areas'">
              {{ t('breadcrumb.areas') }}
            </NuxtLink>
          </li>
          <li class="breadcrumb-separator" aria-hidden="true">/</li>
          <li class="breadcrumb-item active" aria-current="page">
            {{ frontmatter.title || t('dimension.defaultTitle') }}
          </li>
        </ol>
      </div>
    </nav>

    <!-- Hero Header -->
    <header class="dimension-hero">
      <div class="container container-wide">
        <div class="hero-header-content">
          <div class="badge-group">
            <span v-if="areaPillText" class="badge badge-primary">
              {{ areaPillText }}
            </span>
            <span v-if="frontmatter.category" class="badge badge-teal">
              {{ frontmatter.category }}
            </span>
            <span class="reading-time-pill">
              ⏱️ {{ frontmatter.reading_time || t('reading_time') }}
            </span>
          </div>

          <h1 class="dimension-title">
            {{ frontmatter.title }}
          </h1>

          <div v-if="frontmatter.summary" class="summary-card card">
            <div class="summary-icon" aria-hidden="true">💡</div>
            <div class="summary-body">
              <span class="summary-label">{{ t('summary_label') }}</span>
              <p class="summary-text">{{ frontmatter.summary }}</p>
            </div>
          </div>

          <div class="hero-meta-bar">
            <div class="meta-item">
              <span class="meta-icon">📅</span>
              <span class="meta-text">
                {{ t('last_updated') }}: <strong>{{ frontmatter.last_updated }}</strong>
              </span>
            </div>
            <div class="meta-actions">
              <button
                type="button"
                class="btn-copy-link"
                :title="t('copy_link')"
                @click="copyPageUrl"
              >
                <svg width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <rect width="14" height="14" x="8" y="8" rx="2" ry="2"/>
                  <path d="M4 16c-1.1 0-2-.9-2-2V4c0-1.1.9-2 2-2h10c1.1 0 2 .9 2 2"/>
                </svg>
                <span>{{ copied ? t('link_copied') : t('copy_link') }}</span>
              </button>
            </div>
          </div>
        </div>
      </div>
    </header>

    <!-- Mobile Table of Contents Accordion -->
    <section v-if="tocItems.length > 0" class="mobile-toc-section container container-wide">
      <details class="mobile-toc-details card">
        <summary class="mobile-toc-summary">
          <span class="toc-summary-icon">📑</span>
          <span class="toc-summary-title">{{ t('toc.title') }}</span>
          <span class="toc-badge">{{ tocItems.length }} {{ t('toc.sections') }}</span>
          <svg class="summary-arrow" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <polyline points="6 9 12 15 18 9"></polyline>
          </svg>
        </summary>
        <nav class="mobile-toc-nav" aria-label="Mobile Table of Contents">
          <ul>
            <li v-for="item in tocItems" :key="'mob-' + item.id" :class="['toc-level-' + item.level]">
              <a :href="'#' + item.id" @click="handleTocClick">
                {{ item.text }}
              </a>
            </li>
          </ul>
        </nav>
      </details>
    </section>

    <!-- Article Content + Desktop Sidebar -->
    <main class="dimension-body">
      <div class="container container-wide">
        <div class="dimension-layout-grid">
          <!-- Main Markdown Article Column -->
          <article class="dimension-prose card">
            <div class="markdown-render" v-html="renderedHtml"></div>
          </article>

          <!-- Desktop Sticky Sidebar -->
          <aside class="dimension-sidebar">
            <!-- Table of Contents Widget -->
            <div v-if="tocItems.length > 0" class="sidebar-widget card toc-widget">
              <div class="widget-header">
                <span class="widget-icon">📑</span>
                <h3>{{ t('toc.title') }}</h3>
              </div>
              <nav class="toc-nav" aria-label="Table of Contents">
                <ul>
                  <li
                    v-for="item in tocItems"
                    :key="item.id"
                    :class="[
                      'toc-item',
                      'toc-level-' + item.level,
                      { 'is-active': activeHeadingId === item.id }
                    ]"
                  >
                    <a :href="'#' + item.id" @click="handleTocClick">
                      {{ item.text }}
                    </a>
                  </li>
                </ul>
              </nav>
            </div>

            <!-- Dynamic Pillars Overview Widget (when declared in frontmatter) -->
            <div v-if="pillars.length > 0" class="sidebar-widget card pillars-widget">
              <div class="widget-header">
                <span class="widget-icon">🧬</span>
                <h3>{{ t('pillars_widget.title') }}</h3>
              </div>
              <ul class="pillars-mini-list">
                <li v-for="(pillar, idx) in pillars" :key="idx">
                  <span class="pillar-emoji">{{ pillar.emoji || '✨' }}</span>
                  <div>
                    <strong>{{ pillar.title }}</strong>
                    <p>{{ pillar.desc }}</p>
                  </div>
                </li>
              </ul>
            </div>

            <!-- Moral Grounding Widget -->
            <div class="sidebar-widget card values-widget">
              <div class="widget-header">
                <span class="widget-icon">🛡️</span>
                <h3>{{ t('values_widget.title') }}</h3>
              </div>
              <p class="values-widget-text">
                {{ t('values_widget.desc') }}
              </p>
              <NuxtLink :to="localePath('mission') + '#guardrails'" class="widget-link">
                {{ t('values_widget.link') }} →
              </NuxtLink>
            </div>
          </aside>
        </div>
      </div>
    </main>

    <!-- Bottom Navigation & CTA Banner -->
    <section class="dimension-footer-nav section-subtle">
      <div class="container container-wide">
        <div class="footer-nav-card card">
          <div class="footer-nav-lead">
            <span class="footer-badge">🌟 {{ t('footer_nav.badge') }}</span>
            <h2>{{ t('footer_nav.title') }}</h2>
            <p>{{ t('footer_nav.desc') }}</p>
          </div>
          <div class="footer-nav-actions">
            <NuxtLink :to="localePath('home') + '#life-areas'" class="btn btn-primary btn-lg">
              <span>← {{ t('back_to_areas') }}</span>
            </NuxtLink>
            <NuxtLink :to="localePath('mission')" class="btn btn-outline btn-lg">
              <span>{{ t('explore_mission') }} →</span>
            </NuxtLink>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRoute } from 'vue-router'
import { useHead, createError } from '#app'
import { marked } from 'marked'
import { useComponentI18n, useLocalePath } from '~/composables/useLocale'
import { useArticleContent } from '~/composables/useArticleContent'

interface TocItem {
  id: string
  text: string
  level: number
}

// In-Component Translation Dictionary (en-US, pt-BR, eo)
const dimensionTranslations = {
  'en-US': {
    meta: {
      title: 'Life Area Guide — Bona Loko',
      description: 'A foundational life area guide grounded in core values and sustainable habit design.'
    },
    dimension: {
      defaultTitle: 'Life Area Guide'
    },
    breadcrumb: {
      home: 'Home',
      areas: 'Life Areas'
    },
    reading_time: '8 min read',
    last_updated: 'Updated',
    category: 'Vitality',
    area_prefix: 'Area #',
    summary_label: 'Executive Summary',
    copy_link: 'Copy Link',
    link_copied: 'Copied!',
    back_to_areas: 'All 12 Life Areas',
    explore_mission: 'Platform Mission & Values',
    toc: {
      title: 'Table of Contents',
      sections: 'sections'
    },
    pillars_widget: {
      title: 'The Vitality Pillars'
    },
    values_widget: {
      title: 'Grounded in Core Values',
      desc: 'Physical vitality and life balance are protected with gratitude, humility, integrity, empathy, and responsible freedom.',
      link: 'Explore Moral Constitution'
    },
    footer_nav: {
      badge: 'Holistic Balance',
      title: 'Continue Exploring Your Life Architecture',
      desc: 'Discover all 12 interconnected life areas to diagnose your priority gaps and establish keystone daily habits.'
    }
  },
  'pt-BR': {
    meta: {
      title: 'Guia de Área da Vida — Bona Loko',
      description: 'Um guia fundamental de área da vida ancorado em valores essenciais e design de hábitos sustentáveis.'
    },
    dimension: {
      defaultTitle: 'Guia de Área da Vida'
    },
    breadcrumb: {
      home: 'Início',
      areas: 'Áreas da Vida'
    },
    reading_time: '8 min de leitura',
    last_updated: 'Atualizado em',
    category: 'Vitalidade',
    area_prefix: 'Área #',
    summary_label: 'Sumário Executivo',
    copy_link: 'Copiar Link',
    link_copied: 'Copiado!',
    back_to_areas: 'Todas as 12 Áreas',
    explore_mission: 'Missão e Valores',
    toc: {
      title: 'Sumário do Guia',
      sections: 'seções'
    },
    pillars_widget: {
      title: 'Os Pilares da Vitalidade'
    },
    values_widget: {
      title: 'Ancorado em Valores',
      desc: 'A vitalidade física e o equilíbrio são cultivados com gratidão, humildade, integridade, empatia e liberdade responsável.',
      link: 'Conheça a Constituição Moral'
    },
    footer_nav: {
      badge: 'Equilíbrio Holístico',
      title: 'Continue Explorando Sua Arquitetura de Vida',
      desc: 'Descubra todas as 12 áreas conectadas para diagnosticar suas lacunas de prioridade e criar hábitos duradouros.'
    }
  },
  'eo': {
    meta: {
      title: 'Gvidilo pri Vivfako — Bona Loko',
      description: 'Fundamenta vivfaka gvidilo enradikigita en moralaj valoroj kaj daŭripova kutim-dezajno.'
    },
    dimension: {
      defaultTitle: 'Gvidilo pri Vivfako'
    },
    breadcrumb: {
      home: 'Ĉefpaĝo',
      areas: 'Vivfakoj'
    },
    reading_time: '8 min da legado',
    last_updated: 'Ĝisdatigita je',
    category: 'Vigleco',
    area_prefix: 'Fako #',
    summary_label: 'Ĉefresumo',
    copy_link: 'Kopii ligilon',
    link_copied: 'Kopiita!',
    back_to_areas: 'Ĉiuj 12 Vivfakoj',
    explore_mission: 'Misiaj & Moralaj Valoroj',
    toc: {
      title: 'Enhavtabelo',
      sections: 'sekcioj'
    },
    pillars_widget: {
      title: 'La Kolonoj de Vigleco'
    },
    values_widget: {
      title: 'Enradikigita en Valoroj',
      desc: 'Fizika vigleco kaj viv-ekvilibro estas flegataj per dankemo, humileco, integreco, empatio kaj respondeca libereco.',
      link: 'Malkovru Moralan Konstitucion'
    },
    footer_nav: {
      badge: 'Holistika Ekvilibro',
      title: 'Daŭrigu Esplori Vian Vivan Arkitekturon',
      desc: 'Esploru ĉiujn 12 interligitajn fakojn por diagnozi prioritatajn mankojn kaj krei ĉiutagajn kutimojn.'
    }
  }
}

const { t, currentLocale } = useComponentI18n(dimensionTranslations)
const { localePath } = useLocalePath()
const route = useRoute()

// Extract active slug from route params or path segment
const routeSlug = computed(() => {
  const paramSlug = route.params.slug
  if (Array.isArray(paramSlug)) return paramSlug.join('/')
  if (typeof paramSlug === 'string' && paramSlug) return paramSlug

  // Fallback: extract last segment of path
  const segments = route.path.split('/').filter(Boolean)
  return segments.length > 0 ? segments[segments.length - 1] : ''
})

// Dynamic Article Discovery
const { article, notFound } = useArticleContent(routeSlug, currentLocale)

// Handle 404 cleanly
if (notFound.value && import.meta.server) {
  throw createError({
    statusCode: 404,
    statusMessage: 'Dimension article not found',
    fatal: true
  })
}

// Frontmatter & Pillars
const frontmatter = computed(() => article.value?.frontmatter || {})
const markdownBody = computed(() => article.value?.markdownBody || '')
const pillars = computed(() => frontmatter.value.pillars || [])
const tags = computed(() => frontmatter.value.tags || [])

// Formatted Area Pill e.g. "Area #01"
const areaPillText = computed(() => {
  const idx = frontmatter.value.area_index
  if (idx === undefined || idx === null) return ''
  const numStr = String(idx).padStart(2, '0')
  return `${t('area_prefix')}${numStr}`
})

// Dynamic browser tab title & SEO meta
useHead({
  title: computed(() => {
    return frontmatter.value.title
      ? `${frontmatter.value.title} — Bona Loko`
      : t('meta.title')
  }),
  meta: [
    {
      name: 'description',
      content: computed(() => frontmatter.value.summary || t('meta.description'))
    },
    {
      name: 'keywords',
      content: computed(() => tags.value.join(', '))
    },
    {
      property: 'article:tag',
      content: computed(() => tags.value.join(', '))
    }
  ]
})

// Helper to generate clean slug IDs from heading strings
function slugifyHeading(text: string): string {
  return text
    .toLowerCase()
    .replace(/[^\w\s-]/g, '')
    .trim()
    .replace(/\s+/g, '-')
}

// Extracted Table of Contents items
const tocItems = computed<TocItem[]>(() => {
  const lines = markdownBody.value.split('\n')
  const items: TocItem[] = []

  for (const line of lines) {
    const match = line.match(/^(#{2,3})\s+(.*)$/)
    if (match) {
      const level = match[1].length
      const rawTitle = match[2].trim()
      const cleanText = rawTitle.replace(/\*\*/g, '').replace(/\[([^\]]+)\]\([^)]+\)/g, '$1')
      const id = slugifyHeading(cleanText)
      items.push({ id, text: cleanText, level })
    }
  }

  return items
})

// Formats LaTeX math equation blocks into stylized UI banners
function formatMathBlocks(content: string): string {
  return content.replace(/\$\$([\s\S]*?)\$\$/g, (_, eq) => {
    const clean = eq
      .replace(/\\text\{([^}]+)\}/g, '$1')
      .replace(/\\longrightarrow/g, '→')
      .replace(/\\rightarrow/g, '→')
      .trim()
    const steps = clean.split('→').map((step: string) => `<span class="formula-step">${step.trim()}</span>`)
    return `<div class="formula-banner"><div class="formula-title">Priority Diagnostic Model</div><div class="formula-flow">${steps.join('<span class="formula-arrow">→</span>')}</div></div>\n\n`
  })
}

// Transform internal repo links to proper web-app routes
function normalizeLinks(content: string): string {
  return content.replace(/\[([^\]]+)\]\((?:\.\.\/\.\.\/\.\.\/FOUNDATION\.md|FOUNDATION\.md)\)/g, (match, text) => {
    return `[${text}](/mission#guardrails)`
  })
}

// Compiled HTML string via Marked
const renderedHtml = computed(() => {
  if (!markdownBody.value) return ''

  const customRenderer = new marked.Renderer()

  // Headings with anchor links
  customRenderer.heading = function({ tokens, depth, raw }) {
    const text = this.parser.parseInline(tokens)
    const id = slugifyHeading(raw)
    return `<h${depth} id="${id}" class="heading-anchor"><a href="#${id}" class="anchor-link" aria-label="Link to section">#</a><span>${text}</span></h${depth}>\n`
  }

  // Responsive Table wrapper
  customRenderer.table = function(token) {
    const header = token.header.map(cell => `<th>${this.parser.parseInline(cell.tokens)}</th>`).join('')
    const rows = token.rows
      .map(row => `<tr>${row.map(cell => `<td>${this.parser.parseInline(cell.tokens)}</td>`).join('')}</tr>`)
      .join('\n')
    return `<div class="table-responsive"><table class="markdown-table"><thead><tr>${header}</tr></thead><tbody>${rows}</tbody></table></div>\n`
  }

  // Blockquotes with decorative badge
  customRenderer.blockquote = function({ tokens }) {
    const body = this.parser.parse(tokens)
    return `<blockquote class="styled-blockquote"><div class="quote-badge">“</div><div class="quote-content">${body}</div></blockquote>\n`
  }

  // Preformatted Code Blocks with Diagram Tagging
  customRenderer.code = function({ text, lang }) {
    const isDiagram = text.includes('┌') || text.includes('│') || text.includes('─') || text.includes('▲') || text.includes('▼')
    const badgeHtml = isDiagram ? `<div class="code-badge">📐 Diagram Architecture</div>` : ''
    return `<div class="code-block-wrapper ${isDiagram ? 'is-diagram' : ''}">${badgeHtml}<pre><code>${text}</code></pre></div>\n`
  }

  // Links
  customRenderer.link = function({ href, title, tokens }) {
    const text = this.parser.parseInline(tokens)
    const isExternal = href.startsWith('http')
    const target = isExternal ? ' target="_blank" rel="noopener noreferrer"' : ''
    const titleAttr = title ? ` title="${title}"` : ''
    return `<a href="${href}" class="prose-link"${titleAttr}${target}>${text}${isExternal ? ' ↗' : ''}</a>`
  }

  marked.use({
    renderer: customRenderer,
    gfm: true,
    breaks: false
  })

  let prepared = normalizeLinks(markdownBody.value)
  prepared = formatMathBlocks(prepared)

  return marked.parse(prepared) as string
})

// Active Section Tracking via IntersectionObserver
const activeHeadingId = ref<string>('')
let observer: IntersectionObserver | null = null

const handleTocClick = (event: MouseEvent) => {
  const target = event.currentTarget as HTMLAnchorElement
  if (target && target.hash) {
    const el = document.querySelector(target.hash)
    if (el) {
      event.preventDefault()
      el.scrollIntoView({ behavior: 'smooth', block: 'start' })
      history.pushState(null, '', target.hash)
      activeHeadingId.value = target.hash.slice(1)
    }
  }
}

// Copy URL to Clipboard
const copied = ref(false)
const copyPageUrl = async () => {
  if (import.meta.client && navigator?.clipboard) {
    try {
      await navigator.clipboard.writeText(window.location.href)
      copied.value = true
      setTimeout(() => {
        copied.value = false
      }, 2500)
    } catch {
      // ignore
    }
  }
}

onMounted(() => {
  if (import.meta.client) {
    const headings = document.querySelectorAll('.markdown-render h2, .markdown-render h3')
    if (headings.length > 0) {
      observer = new IntersectionObserver(
        (entries) => {
          entries.forEach(entry => {
            if (entry.isIntersecting) {
              activeHeadingId.value = entry.target.id
            }
          })
        },
        { rootMargin: '-100px 0px -65% 0px' }
      )
      headings.forEach(h => observer?.observe(h))
    }
  }
})

onUnmounted(() => {
  if (observer) {
    observer.disconnect()
  }
})
</script>

<style scoped>
.dimension-page {
  padding-bottom: 80px;
  background-color: var(--bg-canvas);
}

/* Breadcrumbs */
.breadcrumb-bar {
  padding: 16px 0;
  border-bottom: 1px solid var(--border-subtle);
  background: var(--bg-surface);
}

.breadcrumb-list {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  list-style: none;
  gap: 8px;
  font-size: 0.875rem;
}

.breadcrumb-item a {
  color: var(--text-muted);
  text-decoration: none;
  font-weight: 500;
  transition: color var(--transition-fast);
}

.breadcrumb-item a:hover {
  color: var(--primary);
}

.breadcrumb-item.active {
  color: var(--text-primary);
  font-weight: 600;
}

.breadcrumb-separator {
  color: var(--border-strong);
  font-size: 0.8rem;
}

/* Hero Section */
.dimension-hero {
  padding: 48px 0 36px;
  background: linear-gradient(180deg, var(--bg-surface) 0%, var(--bg-canvas) 100%);
  border-bottom: 1px solid var(--border-subtle);
}

.hero-header-content {
  max-width: 960px;
}

.badge-group {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 10px;
  margin-bottom: 20px;
}

.badge-teal {
  background-color: var(--secondary-light);
  color: var(--secondary);
  border: 1px solid var(--secondary-border);
}

.reading-time-pill {
  font-size: 0.8125rem;
  font-weight: 500;
  color: var(--text-muted);
  background: var(--bg-subtle);
  padding: 4px 12px;
  border-radius: var(--radius-pill);
  border: 1px solid var(--border-subtle);
}

.dimension-title {
  font-size: clamp(2.2rem, 4.5vw, 3.4rem);
  line-height: 1.15;
  margin-bottom: 24px;
  color: var(--text-primary);
}

/* Executive Summary Card */
.summary-card {
  display: flex;
  align-items: flex-start;
  gap: 16px;
  padding: 24px;
  background: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-left: 5px solid var(--primary);
  border-radius: var(--radius-md);
  margin-bottom: 28px;
  box-shadow: var(--shadow-sm);
}

.summary-icon {
  font-size: 1.75rem;
  line-height: 1;
  flex-shrink: 0;
}

.summary-label {
  display: block;
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  color: var(--primary);
  margin-bottom: 6px;
}

.summary-text {
  font-size: 1.05rem;
  line-height: 1.6;
  color: var(--text-secondary);
  margin: 0;
}

/* Hero Meta Bar */
.hero-meta-bar {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 16px;
  font-size: 0.875rem;
  color: var(--text-muted);
}

.meta-item {
  display: flex;
  align-items: center;
  gap: 8px;
}

.btn-copy-link {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  padding: 6px 14px;
  font-size: 0.8125rem;
  font-weight: 600;
  background: var(--bg-surface);
  color: var(--text-secondary);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  cursor: pointer;
  transition: all var(--transition-fast);
}

.btn-copy-link:hover {
  background: var(--bg-subtle);
  color: var(--primary);
  border-color: var(--primary-border);
}

/* Mobile TOC Accordion */
.mobile-toc-section {
  display: none;
  margin-top: 24px;
}

.mobile-toc-details {
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  background: var(--bg-surface);
  overflow: hidden;
}

.mobile-toc-summary {
  display: flex;
  align-items: center;
  padding: 16px 20px;
  cursor: pointer;
  font-weight: 600;
  gap: 10px;
  list-style: none;
  user-select: none;
}

.mobile-toc-summary::-webkit-details-marker {
  display: none;
}

.toc-summary-icon {
  font-size: 1.1rem;
}

.toc-summary-title {
  flex: 1;
  color: var(--text-primary);
}

.toc-badge {
  font-size: 0.75rem;
  background: var(--bg-subtle);
  padding: 2px 8px;
  border-radius: var(--radius-pill);
  color: var(--text-muted);
}

.summary-arrow {
  transition: transform var(--transition-fast);
}

.mobile-toc-details[open] .summary-arrow {
  transform: rotate(180deg);
}

.mobile-toc-nav {
  padding: 12px 20px 20px;
  border-top: 1px solid var(--border-subtle);
}

.mobile-toc-nav ul {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 10px;
}

.mobile-toc-nav a {
  color: var(--text-secondary);
  text-decoration: none;
  font-size: 0.9375rem;
}

.mobile-toc-nav .toc-level-3 {
  padding-left: 16px;
  font-size: 0.875rem;
}

/* Main Layout Grid */
.dimension-body {
  padding-top: 40px;
}

.dimension-layout-grid {
  display: grid;
  grid-template-columns: 1fr;
  gap: 36px;
}

@media (min-width: 1024px) {
  .dimension-layout-grid {
    grid-template-columns: minmax(0, 1fr) 340px;
    align-items: start;
  }
}

/* Article Prose */
.dimension-prose {
  padding: 40px 48px;
  background: var(--bg-surface);
  line-height: 1.8;
  font-size: 1.0625rem;
  color: var(--text-primary);
}

/* Deep Markdown Formatting */
.markdown-render :deep(h1) {
  display: none; /* Already rendered in Hero Header */
}

.markdown-render :deep(h2) {
  font-size: 1.85rem;
  line-height: 1.3;
  margin-top: 48px;
  margin-bottom: 20px;
  padding-bottom: 12px;
  border-bottom: 2px solid var(--border-subtle);
  color: var(--text-primary);
}

.markdown-render :deep(h3) {
  font-size: 1.35rem;
  line-height: 1.4;
  margin-top: 32px;
  margin-bottom: 14px;
  color: var(--text-primary);
}

.markdown-render :deep(p) {
  margin-bottom: 20px;
  color: var(--text-secondary);
}

.markdown-render :deep(ul),
.markdown-render :deep(ol) {
  margin-bottom: 24px;
  padding-left: 28px;
  color: var(--text-secondary);
}

.markdown-render :deep(li) {
  margin-bottom: 8px;
}

.markdown-render :deep(strong) {
  color: var(--text-primary);
  font-weight: 600;
}

.markdown-render :deep(hr) {
  border: none;
  border-top: 1px solid var(--border-subtle);
  margin: 40px 0;
}

/* Anchor Headings */
.markdown-render :deep(.heading-anchor) {
  position: relative;
  scroll-margin-top: 90px;
}

.markdown-render :deep(.anchor-link) {
  position: absolute;
  left: -28px;
  opacity: 0;
  color: var(--primary);
  text-decoration: none;
  font-weight: 400;
  transition: opacity var(--transition-fast);
}

.markdown-render :deep(.heading-anchor:hover .anchor-link) {
  opacity: 1;
}

/* Styled Blockquotes */
.markdown-render :deep(.styled-blockquote) {
  position: relative;
  display: flex;
  gap: 16px;
  margin: 32px 0;
  padding: 24px 28px;
  background: var(--primary-light);
  border-left: 4px solid var(--primary);
  border-radius: var(--radius-md);
  color: var(--text-primary);
  font-style: italic;
}

.markdown-render :deep(.quote-badge) {
  font-size: 2.4rem;
  line-height: 1;
  color: var(--primary);
  font-family: serif;
  opacity: 0.6;
}

.markdown-render :deep(.quote-content p) {
  margin: 0;
  color: var(--text-primary);
}

/* Responsive Table Styling */
.markdown-render :deep(.table-responsive) {
  overflow-x: auto;
  margin: 28px 0;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  background: var(--bg-surface);
}

.markdown-render :deep(.markdown-table) {
  width: 100%;
  border-collapse: collapse;
  text-align: left;
  font-size: 0.9375rem;
}

.markdown-render :deep(.markdown-table th) {
  background: var(--bg-subtle);
  padding: 12px 16px;
  font-weight: 600;
  color: var(--text-primary);
  border-bottom: 1px solid var(--border-color);
}

.markdown-render :deep(.markdown-table td) {
  padding: 12px 16px;
  border-bottom: 1px solid var(--border-subtle);
  color: var(--text-secondary);
}

.markdown-render :deep(.markdown-table tr:last-child td) {
  border-bottom: none;
}

.markdown-render :deep(.markdown-table tr:hover td) {
  background: rgba(0, 0, 0, 0.015);
}

/* Code & Architecture Diagrams */
.markdown-render :deep(.code-block-wrapper) {
  position: relative;
  margin: 28px 0;
  background: var(--bg-subtle);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  overflow-x: auto;
}

.markdown-render :deep(.code-block-wrapper.is-diagram) {
  background: #1e1e24;
  border-color: #33333f;
  color: #a5d6a7;
  box-shadow: var(--shadow-sm);
}

.markdown-render :deep(.code-badge) {
  position: absolute;
  top: 10px;
  right: 12px;
  font-size: 0.6875rem;
  font-weight: 700;
  letter-spacing: 0.06em;
  text-transform: uppercase;
  color: #81c784;
  background: rgba(255, 255, 255, 0.1);
  padding: 3px 8px;
  border-radius: 4px;
}

.markdown-render :deep(pre) {
  padding: 20px 24px;
  font-family: 'Courier New', Courier, monospace;
  font-size: 0.9rem;
  line-height: 1.5;
  margin: 0;
}

.markdown-render :deep(.code-block-wrapper.is-diagram pre code) {
  color: #c8e6c9;
}

/* Formula Banner */
.markdown-render :deep(.formula-banner) {
  margin: 28px 0;
  padding: 20px 24px;
  background: linear-gradient(135deg, rgba(200, 90, 50, 0.06) 0%, rgba(200, 90, 50, 0.02) 100%);
  border: 1px dashed var(--primary-border);
  border-radius: var(--radius-md);
  text-align: center;
}

.markdown-render :deep(.formula-title) {
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  color: var(--primary);
  margin-bottom: 12px;
}

.markdown-render :deep(.formula-flow) {
  display: flex;
  align-items: center;
  justify-content: center;
  flex-wrap: wrap;
  gap: 8px;
  font-weight: 600;
  color: var(--text-primary);
}

.markdown-render :deep(.formula-step) {
  background: var(--bg-surface);
  padding: 6px 14px;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  box-shadow: var(--shadow-sm);
  font-size: 0.9375rem;
}

.markdown-render :deep(.formula-arrow) {
  color: var(--primary);
  font-weight: bold;
}

/* Prose Links */
.markdown-render :deep(.prose-link) {
  color: var(--primary);
  text-decoration: underline;
  text-underline-offset: 3px;
  font-weight: 500;
  transition: color var(--transition-fast);
}

.markdown-render :deep(.prose-link:hover) {
  color: var(--primary-hover);
}

/* Sticky Desktop Sidebar */
.dimension-sidebar {
  display: flex;
  flex-direction: column;
  gap: 24px;
  position: sticky;
  top: 84px;
}

.sidebar-widget {
  padding: 24px;
  background: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  box-shadow: var(--shadow-sm);
}

.widget-header {
  display: flex;
  align-items: center;
  gap: 8px;
  margin-bottom: 16px;
  padding-bottom: 12px;
  border-bottom: 1px solid var(--border-subtle);
}

.widget-icon {
  font-size: 1.2rem;
}

.widget-header h3 {
  font-size: 1.05rem;
  color: var(--text-primary);
  margin: 0;
}

/* Desktop TOC Widget */
.toc-nav ul {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 8px;
  max-height: 380px;
  overflow-y: auto;
  padding-right: 4px;
}

.toc-item a {
  display: block;
  font-size: 0.875rem;
  color: var(--text-muted);
  text-decoration: none;
  padding: 4px 8px;
  border-radius: 4px;
  transition: all var(--transition-fast);
}

.toc-item a:hover {
  color: var(--primary);
  background: var(--bg-subtle);
}

.toc-level-3 {
  padding-left: 14px;
}

.toc-level-3 a {
  font-size: 0.8125rem;
}

.toc-item.is-active a {
  color: var(--primary);
  background: var(--primary-light);
  font-weight: 600;
}

/* Pillars Widget */
.pillars-mini-list {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 14px;
}

.pillars-mini-list li {
  display: flex;
  align-items: flex-start;
  gap: 12px;
}

.pillar-emoji {
  font-size: 1.25rem;
  line-height: 1.2;
}

.pillars-mini-list strong {
  display: block;
  font-size: 0.875rem;
  color: var(--text-primary);
  margin-bottom: 2px;
}

.pillars-mini-list p {
  font-size: 0.8125rem;
  color: var(--text-muted);
  line-height: 1.4;
  margin: 0;
}

/* Values Widget */
.values-widget-text {
  font-size: 0.875rem;
  color: var(--text-secondary);
  line-height: 1.5;
  margin-bottom: 14px;
}

.widget-link {
  display: inline-flex;
  font-size: 0.8125rem;
  font-weight: 600;
  color: var(--primary);
  text-decoration: none;
}

.widget-link:hover {
  text-decoration: underline;
}

/* Footer Banner */
.dimension-footer-nav {
  margin-top: 64px;
  padding: 56px 0;
  background: var(--bg-surface);
  border-top: 1px solid var(--border-color);
}

.footer-nav-card {
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  gap: 32px;
  padding: 40px;
  background: linear-gradient(135deg, var(--bg-canvas) 0%, var(--bg-subtle) 100%);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
}

.footer-nav-lead {
  max-width: 600px;
}

.footer-badge {
  display: inline-block;
  font-size: 0.75rem;
  font-weight: 700;
  text-transform: uppercase;
  letter-spacing: 0.08em;
  color: var(--primary);
  margin-bottom: 10px;
}

.footer-nav-lead h2 {
  font-size: 1.65rem;
  margin-bottom: 12px;
  color: var(--text-primary);
}

.footer-nav-lead p {
  color: var(--text-secondary);
  font-size: 1.05rem;
  margin: 0;
}

.footer-nav-actions {
  display: flex;
  align-items: center;
  flex-wrap: wrap;
  gap: 16px;
}

/* Mobile Responsiveness */
@media (max-width: 1023px) {
  .mobile-toc-section {
    display: block;
  }

  .dimension-sidebar {
    display: none;
  }

  .dimension-prose {
    padding: 24px 20px;
  }

  .footer-nav-card {
    padding: 28px 24px;
    flex-direction: column;
    align-items: flex-start;
  }
}
</style>
