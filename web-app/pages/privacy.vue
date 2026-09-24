<template>
  <div class="privacy-page">
    <!-- Breadcrumb -->
    <nav class="breadcrumb-bar" aria-label="Breadcrumbs">
      <div class="container container-narrow">
        <ol class="breadcrumb-list">
          <li class="breadcrumb-item">
            <NuxtLink :to="localePath('home')">
              {{ t('breadcrumb.home') }}
            </NuxtLink>
          </li>
          <li class="breadcrumb-separator" aria-hidden="true">/</li>
          <li class="breadcrumb-item active" aria-current="page">
            {{ t('breadcrumb.privacy') }}
          </li>
        </ol>
      </div>
    </nav>

    <!-- Hero / Header -->
    <section class="privacy-hero section-subtle">
      <div class="container container-narrow text-center">
        <div class="badge badge-primary">
          🛡️ {{ t('hero.badge') }}
        </div>
        <h1>{{ t('hero.title') }}</h1>
        <p class="hero-intro">
          {{ t('hero.intro') }}
        </p>

        <div class="hero-meta">
          <span class="meta-tag">📅 {{ t('hero.lastUpdated') }}: <strong>2026-09-24</strong></span>
          <span class="meta-tag">🌐 {{ t('hero.coverage') }}</span>
        </div>
      </div>
    </section>

    <!-- Core Highlights / Overview Cards -->
    <section class="section-overview">
      <div class="container container-narrow">
        <div class="overview-grid">
          <!-- Direct Collection Card -->
          <div class="overview-card card">
            <div class="card-icon-badge icon-green">🔒</div>
            <h3>{{ t('cards.directTitle') }}</h3>
            <p>{{ t('cards.directDesc') }}</p>
            <div class="card-pill pill-success">{{ t('cards.directTag') }}</div>
          </div>

          <!-- Cloudflare Card -->
          <div class="overview-card card">
            <div class="card-icon-badge icon-orange">☁️</div>
            <h3>{{ t('cards.cloudflareTitle') }}</h3>
            <p>{{ t('cards.cloudflareDesc') }}</p>
            <div class="card-pill pill-info">{{ t('cards.cloudflareTag') }}</div>
          </div>

          <!-- Google Analytics Card -->
          <div class="overview-card card">
            <div class="card-icon-badge icon-blue">📊</div>
            <h3>{{ t('cards.googleTitle') }}</h3>
            <p>{{ t('cards.googleDesc') }}</p>
            <div class="card-pill pill-info">{{ t('cards.googleTag') }}</div>
          </div>
        </div>
      </div>
    </section>

    <!-- Main Markdown Document Content -->
    <main class="section-body">
      <div class="container container-narrow">
        <article class="privacy-prose card">
          <div class="markdown-render" v-html="renderedHtml"></div>
        </article>

        <!-- Stewardship / Open Source Footer Note -->
        <div class="privacy-footer-note card">
          <div class="footer-note-icon">🌱</div>
          <div class="footer-note-content">
            <h4>{{ t('stewardship.title') }}</h4>
            <p>{{ t('stewardship.desc') }}</p>
            <div class="footer-note-links">
              <NuxtLink :to="localePath('mission')" class="btn btn-sm btn-outline">
                {{ t('stewardship.missionLink') }} →
              </NuxtLink>
              <a
                href="https://github.com/assertivecode/bona-loko"
                target="_blank"
                rel="noopener noreferrer"
                class="btn btn-sm btn-outline"
              >
                GitHub ↗
              </a>
            </div>
          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { marked } from 'marked'
import { useHead } from '#app'
import { useComponentI18n, useLocalePath, useGlobalLocale } from '~/composables/useLocale'

// Build-time import of localized privacy markdown files
import enPrivacyRaw from '~/content/en-us/privacy.md?raw'
import ptPrivacyRaw from '~/content/pt-br/privacidade.md?raw'
import eoPrivacyRaw from '~/content/eo/privateco.md?raw'

const { currentLocale } = useGlobalLocale()
const { localePath } = useLocalePath()

