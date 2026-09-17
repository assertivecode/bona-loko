<template>
  <div :class="['layout-default-wrapper', effectiveLayout === 'mobile' ? 'is-mobile-view' : 'is-desktop-view']">
    <!-- Render desktop layout structure -->
    <template v-if="effectiveLayout === 'desktop'">
      <AppHeader />
      <main class="main-content">
        <slot />
      </main>
      <AppFooter />
    </template>

    <!-- Render mobile layout structure -->
    <template v-else>
      <AppHeader />
      <main class="main-content mobile-padded">
        <slot />
      </main>
      
      <!-- Mobile quick navigation bar -->
      <nav class="mobile-bottom-bar" aria-label="Mobile Bottom Navigation">
        <NuxtLink :to="localePath('home')" class="bottom-bar-item" active-class="active">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
            <polyline points="9 22 9 12 15 12 15 22"></polyline>
          </svg>
          <span>{{ t('nav.home') }}</span>
        </NuxtLink>

        <NuxtLink :to="localePath('about')" class="bottom-bar-item" active-class="active">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="10"></circle>
            <line x1="12" y1="16" x2="12" y2="12"></line>
            <line x1="12" y1="8" x2="12.01" y2="8"></line>
          </svg>
          <span>{{ t('nav.about') }}</span>
        </NuxtLink>

        <NuxtLink :to="localePath('mission')" class="bottom-bar-item" active-class="active">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
          </svg>
          <span>{{ t('nav.mission') }}</span>
        </NuxtLink>

        <a :href="localePath('home') + '#life-areas'" class="bottom-bar-item">
          <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
            <circle cx="12" cy="12" r="10"></circle>
            <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path>
            <path d="M2 12h20"></path>
          </svg>
          <span>{{ t('nav.areas') }}</span>
        </a>
      </nav>

      <AppFooter />
    </template>
  </div>
</template>

<script setup lang="ts">
import { useLayoutMode, useComponentI18n, useLocalePath } from '~/composables/useLocale'

const defaultLayoutTranslations = {
  'en-US': {
    nav: {
      home: 'Home',
      about: 'About',
      mission: 'Mission',
      areas: 'Areas'
    }
  },
  'pt-BR': {
    nav: {
      home: 'Início',
      about: 'Sobre',
      mission: 'Missão',
      areas: 'Áreas'
    }
  },
  eo: {
    nav: {
      home: 'Ĉefpaĝo',
      about: 'Pri Ni',
      mission: 'Misio',
      areas: 'Areoj'
    }
  }
}

const { effectiveLayout } = useLayoutMode()
const { t } = useComponentI18n(defaultLayoutTranslations)
const { localePath } = useLocalePath()
</script>

<style scoped>
.layout-default-wrapper {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: var(--bg-canvas);
  color: var(--text-primary);
}

.main-content {
  flex: 1;
  width: 100%;
}

.mobile-padded {
  padding-bottom: 60px;
}

/* Mobile simulated container when toggle is active on wider screens */
.is-mobile-view {
  max-width: 540px;
  margin: 0 auto;
  box-shadow: 0 0 40px rgba(0, 0, 0, 0.08);
  border-left: 1px solid var(--border-color);
  border-right: 1px solid var(--border-color);
}

.mobile-bottom-bar {
  position: fixed;
  bottom: 0;
  left: 0;
  width: 100%;
  height: 60px;
  background-color: rgba(255, 255, 255, 0.98);
  backdrop-filter: blur(12px);
  -webkit-backdrop-filter: blur(12px);
  border-top: 1px solid var(--border-color);
  display: flex;
  align-items: center;
  justify-content: space-around;
  z-index: 1000;
  box-shadow: 0 -4px 12px rgba(0, 0, 0, 0.05);
}

.is-mobile-view .mobile-bottom-bar {
  max-width: 540px;
  left: 50%;
  transform: translateX(-50%);
}

.bottom-bar-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 2px;
  color: var(--text-muted);
  font-size: 0.72rem;
  font-weight: 600;
  padding: 4px 12px;
  transition: color var(--transition-fast);
}

.bottom-bar-item.active,
.bottom-bar-item:hover {
  color: var(--primary);
}
</style>
