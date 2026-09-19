const fs = require('fs')
const path = require('path')

function stripQuotes(val) {
  const trimmed = val.trim()
  if (
    (trimmed.startsWith('"') && trimmed.endsWith('"')) ||
    (trimmed.startsWith("'") && trimmed.endsWith("'"))
  ) {
    return trimmed.slice(1, -1)
  }
  return trimmed
}

function parseFrontmatter(rawContent) {
  const frontmatterRegex = /^---\r?\n([\s\S]*?)\r?\n---\r?\n([\s\S]*)$/
  const match = rawContent.match(frontmatterRegex)
  if (!match) return {}

  const yamlBlock = match[1]
  const meta = {}
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

function scanContentRoutes(contentDir) {
  const routes = []
  const locales = [
    { folder: 'en-us', prefix: '' },
    { folder: 'pt-br', prefix: '/pt-br' },
    { folder: 'eo', prefix: '/eo' }
  ]

  for (const loc of locales) {
    const locDir = path.join(contentDir, loc.folder)
    if (!fs.existsSync(locDir)) continue
    const subdirs = fs.readdirSync(locDir)
    for (const sub of subdirs) {
      const subDir = path.join(locDir, sub)
      if (!fs.statSync(subDir).isDirectory()) continue
      const files = fs.readdirSync(subDir).filter(f => f.endsWith('.md'))
      for (const file of files) {
        const raw = fs.readFileSync(path.join(subDir, file), 'utf-8')
        const fm = parseFrontmatter(raw)
        const slug = fm.slug || file.replace(/\.md$/, '')
        const routePath = loc.prefix ? `${loc.prefix}/${sub}/${slug}` : `/${sub}/${slug}`
        routes.push({
          path: routePath,
          lastmod: fm.last_updated || new Date().toISOString().split('T')[0],
          changefreq: 'weekly',
          priority: '0.8'
        })
      }
    }
  }

  return routes
}

function syncContentRoutes(rootDir) {
  const contentDir = path.resolve(rootDir, '..', 'content')
  const outputPath = path.resolve(rootDir, 'server', 'content-routes.json')

  if (!fs.existsSync(contentDir)) {
    console.warn(`[sync-content-routes] Content directory not found at ${contentDir}`)
    return
  }

  const routes = scanContentRoutes(contentDir)
  fs.writeFileSync(outputPath, JSON.stringify(routes, null, 2), 'utf-8')
  console.log(`[sync-content-routes] Successfully generated ${routes.length} dynamic routes to ${outputPath}`)
}

if (require.main === module) {
  syncContentRoutes(path.resolve(__dirname, '..'))
}

module.exports = {
  scanContentRoutes,
  syncContentRoutes
}
