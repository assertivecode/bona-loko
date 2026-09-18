import { ref, computed, watch, onMounted } from 'vue'

export type Locale = 'en-US' | 'pt-BR' | 'eo'

export interface LocaleMeta {
  code: Locale
  name: string
  nativeName: string
  flag: string
}

export const SUPPORTED_LOCALES: LocaleMeta[] = [
  { code: 'en-US', name: 'English (US)', nativeName: 'English', flag: '🇺🇸' },
  { code: 'pt-BR', name: 'Portuguese (Brazil)', nativeName: 'Português', flag: '🇧🇷' },
  { code: 'eo', name: 'Esperanto', nativeName: 'Esperanto', flag: '🟢' }
]

export type CanonicalRouteKey =
  | 'home'
  | 'about'
  | 'mission'
  | 'dimension_health_fitness'
  | 'dimension_mental_emotional'
  | 'dimension_personal_growth'
  | 'dimension_career_calling'
  | 'dimension_finances_wealth'
  | 'dimension_physical_environment'
  | 'dimension_relationships_intimacy'
  | 'dimension_family_parenting'
  | 'dimension_friendships_community'
  | 'dimension_recreation_play'
  | 'dimension_focus_mastery'
  | 'dimension_contribution_legacy'

export const ROUTE_SLUGS: Record<CanonicalRouteKey, Record<Locale, string>> = {
  home: {
    'en-US': '/',
    'pt-BR': '/pt-br',
    eo: '/eo'
  },
  about: {
    'en-US': '/about',
    'pt-BR': '/pt-br/sobre',
    eo: '/eo/pri-ni'
  },
  mission: {
    'en-US': '/mission',
    'pt-BR': '/pt-br/missao',
    eo: '/eo/misio'
  },
  dimension_health_fitness: {
    'en-US': '/dimensions/health-and-physical-fitness',
    'pt-BR': '/pt-br/dimensoes/saude-e-condicionamento-fisico',
    eo: '/eo/dimensioj/sano-kaj-fizika-taugeco'
  },
  dimension_mental_emotional: {
    'en-US': '/dimensions/mental-and-emotional-wellbeing',
    'pt-BR': '/pt-br/dimensoes/bem-estar-mental-e-emocional',
    eo: '/eo/dimensioj/mensa-kaj-emocia-bonfarto'
  },
  dimension_personal_growth: {
    'en-US': '/dimensions/personal-growth-and-learning',
    'pt-BR': '/pt-br/dimensoes/crescimento-pessoal-e-aprendizado',
    eo: '/eo/dimensioj/persona-kresko-kaj-lernado'
  },
  dimension_career_calling: {
    'en-US': '/dimensions/career-and-professional-calling',
    'pt-BR': '/pt-br/dimensoes/carreira-e-vocacao-profissional',
    eo: '/eo/dimensioj/kariero-kaj-profesia-vokigo'
  },
  dimension_finances_wealth: {
    'en-US': '/dimensions/finances-and-wealth',
    'pt-BR': '/pt-br/dimensoes/financas-e-prosperidade',
    eo: '/eo/dimensioj/financoj-kaj-rico'
  },
  dimension_physical_environment: {
    'en-US': '/dimensions/physical-environment-and-spaces',
    'pt-BR': '/pt-br/dimensoes/ambiente-fisico-e-espacos',
    eo: '/eo/dimensioj/fizika-medio-kaj-spacoj'
  },
  dimension_relationships_intimacy: {
    'en-US': '/dimensions/relationships-and-intimacy',
    'pt-BR': '/pt-br/dimensoes/relacionamentos-e-intimidade',
    eo: '/eo/dimensioj/rilatoj-kaj-intimeco'
  },
  dimension_family_parenting: {
    'en-US': '/dimensions/family-and-parenting',
    'pt-BR': '/pt-br/dimensoes/familia-e-parentalidade',
    eo: '/eo/dimensioj/familio-kaj-gepatreco'
  },
  dimension_friendships_community: {
    'en-US': '/dimensions/friendships-and-community',
    'pt-BR': '/pt-br/dimensoes/amizades-e-comunidade',
    eo: '/eo/dimensioj/amikecoj-kaj-komunumo'
  },
  dimension_recreation_play: {
    'en-US': '/dimensions/recreation-hobbies-and-play',
    'pt-BR': '/pt-br/dimensoes/recreacao-hobbies-e-lazer',
    eo: '/eo/dimensioj/distrado-satokupoj-kaj-ludo'
  },
  dimension_focus_mastery: {
    'en-US': '/dimensions/focus-and-attention-mastery',
    'pt-BR': '/pt-br/dimensoes/dominio-do-foco-e-atencao',
    eo: '/eo/dimensioj/majstreco-pri-atento-kaj-fokuso'
  },
  dimension_contribution_legacy: {
    'en-US': '/dimensions/contribution-and-legacy',
    'pt-BR': '/pt-br/dimensoes/contribuicao-e-legado',
    eo: '/eo/dimensioj/kontribuo-kaj-heredajo'
  }
}

