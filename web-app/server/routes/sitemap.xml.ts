import { defineEventHandler, setHeader } from 'h3'
import contentRoutes from '../content-routes.json'

export default defineEventHandler((event) => {
  // Set XML response header
  setHeader(event, 'content-type', 'application/xml; charset=utf-8')

  // Access Cloudflare Pages environment (runtime variables) and Nuxt runtimeConfig
  const cfEnv = ((event.context as any).cloudflare?.env || {}) as Record<string, any>
  const config = useRuntimeConfig()

  // Base URL determination: Cloudflare runtime env -> Node process.env -> runtimeConfig -> request host fallback
  let baseUrl =
    cfEnv.SITE_URL ||
    cfEnv.NUXT_PUBLIC_SITE_URL ||
    process.env.SITE_URL ||
    process.env.NUXT_PUBLIC_SITE_URL ||
    (config.public as any)?.siteUrl ||
    (config as any)?.siteUrl

  if (!baseUrl) {
    const host = event.node?.req?.headers?.host || 'bonaloko.com'
    const protocol =
      event.node?.req?.headers?.['x-forwarded-proto'] ||
      (host.includes('localhost') ? 'http' : 'https')
    baseUrl = `${protocol}://${host}`
  }

  baseUrl = baseUrl.replace(/\/+$/, '')

  const now = new Date().toISOString()

  // Track unique URLs
  const urlEntries: Array<{
    loc: string
    lastmod: string
    changefreq: string
    priority: string
  }> = []

  const visitedPaths = new Set<string>()

  const addUrl = (urlPath: string, priority = '0.7', changefreq = 'weekly', lastmod = now) => {
    const cleanPath = urlPath.startsWith('/') ? urlPath : `/${urlPath}`
    if (visitedPaths.has(cleanPath)) return
    visitedPaths.add(cleanPath)

    urlEntries.push({
      loc: `${baseUrl}${cleanPath}`,
      lastmod,
      changefreq,
      priority
    })
  }

  // 1. Static Root / Hub Routes across the 3 current languages
  // Home
  addUrl('/', '1.0', 'daily')
  addUrl('/pt-br', '1.0', 'daily')
  addUrl('/eo', '1.0', 'daily')

  // About
  addUrl('/about', '0.8', 'weekly')
  addUrl('/pt-br/sobre', '0.8', 'weekly')
  addUrl('/eo/pri-ni', '0.8', 'weekly')

  // Mission & Values
  addUrl('/mission', '0.8', 'weekly')
  addUrl('/pt-br/missao', '0.8', 'weekly')
  addUrl('/eo/misio', '0.8', 'weekly')

  // 2. Dynamic Content Articles pre-bundled from content-routes.json
  // (Works natively in Cloudflare Workers with 0 runtime fs dependencies)
  for (const item of contentRoutes) {
    let lastMod = now
    if (item.lastmod) {
      try {
        lastMod = new Date(item.lastmod).toISOString()
      } catch {
        lastMod = now
      }
    }
    addUrl(item.path, item.priority || '0.8', item.changefreq || 'weekly', lastMod)
  }

  // 3. Build standard XML Sitemap
  const sitemapXml = `<?xml version="1.0" encoding="UTF-8"?>
<urlset xmlns="http://www.sitemaps.org/schemas/sitemap/0.9">
${urlEntries
  .map(
    (entry) => `  <url>
    <loc>${entry.loc}</loc>
    <lastmod>${entry.lastmod}</lastmod>
    <changefreq>${entry.changefreq}</changefreq>
    <priority>${entry.priority}</priority>
  </url>`
  )
  .join('\n')}
</urlset>`

  return sitemapXml
})

