<template>
  <header class="app-header" :class="{ 'header-scrolled': isScrolled }">
    <div class="header-inner container">
      <!-- Logo & Esperanto meaning -->
      <div class="brand-group">
        <NuxtLink :to="localePath('home')" class="logo-link" :aria-label="t('nav.home')">
          <img
            src="/images/horizontal-logo.png"
            alt="Bona Loko"
            class="header-logo"
            width="170"
            height="32"
          />
        </NuxtLink>

      </div>

      <!-- Desktop Navigation -->
      <nav class="desktop-nav" aria-label="Main Navigation">
        <NuxtLink :to="localePath('home')" class="nav-link" active-class="active">
          {{ t('nav.home') }}
        </NuxtLink>
        <NuxtLink :to="localePath('about')" class="nav-link" active-class="active">
          {{ t('nav.about') }}
        </NuxtLink>
        <NuxtLink :to="localePath('mission')" class="nav-link" active-class="active">
          {{ t('nav.mission') }}
        </NuxtLink>
        <NuxtLink :to="localePath('home') + '#suggested-habits'" class="nav-link">
          {{ t('nav.habits') }}
        </NuxtLink>
      </nav>

      <!-- Right Controls: Language Switcher, Layout Toggle, CTA -->
      <div class="header-actions">
        <!-- Language Switcher Dropdown -->
        <div class="lang-dropdown">
          <button
            type="button"
            class="lang-btn"
            @click="isLangMenuOpen = !isLangMenuOpen"
            :aria-label="t('lang.change')"
          >
            <span class="lang-flag">{{ currentLocaleMeta.flag }}</span>
            <span class="lang-code">{{ currentLocaleMeta.code.toUpperCase() }}</span>
            <svg class="chevron-icon" width="12" height="12" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.5">
              <polyline points="6 9 12 15 18 9"></polyline>
            </svg>
          </button>

          <div v-if="isLangMenuOpen" class="lang-menu shadow-lg">
            <button
              v-for="loc in locales"
              :key="loc.code"
              type="button"
              class="lang-option"
              :class="{ active: currentLocale === loc.code }"
              @click="changeLocale(loc.code)"
            >
              <span class="opt-flag">{{ loc.flag }}</span>
              <span class="opt-name">{{ loc.nativeName }}</span>
              <span v-if="currentLocale === loc.code" class="check-mark">✓</span>
            </button>
          </div>
        </div>


        <!-- Header CTA -->
        <!-- <NuxtLink to="/#assessment" class="btn btn-primary btn-sm header-cta">
          {{ t('nav.cta') }}
        </NuxtLink> -->

        <!-- Mobile Hamburger Toggle -->
        <button
          type="button"
          class="mobile-toggle"
          @click="isMobileMenuOpen = !isMobileMenuOpen"
          :aria-expanded="isMobileMenuOpen"
          :aria-label="t('nav.toggleMenu')"
        >
          <span class="bar" :class="{ 'bar-top': isMobileMenuOpen }"></span>
          <span class="bar" :class="{ 'bar-mid': isMobileMenuOpen }"></span>
          <span class="bar" :class="{ 'bar-bot': isMobileMenuOpen }"></span>
        </button>
      </div>
    </div>

    <!-- Mobile Drawer -->
    <Transition name="drawer">
      <div v-if="isMobileMenuOpen" class="mobile-drawer">
        <div class="drawer-header">
          <button
            type="button"
            class="drawer-close-btn"
            @click="isMobileMenuOpen = false"
            aria-label="Close menu"
          >
            ✕
          </button>
        </div>

        <nav class="mobile-nav">
          <NuxtLink :to="localePath('home')" class="mobile-nav-link" @click="isMobileMenuOpen = false">
            {{ t('nav.home') }}
          </NuxtLink>
          <NuxtLink :to="localePath('about')" class="mobile-nav-link" @click="isMobileMenuOpen = false">
            {{ t('nav.about') }}
          </NuxtLink>
          <NuxtLink :to="localePath('mission')" class="mobile-nav-link" @click="isMobileMenuOpen = false">
            {{ t('nav.mission') }}
          </NuxtLink>
          <NuxtLink :to="localePath('home') + '#suggested-habits'" class="mobile-nav-link" @click="isMobileMenuOpen = false">
            {{ t('nav.habits') }}
          </NuxtLink>
        </nav>

        <div class="mobile-drawer-footer">
          <div class="mobile-lang-list">
            <span class="mobile-section-label">{{ t('lang.choose') }}</span>
            <div class="mobile-lang-buttons">
              <button
                v-for="loc in locales"
                :key="loc.code"
                type="button"
                class="mobile-lang-btn"
                :class="{ active: currentLocale === loc.code }"
                @click="changeLocale(loc.code)"
              >
                <span>{{ loc.flag }}</span>
                <span>{{ loc.nativeName }}</span>
              </button>
            </div>
          </div>

          <NuxtLink to="/#assessment" class="btn btn-primary btn-lg mobile-cta-btn" @click="isMobileMenuOpen = false">
            {{ t('nav.cta') }}
          </NuxtLink>
        </div>
      </div>
    </Transition>
  </header>