// Global singleton state for current locale across the application
const activeLocale = ref<Locale>('en-US')
const isInitialized = ref(false)

export function useGlobalLocale() {
  const cookieLocale = useCookie<Locale | null>('bona_loko_locale', {
    default: () => null,
    maxAge: 60 * 60 * 24 * 365,
    path: '/'
  })

  if (!isInitialized.value) {
    if (cookieLocale.value && (cookieLocale.value === 'en-US' || cookieLocale.value === 'pt-BR' || cookieLocale.value === 'eo')) {
      activeLocale.value = cookieLocale.value
    } else if (import.meta.client) {
      const saved = localStorage.getItem('bona_loko_locale')
      if (saved === 'en-US' || saved === 'pt-BR' || saved === 'eo') {
        activeLocale.value = saved
        cookieLocale.value = saved
      } else if (saved === 'en') {
        activeLocale.value = 'en-US'
        cookieLocale.value = 'en-US'
        localStorage.setItem('bona_loko_locale', 'en-US')
      } else if (saved === 'pt') {
        activeLocale.value = 'pt-BR'
        cookieLocale.value = 'pt-BR'
        localStorage.setItem('bona_loko_locale', 'pt-BR')
      }
    }
    isInitialized.value = true
  }

  const setLocale = (locale: Locale) => {
    activeLocale.value = locale
    cookieLocale.value = locale
    if (import.meta.client) {
      localStorage.setItem('bona_loko_locale', locale)
      document.documentElement.lang = locale
    }
  }

  return {
    currentLocale: activeLocale,
    setLocale,
    locales: SUPPORTED_LOCALES
  }
}

import { getArticlePathById, getArticleCounterpartPath } from '~/composables/useArticleContent'

/**
 * Resolve a route key or canonical path into the localized path for a given locale (or active locale).
 * Supports path hashes, e.g. localePath('/about#values') -> '/pt-br/sobre#values'
 */
