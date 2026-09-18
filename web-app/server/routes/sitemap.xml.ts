import fs from 'node:fs'
import path from 'node:path'
import { defineEventHandler, setHeader } from 'h3'

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

// Light YAML frontmatter parser handling primitives
function parseFrontmatter(rawContent: string): Record<string, any> {
  const frontmatterRegex = /^---\r?\n([\s\S]*?)\r?\n---\r?\n([\s\S]*)$/
  const match = rawContent.match(frontmatterRegex)
  if (!match) return {}

  const yamlBlock = match[1]
  const meta: Record<string, any> = {}
  const lines = yamlBlock.split(/\r?\n/)

  for (const line of lines) {
    if (!line.trim() || line.trim().startsWith('#')) continue
    const topKeyMatch = line.match(/^([a-zA-Z0-9_-]+):\s*(.*)$/)
    if (topKeyMatch) {
      const k = topKeyMatch[1].trim()
      const v = topKeyMatch[2].trim()
      if (v !== '') {
        meta[k] = stripQuotes(v)
      }
    }
  }

  return meta
}

export default defineEventHandler((event) => {
  // Set XML response header
  setHeader(event, 'content-type', 'application/xml; charset=utf-8')

  // Base URL determination: use request host or fallback to production URL
  const host = event.node.req.headers.host || 'bonaloko.com'
  const protocol = event.node.req.headers['x-forwarded-proto'] || (host.includes('localhost') ? 'http' : 'https')
  const baseUrl = `${protocol}://${host}`

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

  // 2. Discover articles dynamically from ./content directory for all 3 languages
  try {
    // Resolve content directory relative to project root or current working dir
    const possibleContentRoots = [
      path.resolve(process.cwd(), 'content'),
      path.resolve(process.cwd(), '../content'),
      path.resolve(process.cwd(), '../../content')
    ]

    const contentRoot = possibleContentRoots.find((p) => fs.existsSync(p))

    if (contentRoot) {
      const locales = [
        { folder: 'en-us', prefix: '' },
        { folder: 'pt-br', prefix: '/pt-br' },
        { folder: 'eo', prefix: '/eo' }
      ]

      for (const loc of locales) {
        const localeDir = path.join(contentRoot, loc.folder)
        if (!fs.existsSync(localeDir)) continue

        const entries = fs.readdirSync(localeDir, { withFileTypes: true })
        for (const entry of entries) {
          if (entry.isDirectory()) {
            const collectionDir = path.join(localeDir, entry.name)
            const collectionName = entry.name
            const articleFiles = fs.readdirSync(collectionDir, { withFileTypes: true })

            for (const file of articleFiles) {
              if (file.isFile() && file.name.endsWith('.md')) {
                const fullPath = path.join(collectionDir, file.name)
                const content = fs.readFileSync(fullPath, 'utf-8')
                const frontmatter = parseFrontmatter(content)
                const slug = frontmatter.slug || file.name.replace(/\.md$/, '')
                const routePath = `${loc.prefix}/${collectionName}/${slug}`

                let lastMod = now
                if (frontmatter.last_updated) {
                  try {
                    lastMod = new Date(frontmatter.last_updated).toISOString()
                  } catch {
                    lastMod = now
                  }
                } else {
                  try {
                    const stats = fs.statSync(fullPath)
                    lastMod = stats.mtime.toISOString()
                  } catch {
                    lastMod = now
                  }
                }

                addUrl(routePath, '0.8', 'weekly', lastMod)
              }
            }
          }
        }
      }
    }
  } catch (err) {
    console.error('Error generating dynamic sitemap from content:', err)
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