</template>

<script setup lang="ts">
import { ref, computed, onMounted, onUnmounted } from 'vue'
import { useRoute, useRouter } from '#app'
import { useComponentI18n, useLocalePath, type Locale } from '~/composables/useLocale'

// Component-Scoped Translation Dictionary (EN-US, PT-BR, EO)
const headerTranslations = {
  'en-US': {
    etymology: {
      hint: 'The name honors Esperanto: a universal, peaceful language representing a mentality focused in uncorruptibility and core values.'
    },
    nav: {
      home: 'Home',
      about: 'About',
      mission: 'Mission & Values',
      habits: 'Suggested Habits',
      cta: 'Explore Platform',
      toggleMenu: 'Toggle mobile menu'
    },
    lang: {
      change: 'Change language',
      choose: 'Select Language'
    }
  },
  'pt-BR': {
    etymology: {
      hint: 'O nome homenageia o Esperanto: uma língua universal e pacífica que representa uma mentalidade focada na incorruptibilidade e valores fundamentais.'
    },
    nav: {
      home: 'Início',
      about: 'Sobre',
      mission: 'Missão & Valores',
      habits: 'Hábitos Sugeridos',
      cta: 'Explorar Plataforma',
      toggleMenu: 'Alternar menu móvel'
    },
    lang: {
      change: 'Alterar idioma',
      choose: 'Selecione o Idioma'
    }
  },
  eo: {
    etymology: {
      hint: 'La nomo honoras Esperanton: universala kaj paca lingvo reprezentanta pensmanieron fokusitan al nekoruptebleco kaj kernajn valorojn.'
    },
    nav: {
      home: 'Ĉefpaĝo',
      about: 'Pri Ni',
      mission: 'Misio & Valoroj',
      habits: 'Sugestitaj Kutimoj',
      cta: 'Esplori Platformon',
      toggleMenu: 'Ŝalti poŝtelefonan menuon'
    },
    lang: {
      change: 'Ŝanĝi lingvon',
      choose: 'Elektu Lingvon'
    }
  }
}

const { t, currentLocale, setLocale, locales } = useComponentI18n(headerTranslations)
const { localePath, getEquivalentPathForLocale } = useLocalePath()
const route = useRoute()
const router = useRouter()

const isScrolled = ref(false)
const isLangMenuOpen = ref(false)
const isMobileMenuOpen = ref(false)

const currentLocaleMeta = computed(() => {
  return locales.find(l => l.code === currentLocale.value) || locales[0]
})

const changeLocale = async (code: Locale) => {
  setLocale(code)
  isLangMenuOpen.value = false
  const targetPath = getEquivalentPathForLocale(route.fullPath, code)
  if (targetPath !== route.fullPath) {
    await router.push(targetPath)
  }
}

const handleScroll = () => {
  isScrolled.value = window.scrollY > 15
}

onMounted(() => {
  window.addEventListener('scroll', handleScroll, { passive: true })
  window.addEventListener('click', (e) => {
    const target = e.target as HTMLElement
    if (!target.closest('.lang-dropdown')) {
      isLangMenuOpen.value = false
    }
  })
})

onUnmounted(() => {
  window.removeEventListener('scroll', handleScroll)
})
</script>

<style scoped>
.app-header {
  position: sticky;
  top: 0;
  left: 0;
  width: 100%;
  height: var(--header-height);
  background-color: rgba(252, 251, 247, 0.95);
  backdrop-filter: blur(10px);
  -webkit-backdrop-filter: blur(10px);
  border-bottom: 1px solid var(--border-color);
  z-index: 1000;
  transition: all var(--transition-normal);
}

.header-scrolled {
  background-color: rgba(255, 255, 255, 0.98);
  box-shadow: var(--shadow-sm);
  border-bottom-color: var(--border-strong);
}

.header-inner {
  height: 100%;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1.25rem;
}

/* Brand */
.brand-group {
  display: flex;
  align-items: center;
  gap: 1rem;
}

.logo-link {
  display: flex;
  align-items: center;
}

.header-logo {
  height: 32px;
  width: auto;
  object-fit: contain;
  display: block;
}

.esperanto-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  padding: 0.25rem 0.65rem;
  background-color: var(--secondary-light);
  border: 1px solid var(--secondary-border);
  border-radius: var(--radius-pill);
  font-size: 0.76rem;
  font-weight: 600;
  color: var(--secondary);
  white-space: nowrap;
}

.esperanto-star {
  color: var(--secondary);
  font-size: 0.85rem;
}

/* Desktop Navigation */
.desktop-nav {
  display: flex;
  align-items: center;
  gap: 1.5rem;
}

