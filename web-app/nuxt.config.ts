import { fileURLToPath } from 'node:url'
import { createRequire } from 'node:module'

const require = createRequire(import.meta.url)
const { syncContentRoutes } = require('./scripts/sync-content-routes.cjs')

// Pre-synchronize content routes for sitemap and server routes
syncContentRoutes(fileURLToPath(new URL('.', import.meta.url)))

// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  devtools: { enabled: false },
  experimental: {
    appManifest: false
  },
  nitro: {
    preset: process.env.NITRO_PRESET || 'cloudflare-pages'
  },
  runtimeConfig: {
    siteUrl: process.env.SITE_URL || 'https://bonaloko.com',
    public: {
      siteUrl: process.env.NUXT_PUBLIC_SITE_URL || 'https://bonaloko.com',
      gaMeasurementId: process.env.NUXT_PUBLIC_GA_MEASUREMENT_ID || ''
    }
  },
  css: ['~/assets/css/main.css'],
  vite: {
    server: {
      fs: {
        allow: ['..']
      }
    }
  },
  hooks: {
    'pages:extend'(pages) {
      const indexPage = pages.find(p => p.path === '/')
      const aboutPage = pages.find(p => p.path === '/about')
      const missionPage = pages.find(p => p.path === '/mission')
      const slugPage = pages.find(p => p.path === '/:slug')
      const slugFile = slugPage?.file || fileURLToPath(new URL('./pages/[slug].vue', import.meta.url))

      if (indexPage) {
        pages.push(
          { name: 'index-pt-br', path: '/pt-br', file: indexPage.file },
          { name: 'index-eo', path: '/eo', file: indexPage.file }
        )
      }
      if (aboutPage) {
        pages.push(
          { name: 'about-pt-br', path: '/pt-br/sobre', file: aboutPage.file },
          { name: 'about-eo', path: '/eo/pri-ni', file: aboutPage.file }
        )
      }
      if (missionPage) {
        pages.push(
          { name: 'mission-pt-br', path: '/pt-br/missao', file: missionPage.file },
          { name: 'mission-eo', path: '/eo/misio', file: missionPage.file }
        )
      }
      // Dynamic Markdown Article Routes - Dimensions
      pages.push(
        { name: 'dimension-en', path: '/dimensions/:slug', file: slugFile },
        { name: 'dimension-pt-br', path: '/pt-br/dimensoes/:slug', file: slugFile },
        { name: 'dimension-eo', path: '/eo/dimensioj/:slug', file: slugFile }
      )
      // Dynamic Markdown Article Routes - Suggested Habits
      pages.push(
        { name: 'habit-en', path: '/suggested-habits/:slug', file: slugFile },
        { name: 'habit-pt-br', path: '/pt-br/habitos-sugeridos/:slug', file: slugFile },
        { name: 'habit-eo', path: '/eo/sugestitaj-kutimoj/:slug', file: slugFile }
      )
    }
  },
  app: {
    head: {
      title: 'Bona Loko — Habit & Life Balance',
      htmlAttrs: {
        lang: 'en-US'
      },
      meta: [
        { charset: 'utf-8' },
        { name: 'viewport', content: 'width=device-width, initial-scale=1' },
        {
          name: 'description',
          content: 'Bona Loko ("Good Place" in Esperanto) is an open-source personal development platform grounded in core values and a mentality focused in uncorruptibility, bridging holistic life assessment, multi-dimensional priorities, and sustainable daily habits.'
        },
        { name: 'theme-color', content: '#fcfbf7' }
      ],
      link: [
        { rel: 'icon', type: 'image/x-icon', href: '/favicon.ico' },
        { rel: 'icon', type: 'image/png', sizes: '32x32', href: '/favicon-32x32.png' },
        { rel: 'apple-touch-icon', href: '/apple-touch-icon.png' },
        { rel: 'preconnect', href: 'https://fonts.googleapis.com' },
        { rel: 'preconnect', href: 'https://fonts.gstatic.com', crossorigin: '' },
        {
          rel: 'stylesheet',
          href: 'https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&family=Outfit:wght@500;600;700;800&display=swap'
        }
      ]
    }
  }
})
