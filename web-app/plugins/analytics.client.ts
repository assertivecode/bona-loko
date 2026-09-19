// web-app/plugins/analytics.client.ts
declare global {
  interface Window {
    dataLayer: any[]
    gtag?: (...args: any[]) => void
  }
}

export default defineNuxtPlugin((nuxtApp) => {
  const config = useRuntimeConfig()
  const gaMeasurementId = config.public.gaMeasurementId as string | undefined

  if (!gaMeasurementId || !gaMeasurementId.trim()) {
    return
  }

  // Prevent duplicate script insertion
  if (document.getElementById('ga-gtag-script')) {
    return
  }

  window.dataLayer = window.dataLayer || []
  function gtag(...args: any[]) {
    window.dataLayer.push(args)
  }
  window.gtag = gtag

  // Initialize gtag and set default configuration
  gtag('js', new Date())
  gtag('config', gaMeasurementId, {
    send_page_view: false // Managed manually on route change for SPA accuracy
  })

  // Dynamically load Google Analytics script tag
  const script = document.createElement('script')
  script.id = 'ga-gtag-script'
  script.async = true
  script.src = `https://www.googletagmanager.com/gtag/js?id=${gaMeasurementId}`
  document.head.appendChild(script)

  // Track initial pageview once Nuxt is mounted
  nuxtApp.hook('app:mounted', () => {
    gtag('event', 'page_view', {
      page_path: window.location.pathname + window.location.search,
      page_location: window.location.href,
      page_title: document.title
    })
  })

  // Track subsequent pageviews across SPA client transitions
  nuxtApp.hook('page:finish', () => {
    gtag('event', 'page_view', {
      page_path: window.location.pathname + window.location.search,
      page_location: window.location.href,
      page_title: document.title
    })
  })
})
