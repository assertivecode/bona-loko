// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: '2024-11-01',
  devtools: { enabled: false },
  experimental: {
    appManifest: false
  },
  css: ['~/assets/css/main.css'],
  hooks: {
    'pages:extend'(pages) {
      const indexPage = pages.find(p => p.path === '/')
      const aboutPage = pages.find(p => p.path === '/about')
      const missionPage = pages.find(p => p.path === '/mission')

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