.nav-link {
  font-size: 0.92rem;
  font-weight: 600;
  color: var(--text-secondary);
  position: relative;
  padding: 0.35rem 0;
  transition: color var(--transition-fast);
}

.nav-link:hover,
.nav-link.active {
  color: var(--primary);
}

.nav-link.active::after {
  content: '';
  position: absolute;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 2px;
  background-color: var(--primary);
  border-radius: 2px;
}

/* Actions */
.header-actions {
  display: flex;
  align-items: center;
  gap: 0.75rem;
}

/* Language Switcher */
.lang-dropdown {
  position: relative;
}

.lang-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  padding: 0.4rem 0.75rem;
  background-color: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-pill);
  font-size: 0.82rem;
  font-weight: 600;
  color: var(--text-primary);
  cursor: pointer;
  transition: all var(--transition-fast);
}

.lang-btn:hover {
  border-color: var(--primary);
  background-color: var(--primary-light);
}

.lang-menu {
  position: absolute;
  top: calc(100% + 0.4rem);
  right: 0;
  background-color: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  padding: 0.35rem;
  min-width: 150px;
  display: flex;
  flex-direction: column;
  gap: 0.2rem;
  z-index: 1010;
}

.lang-option {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  padding: 0.45rem 0.75rem;
  background: transparent;
  border: none;
  border-radius: var(--radius-sm);
  font-size: 0.85rem;
  font-weight: 500;
  color: var(--text-secondary);
  cursor: pointer;
  width: 100%;
  text-align: left;
  transition: background-color var(--transition-fast);
}

.lang-option:hover {
  background-color: var(--bg-subtle);
  color: var(--text-primary);
}

.lang-option.active {
  background-color: var(--primary-light);
  color: var(--primary);
  font-weight: 600;
}

.check-mark {
  margin-left: auto;
  font-size: 0.8rem;
  color: var(--primary);
}


/* Mobile Toggle */
.mobile-toggle {
  display: none;
  flex-direction: column;
  justify-content: center;
  gap: 4px;
  width: 38px;
  height: 38px;
  padding: 8px;
  background: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  cursor: pointer;
}

.bar {
  width: 100%;
  height: 2px;
  background-color: var(--text-primary);
  border-radius: 2px;
  transition: all var(--transition-fast);
}

.bar-top { transform: translateY(6px) rotate(45deg); }
.bar-mid { opacity: 0; }
.bar-bot { transform: translateY(-6px) rotate(-45deg); }

/* Mobile Drawer */
.mobile-drawer {
  display: none;
  position: fixed;
  top: var(--header-height);
  left: 0;
  width: 100%;
  height: calc(100vh - var(--header-height));
  background-color: var(--bg-surface);
  padding: 1.5rem;
  flex-direction: column;
  overflow-y: auto;
  z-index: 999;
}

.drawer-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 1.5rem;
}

.esperanto-badge-mobile {
  font-size: 0.8rem;
  font-weight: 600;
  color: var(--secondary);
  background-color: var(--secondary-light);
  padding: 0.35rem 0.8rem;
  border-radius: var(--radius-pill);
  border: 1px solid var(--secondary-border);
}

.drawer-close-btn {
  background: none;
  border: none;
  font-size: 1.25rem;
  color: var(--text-muted);
  cursor: pointer;
}

.mobile-nav {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  margin-bottom: 2rem;
}

.mobile-nav-link {
  font-size: 1.15rem;
  font-weight: 600;
  color: var(--text-primary);
  padding: 0.75rem 0.5rem;
  border-bottom: 1px solid var(--border-subtle);
}

.mobile-nav-link:hover {
  color: var(--primary);
}

.mobile-drawer-footer {
  margin-top: auto;
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
}

.mobile-section-label {
  display: block;
  font-size: 0.82rem;
  font-weight: 600;
  color: var(--text-muted);
  text-transform: uppercase;
  letter-spacing: 0.05em;
  margin-bottom: 0.5rem;
}

.mobile-lang-buttons {
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
}

.mobile-lang-btn {
  display: flex;
  align-items: center;
  gap: 0.75rem;
  padding: 0.65rem 1rem;
  background-color: var(--bg-subtle);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  font-size: 0.95rem;
  font-weight: 500;
  color: var(--text-primary);
  cursor: pointer;
}

.mobile-lang-btn.active {
  background-color: var(--primary-light);
  border-color: var(--primary-border);
  color: var(--primary);
  font-weight: 700;
}

.mobile-cta-btn {
  width: 100%;
  text-align: center;
}

/* Responsive queries */
@media (max-width: 900px) {
  .esperanto-badge {
    display: none;
  }
}

@media (max-width: 768px) {
  .desktop-nav,
  .header-cta {
    display: none;
  }

  .mobile-toggle {
    display: flex;
  }

  .mobile-drawer {
    display: flex;
  }
}
</style>