export function useLocalePath() {
  const { currentLocale } = useGlobalLocale()

  const getCanonicalKeyFromPath = (path: string): CanonicalRouteKey | null => {
    const cleanPath = path.split('#')[0].split('?')[0].replace(/\/+$/, '') || '/'
    
    for (const [key, slugMap] of Object.entries(ROUTE_SLUGS)) {
      for (const slug of Object.values(slugMap)) {
        const normalizedSlug = slug.replace(/\/+$/, '') || '/'
        if (cleanPath === normalizedSlug) {
          return key as CanonicalRouteKey
        }
      }
    }
    return null
  }

  const localePath = (target: CanonicalRouteKey | string, targetLocale?: Locale): string => {
    const loc = targetLocale || currentLocale.value
    const [pathPart, hashPart] = target.split('#')
    const hash = hashPart ? `#${hashPart}` : ''

    // 1. Direct canonical key lookup in static routes
    if (target in ROUTE_SLUGS) {
      return `${ROUTE_SLUGS[target as CanonicalRouteKey][loc]}${hash}`
    }

    // 2. Direct article ID lookup from dynamic markdown content
    const dynamicArticlePath = getArticlePathById(pathPart, loc)
    if (dynamicArticlePath) {
      return `${dynamicArticlePath}${hash}`
    }

    // 3. Identify canonical key from existing static path
    const key = getCanonicalKeyFromPath(pathPart)
    if (key) {
      return `${ROUTE_SLUGS[key][loc]}${hash}`
    }

    // 4. Dynamic article counterpart lookup from existing path
    const dynamicCounterpart = getArticleCounterpartPath(pathPart, loc)
    if (dynamicCounterpart) {
      return `${dynamicCounterpart}${hash}`
    }

    // 5. Fallback for external or unregistered relative paths
    return target
  }

  const getEquivalentPathForLocale = (currentPath: string, newLocale: Locale): string => {
    const [pathPart, hashPart] = currentPath.split('#')
    const hash = hashPart ? `#${hashPart}` : ''

    // 1. Static routes check
    const key = getCanonicalKeyFromPath(pathPart)
    if (key) {
      return `${ROUTE_SLUGS[key][newLocale]}${hash}`
    }

    // 2. Dynamic content counterpart check
    const dynamicCounterpart = getArticleCounterpartPath(pathPart, newLocale)
    if (dynamicCounterpart) {
      return `${dynamicCounterpart}${hash}`
    }

    return currentPath
  }

  return {
    localePath,
    getEquivalentPathForLocale,
    getCanonicalKeyFromPath
  }
}

/**
 * Component-level i18n hook
 * Adheres strictly to the architectural requirement:
 * "Each page/component must apply translations based in translation keys,
 * and the translation keys must be inside the respective page/component."
 */
export function useComponentI18n<T extends Record<string, any>>(translations: Record<Locale, T>) {
  const { currentLocale, setLocale, locales } = useGlobalLocale()

  const currentDict = computed<T>(() => {
    const dict = translations[currentLocale.value]
    const fallback = translations['en-US']
    return { ...fallback, ...dict }
  })

  // Helper function to get text by key path (supports dot notation, e.g. "hero.title")
  const t = (keyPath: string): string => {
    const dict = currentDict.value as Record<string, any>
    if (!keyPath) return ''

    const parts = keyPath.split('.')
    let current: any = dict

    for (const part of parts) {
      if (current && typeof current === 'object' && part in current) {
        current = current[part]
      } else {
        // Fallback to English (en-US) directly if nested key missing
        let fb: any = translations['en-US']
        for (const p of parts) {
          if (fb && typeof fb === 'object' && p in fb) {
            fb = fb[p]
          } else {
            fb = undefined
            break
          }
        }
        return fb !== undefined ? String(fb) : keyPath
      }
    }

    return current !== undefined ? String(current) : keyPath
  }

  return {
    t,
    dict: currentDict,
    currentLocale,
    setLocale,
    locales
  }
}

// Layout simulation state (Allows toggling between responsive auto, desktop, and mobile)
export type LayoutMode = 'auto' | 'desktop' | 'mobile'
const globalLayoutMode = ref<LayoutMode>('auto')

export function useLayoutMode() {
  const isMobileViewport = ref(false)

  if (import.meta.client) {
    const updateViewport = () => {
      isMobileViewport.value = window.innerWidth <= 768
    }
    updateViewport()
    window.addEventListener('resize', updateViewport)
  }

  const effectiveLayout = computed<'desktop' | 'mobile'>(() => {
    if (globalLayoutMode.value === 'desktop') return 'desktop'
    if (globalLayoutMode.value === 'mobile') return 'mobile'
    return isMobileViewport.value ? 'mobile' : 'desktop'
  })

  const setLayoutMode = (mode: LayoutMode) => {
    globalLayoutMode.value = mode
  }

  return {
    layoutMode: globalLayoutMode,
    effectiveLayout,
    setLayoutMode,
    isMobileViewport
  }
}