// Component-Scoped Translation Dictionary (en-US, pt-BR, eo)
const privacyTranslations = {
  'en-US': {
    meta: {
      title: 'Privacy Policy & Data Sovereignty — Bona Loko',
      description: 'Understand how Bona Loko respects user privacy with zero direct data collection, and how Cloudflare and Google process generic technical information.'
    },
    breadcrumb: {
      home: 'Home',
      privacy: 'Privacy Policy'
    },
    hero: {
      badge: 'Data Sovereignty & Privacy',
      title: 'Privacy Policy',
      intro: 'Bona Loko is engineered for total privacy. We do not collect or store your personal reflections, scores, or habits, preserving full human autonomy.',
      lastUpdated: 'Effective Date',
      coverage: 'Web Platform & Mobile Application'
    },
    cards: {
      directTitle: 'Zero Direct Data Collection',
      directDesc: 'No account registration, no user database. Your life assessments, habits, and financial logs remain 100% on your device.',
      directTag: 'Zero Personal Data Collected',
      cloudflareTitle: 'Cloudflare Edge Infrastructure',
      cloudflareDesc: 'Processes technical network routing, security headers, and DDoS defense. IP is handled pseudonymously at the infrastructure layer.',
      cloudflareTag: 'Generic Technical Information',
      googleTitle: 'Google Analytics & Search',
      googleDesc: 'Measures aggregate site visits and discovery. No individual tracking, no advertising profiles, and no personal logs.',
      googleTag: 'Generic Aggregated Metrics'
    },
    stewardship: {
      title: 'Moral Bedrock & Open Source Transparency',
      desc: 'Our commitment to privacy is governed by the 7 Core Values (especially Integrity and Freedom). You are free to inspect our code or read our moral constitution.',
      missionLink: 'Platform Mission & Moral Constitution'
    }
  },
  'pt-BR': {
    meta: {
      title: 'Política de Privacidade & Soberania de Dados — Bona Loko',
      description: 'Entenda como a Bona Loko respeita a sua privacidade com zero coleta direta de dados e como Cloudflare e Google tratam informações técnicas genéricas.'
    },
    breadcrumb: {
      home: 'Início',
      privacy: 'Política de Privacidade'
    },
    hero: {
      badge: 'Soberania de Dados & Privacidade',
      title: 'Política de Privacidade',
      intro: 'A Bona Loko foi concebida para total privacidade. Não coletamos nem armazenamos suas notas, reflexões, finanças ou hábitos, preservando a sua soberania.',
      lastUpdated: 'Data de Vigência',
      coverage: 'Plataforma Web & Aplicativo Mobile'
    },
    cards: {
      directTitle: 'Zero Coleta Direta de Dados',
      directDesc: 'Sem necessidade de conta ou cadastro. Suas avaliações, hábitos e finanças permanecem 100% gravados no seu próprio aparelho.',
      directTag: 'Zero Dados Pessoais Coletados',
      cloudflareTitle: 'Infraestrutura de Borda Cloudflare',
      cloudflareDesc: 'Processa roteamento técnico, cabeçalhos de segurança e defesa contra ataques DDoS. O IP é tratado de forma pseudônima na camada de rede.',
      cloudflareTag: 'Informação Técnica Genérica',
      googleTitle: 'Google Analytics & Pesquisa Google',
      googleDesc: 'Mede acessos agregados e descoberta de páginas. Sem perfil publicitário, sem identificadores individuais e sem rastreamento de dados privados.',
      googleTag: 'Métricas Agregadas Genéricas'
    },
    stewardship: {
      title: 'Base Moral & Transparência em Código Aberto',
      desc: 'Nosso compromisso com a privacidade é regido pelos 7 Valores Fundamentais (especialmente Integridade e Liberdade). Você é bem-vindo a auditar o código.',
      missionLink: 'Missão da Plataforma & Constituição Moral'
    }
  },
  'eo': {
    meta: {
      title: 'Privateca Politiko & Datuma Suvereneco — Bona Loko',
      description: 'Komprenu kiel Bona Loko respektas vian privatecon per nula rekta datumkolektado kaj kiel Cloudflare kaj Google prilaboras ĝeneralajn teknikajn informojn.'
    },
    breadcrumb: {
      home: 'Ĉefpaĝo',
      privacy: 'Privateca Politiko'
    },
    hero: {
      badge: 'Datuma Suvereneco & Privateco',
      title: 'Privateca Politiko',
      intro: 'Bona Loko estas kreita por tuta privateco. Ni nek kolektas nek stokas viajn personajn pensojn, poentarojn aŭ kutimojn, plene respektante vian aŭtonomecon.',
      lastUpdated: 'Dato de Efikeco',
      coverage: 'Reteja Aplikaĵo & Poŝtelefona Apo'
    },
    cards: {
      directTitle: 'Nula Rekta Datumkolektado',
      directDesc: 'Neniu bezono de konto aŭ registriĝo. Viaj viv-taksadoj, financaj notoj kaj kutimoj restas 100% sur via propra aparato.',
      directTag: 'Nulaj Personaj Datumoj Kolektitaj',
      cloudflareTitle: 'Randa Infrastrukturo de Cloudflare',
      cloudflareDesc: 'Prilaboras teknikan ret-vojigon kaj defendon kontraŭ retatakoj. IP-adreso estas traktata pseŭdonime je reta tavolo.',
      cloudflareTag: 'Ĝenerala Teknika Informo',
      googleTitle: 'Google Analytics & Google-Serĉo',
      googleDesc: 'Mezuras nur sumigitajn vizitojn kaj trovon de paĝoj. Nenia individua spuro, neniaj reklamaj profiloj kaj neniaj personaj protokoloj.',
      googleTag: 'Ĝeneralaj Sumigitaj Metrikoj'
    },
    stewardship: {
      title: 'Morala Bazo & Malfermkoda Travidebleco',
      desc: 'Nia devontigo pri privateco estas gvidata de la 7 Kernaj Valoroj (speciale Integreco kaj Libereco). Vi bonvenas kontroli nian fontkodon.',
      missionLink: 'Platforma Misio & Morala Konstitucio'
    }
  }
}

