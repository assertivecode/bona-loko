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
    detectedLocale = 'en-US'
  }

  if (detectedLocale !== currentLocale.value) {
    setLocale(detectedLocale)
  }
})
