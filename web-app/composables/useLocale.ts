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
  | 'privacy'
  | 'life_area_health_fitness'
  | 'life_area_mental_emotional'
  | 'life_area_personal_growth'
  | 'life_area_career_calling'
  | 'life_area_finances_wealth'
  | 'life_area_physical_environment'
  | 'life_area_relationships_intimacy'
  | 'life_area_family_parenting'
  | 'life_area_friendships_community'
  | 'life_area_recreation_play'
  | 'life_area_focus_mastery'
  | 'life_area_contribution_legacy'
  // Backwards compatibility aliases
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

const lifeAreaRoutes: Record<string, Record<Locale, string>> = {
  health_fitness: {
    'en-US': '/life-areas/health-and-physical-fitness',
    'pt-BR': '/pt-br/areas-da-vida/saude-e-condicionamento-fisico',
    eo: '/eo/viv-areoj/sano-kaj-fizika-taugeco'
  },
  mental_emotional: {
    'en-US': '/life-areas/mental-and-emotional-wellbeing',
    'pt-BR': '/pt-br/areas-da-vida/bem-estar-mental-e-emocional',
    eo: '/eo/viv-areoj/mensa-kaj-emocia-bonfarto'
  },
  personal_growth: {
    'en-US': '/life-areas/personal-growth-and-learning',
    'pt-BR': '/pt-br/areas-da-vida/crescimento-pessoal-e-aprendizado',
    eo: '/eo/viv-areoj/persona-kresko-kaj-lernado'
  },
  career_calling: {
    'en-US': '/life-areas/career-and-professional-calling',
    'pt-BR': '/pt-br/areas-da-vida/carreira-e-vocacao-profissional',
    eo: '/eo/viv-areoj/kariero-kaj-profesia-vokigo'
  },
  finances_wealth: {
    'en-US': '/life-areas/finances-and-wealth',
    'pt-BR': '/pt-br/areas-da-vida/financas-e-prosperidade',
    eo: '/eo/viv-areoj/financoj-kaj-rico'
  },
  physical_environment: {
    'en-US': '/life-areas/physical-environment-and-spaces',
    'pt-BR': '/pt-br/areas-da-vida/ambiente-fisico-e-espacos',
    eo: '/eo/viv-areoj/fizika-medio-kaj-spacoj'
  },
  relationships_intimacy: {
    'en-US': '/life-areas/relationships-and-intimacy',
    'pt-BR': '/pt-br/areas-da-vida/relacionamentos-e-intimidade',
    eo: '/eo/viv-areoj/rilatoj-kaj-intimeco'
  },
  family_parenting: {
    'en-US': '/life-areas/family-and-parenting',
    'pt-BR': '/pt-br/areas-da-vida/familia-e-parentalidade',
    eo: '/eo/viv-areoj/familio-kaj-gepatreco'
  },
  friendships_community: {
    'en-US': '/life-areas/friendships-and-community',
    'pt-BR': '/pt-br/areas-da-vida/amizades-e-comunidade',
    eo: '/eo/viv-areoj/amikecoj-kaj-komunumo'
  },
  recreation_play: {
    'en-US': '/life-areas/recreation-hobbies-and-play',
    'pt-BR': '/pt-br/areas-da-vida/recreacao-hobbies-e-lazer',
    eo: '/eo/viv-areoj/distrado-satokupoj-kaj-ludo'
  },
  focus_mastery: {
    'en-US': '/life-areas/focus-and-attention-mastery',
    'pt-BR': '/pt-br/areas-da-vida/dominio-do-foco-e-atencao',
    eo: '/eo/viv-areoj/majstreco-pri-atento-kaj-fokuso'
  },
  contribution_legacy: {
    'en-US': '/life-areas/contribution-and-legacy',
    'pt-BR': '/pt-br/areas-da-vida/contribuicao-e-legado',
    eo: '/eo/viv-areoj/kontribuo-kaj-heredajo'
  }
}

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
  privacy: {
    'en-US': '/privacy',
    'pt-BR': '/pt-br/privacidade',
    eo: '/eo/privateco'
  },
  // Canonical life_area_* keys
  life_area_health_fitness: lifeAreaRoutes.health_fitness,
  life_area_mental_emotional: lifeAreaRoutes.mental_emotional,
  life_area_personal_growth: lifeAreaRoutes.personal_growth,
  life_area_career_calling: lifeAreaRoutes.career_calling,
  life_area_finances_wealth: lifeAreaRoutes.finances_wealth,
  life_area_physical_environment: lifeAreaRoutes.physical_environment,
  life_area_relationships_intimacy: lifeAreaRoutes.relationships_intimacy,
  life_area_family_parenting: lifeAreaRoutes.family_parenting,
  life_area_friendships_community: lifeAreaRoutes.friendships_community,
  life_area_recreation_play: lifeAreaRoutes.recreation_play,
  life_area_focus_mastery: lifeAreaRoutes.focus_mastery,
  life_area_contribution_legacy: lifeAreaRoutes.contribution_legacy,
  // Backwards compatibility dimension_* keys
  dimension_health_fitness: lifeAreaRoutes.health_fitness,
  dimension_mental_emotional: lifeAreaRoutes.mental_emotional,
  dimension_personal_growth: lifeAreaRoutes.personal_growth,
  dimension_career_calling: lifeAreaRoutes.career_calling,
  dimension_finances_wealth: lifeAreaRoutes.finances_wealth,
  dimension_physical_environment: lifeAreaRoutes.physical_environment,
  dimension_relationships_intimacy: lifeAreaRoutes.relationships_intimacy,
  dimension_family_parenting: lifeAreaRoutes.family_parenting,
  dimension_friendships_community: lifeAreaRoutes.friendships_community,
  dimension_recreation_play: lifeAreaRoutes.recreation_play,
  dimension_focus_mastery: lifeAreaRoutes.focus_mastery,
  dimension_contribution_legacy: lifeAreaRoutes.contribution_legacy
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