const { t } = useComponentI18n(privacyTranslations)

// Select active raw markdown based on current locale
const activeRawMarkdown = computed(() => {
  if (currentLocale.value === 'pt-BR') return ptPrivacyRaw
  if (currentLocale.value === 'eo') return eoPrivacyRaw
  return enPrivacyRaw
})

// Parse markdown into HTML (stripping frontmatter block)
const renderedHtml = computed(() => {
  const raw = activeRawMarkdown.value
  const frontmatterRegex = /^---\r?\n[\s\S]*?\r?\n---\r?\n([\s\S]*)$/
  const match = raw.match(frontmatterRegex)
  const body = match ? match[1] : raw

  return marked.parse(body, {
    gfm: true,
    breaks: false
  }) as string
})

useHead({
  title: computed(() => t('meta.title')),
  meta: [
    {
      name: 'description',
      content: computed(() => t('meta.description'))
    },
    {
      property: 'og:title',
      content: computed(() => t('meta.title'))
    },
    {
      property: 'og:description',
      content: computed(() => t('meta.description'))
    },
    {
      property: 'og:type',
      content: 'article'
    }
  ]
})
</script>

<style scoped>
.privacy-page {
  background-color: var(--bg-canvas);
  min-height: 100vh;
}

/* Breadcrumb Bar */
.breadcrumb-bar {
  padding: 1rem 0;
  background-color: var(--bg-surface);
  border-bottom: 1px solid var(--border-subtle);
}

.breadcrumb-list {
  display: flex;
  align-items: center;
  gap: 0.5rem;
  list-style: none;
  font-size: 0.875rem;
  color: var(--text-muted);
}

.breadcrumb-item a {
  color: var(--text-secondary);
  text-decoration: none;
  transition: color var(--transition-fast);
}

.breadcrumb-item a:hover {
  color: var(--primary);
}

.breadcrumb-item.active {
  color: var(--primary);
  font-weight: 600;
}

.breadcrumb-separator {
  color: var(--border-strong);
}

/* Hero Section */
.privacy-hero {
  padding: 3.5rem 0 2.5rem;
  background-color: var(--bg-subtle);
  border-bottom: 1px solid var(--border-color);
}

.hero-intro {
  font-size: 1.125rem;
  color: var(--text-secondary);
  max-width: 680px;
  margin: 1rem auto 1.5rem;
  line-height: 1.6;
}

.hero-meta {
  display: flex;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
  font-size: 0.875rem;
}

.meta-tag {
  background-color: var(--bg-surface);
  border: 1px solid var(--border-color);
  padding: 0.4rem 0.85rem;
  border-radius: var(--radius-pill);
  color: var(--text-secondary);
}

/* Overview Cards */
.section-overview {
  padding: 2rem 0;
}

.overview-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.25rem;
}

@media (max-width: 820px) {
  .overview-grid {
    grid-template-columns: 1fr;
  }
}

.overview-card {
  padding: 1.5rem;
  display: flex;
  flex-direction: column;
  align-items: flex-start;
  gap: 0.75rem;
  border: 1px solid var(--border-color);
  background-color: var(--bg-surface);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
  transition: transform var(--transition-fast), box-shadow var(--transition-fast);
}

.overview-card:hover {
  transform: translateY(-2px);
  box-shadow: var(--shadow-md);
}

.card-icon-badge {
  font-size: 1.75rem;
  width: 48px;
  height: 48px;
  display: flex;
  align-items: center;
  justify-content: center;
  border-radius: var(--radius-md);
}

.icon-green {
  background-color: var(--secondary-light);
  border: 1px solid var(--secondary-border);
}

.icon-orange {
  background-color: var(--primary-light);
  border: 1px solid var(--primary-border);
}

.icon-blue {
  background-color: var(--tertiary-blue-light);
  border: 1px solid var(--tertiary-blue-border);
}

.overview-card h3 {
  font-family: var(--font-display);
  font-size: 1.1rem;
  font-weight: 700;
  color: var(--text-primary);
}

