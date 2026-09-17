import { defineNuxtRouteMiddleware } from '#app'
import { useGlobalLocale, ROUTE_SLUGS, type Locale } from '~/composables/useLocale'

export default defineNuxtRouteMiddleware((to) => {
  const { setLocale, currentLocale } = useGlobalLocale()
  const path = to.path.replace(/\/+$/, '') || '/'

  // Detect language from URL path
  let detectedLocale: Locale | null = null

  if (path.startsWith('/pt-br')) {
    detectedLocale = 'pt-BR'
  } else if (path.startsWith('/eo')) {
    detectedLocale = 'eo'
  } else {
    // English default root routes ('/', '/about', '/mission', etc.)
    // Check if the route is one of the registered English routes
    const isEnglishRoute = Object.values(ROUTE_SLUGS).some(s => s['en-US'] === path)
    if (isEnglishRoute) {
      detectedLocale = 'en-US'
    }
  }

  if (detectedLocale && detectedLocale !== currentLocale.value) {
    setLocale(detectedLocale)
  }
})
