<template>
  <div class="layout-mobile-root">
    <AppHeader />

    <!-- Mobile Mode Pill Indicator -->
    <div class="mobile-mode-indicator">
      <span>📱 Mobile Layout Active</span>
    </div>

    <!-- Mobile Scrollable Main -->
    <main class="mobile-main-content">
      <slot />
    </main>

    <!-- Bottom Mobile Quick Action Bar -->
    <nav class="mobile-bottom-bar" aria-label="Mobile Bottom Navigation">
      <NuxtLink to="/" class="bottom-bar-item" active-class="active">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path>
          <polyline points="9 22 9 12 15 12 15 22"></polyline>
        </svg>
        <span>{{ t('nav.home') }}</span>
      </NuxtLink>

      <NuxtLink to="/about" class="bottom-bar-item" active-class="active">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="12" cy="12" r="10"></circle>
          <line x1="12" y1="16" x2="12" y2="12"></line>
          <line x1="12" y1="8" x2="12.01" y2="8"></line>
        </svg>
        <span>{{ t('nav.about') }}</span>
      </NuxtLink>

      <NuxtLink to="/mission" class="bottom-bar-item" active-class="active">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M12 22s8-4 8-10V5l-8-3-8 3v7c0 6 8 10 8 10z"></path>
        </svg>
        <span>{{ t('nav.mission') }}</span>
      </NuxtLink>

      <a href="/#life-areas" class="bottom-bar-item">
        <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <circle cx="12" cy="12" r="10"></circle>
          <path d="M12 2a15.3 15.3 0 0 1 4 10 15.3 15.3 0 0 1-4 10 15.3 15.3 0 0 1-4-10 15.3 15.3 0 0 1 4-10z"></path>
          <path d="M2 12h20"></path>
        </svg>
        <span>{{ t('nav.areas') }}</span>
      </a>
    </nav>

    <AppFooter />
  </div>
</template>

<script setup lang="ts">
import { useComponentI18n } from '~/composables/useLocale'

const mobileLayoutTranslations = {
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

const { t } = useComponentI18n(mobileLayoutTranslations)
</script>

<style scoped>
.layout-mobile-root {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: var(--bg-canvas);
  color: var(--text-primary);
  padding-bottom: 60px; /* Space for mobile bottom bar */
}

.mobile-mode-indicator {
  background-color: var(--secondary-light);
  border-bottom: 1px solid var(--secondary-border);
  color: var(--secondary);
  font-size: 0.8rem;
  font-weight: 600;
  text-align: center;
  padding: 0.35rem;
}

.mobile-main-content {
  flex: 1;
  width: 100%;
}

/* Bottom Bar */
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