.overview-card p {
  font-size: 0.9rem;
  color: var(--text-secondary);
  line-height: 1.5;
  flex-grow: 1;
}

.card-pill {
  font-size: 0.75rem;
  font-weight: 700;
  padding: 0.25rem 0.65rem;
  border-radius: var(--radius-pill);
  text-transform: uppercase;
  letter-spacing: 0.5px;
}

.pill-success {
  background-color: var(--secondary-light);
  color: var(--secondary-active);
  border: 1px solid var(--secondary-border);
}

.pill-info {
  background-color: var(--tertiary-blue-light);
  color: var(--tertiary-blue);
  border: 1px solid var(--tertiary-blue-border);
}

/* Body / Prose */
.section-body {
  padding: 1rem 0 4rem;
}

.privacy-prose {
  padding: 2.5rem;
  background-color: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-xl);
  box-shadow: var(--shadow-sm);
  margin-bottom: 2rem;
}

@media (max-width: 640px) {
  .privacy-prose {
    padding: 1.5rem;
  }
}

/* Markdown prose rendering */
:deep(.markdown-render) {
  font-family: var(--font-body);
  color: var(--text-primary);
  line-height: 1.75;
}

:deep(.markdown-render h1) {
  font-family: var(--font-display);
  font-size: 2rem;
  font-weight: 800;
  color: var(--text-primary);
  margin-top: 0;
  margin-bottom: 1.5rem;
  border-bottom: 2px solid var(--border-subtle);
  padding-bottom: 0.75rem;
}

:deep(.markdown-render h2) {
  font-family: var(--font-display);
  font-size: 1.45rem;
  font-weight: 700;
  color: var(--text-primary);
  margin-top: 2.25rem;
  margin-bottom: 1rem;
  border-bottom: 1px solid var(--border-subtle);
  padding-bottom: 0.5rem;
}

:deep(.markdown-render h3) {
  font-family: var(--font-display);
  font-size: 1.15rem;
  font-weight: 700;
  color: var(--text-secondary);
  margin-top: 1.5rem;
  margin-bottom: 0.75rem;
}

:deep(.markdown-render p) {
  margin-bottom: 1.25rem;
  color: var(--text-secondary);
}

:deep(.markdown-render blockquote) {
  margin: 1.5rem 0;
  padding: 1rem 1.5rem;
  background-color: var(--bg-cream);
  border-left: 4px solid var(--primary);
  border-radius: 0 var(--radius-md) var(--radius-md) 0;
  font-style: italic;
  color: var(--text-primary);
}

:deep(.markdown-render blockquote p) {
  margin-bottom: 0;
}

:deep(.markdown-render ul),
:deep(.markdown-render ol) {
  margin-bottom: 1.25rem;
  padding-left: 1.5rem;
  color: var(--text-secondary);
}

:deep(.markdown-render li) {
  margin-bottom: 0.5rem;
}

:deep(.markdown-render hr) {
  border: 0;
  border-top: 1px solid var(--border-subtle);
  margin: 2.25rem 0;
}

:deep(.markdown-render table) {
  width: 100%;
  border-collapse: collapse;
  margin: 1.5rem 0 2rem;
  font-size: 0.875rem;
}

:deep(.markdown-render th) {
  background-color: var(--bg-subtle);
  color: var(--text-primary);
  font-weight: 700;
  text-align: left;
  padding: 0.75rem 1rem;
  border: 1px solid var(--border-color);
}

:deep(.markdown-render td) {
  padding: 0.75rem 1rem;
  border: 1px solid var(--border-color);
  color: var(--text-secondary);
}

:deep(.markdown-render tr:nth-child(even)) {
  background-color: var(--bg-cream);
}

:deep(.markdown-render a) {
  color: var(--primary);
  text-decoration: underline;
  text-underline-offset: 3px;
  font-weight: 500;
}

:deep(.markdown-render a:hover) {
  color: var(--primary-hover);
}

/* Stewardship note */
.privacy-footer-note {
  display: flex;
  align-items: flex-start;
  gap: 1.25rem;
  padding: 1.5rem;
  background-color: var(--bg-cream);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
}

.footer-note-icon {
  font-size: 2rem;
  line-height: 1;
}

.footer-note-content h4 {
  font-family: var(--font-display);
  font-size: 1.1rem;
  font-weight: 700;
  color: var(--text-primary);
  margin-bottom: 0.4rem;
}

.footer-note-content p {
  font-size: 0.9rem;
  color: var(--text-secondary);
  line-height: 1.5;
  margin-bottom: 1rem;
}

.footer-note-links {
  display: flex;
  gap: 0.75rem;
  flex-wrap: wrap;
}
</style>
