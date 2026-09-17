<template>
  <div class="layout-desktop-root">
    <AppHeader />

    <!-- Desktop Layout Banner (Indicates Desktop Optimized Mode) -->
    <div v-if="layoutMode === 'desktop'" class="desktop-mode-indicator">
      <span>🖥️ Desktop Layout Active</span>
    </div>

    <main class="desktop-main-content">
      <slot />
    </main>

    <AppFooter />
  </div>
</template>

<script setup lang="ts">
import { useLayoutMode } from '~/composables/useLocale'

const { layoutMode } = useLayoutMode()
</script>

<style scoped>
.layout-desktop-root {
  min-height: 100vh;
  display: flex;
  flex-direction: column;
  background-color: var(--bg-canvas);
  color: var(--text-primary);
}

.desktop-mode-indicator {
  background-color: var(--primary-light);
  border-bottom: 1px solid var(--primary-border);
  color: var(--primary);
  font-size: 0.8rem;
  font-weight: 600;
  text-align: center;
  padding: 0.35rem;
}

.desktop-main-content {
  flex: 1;
  width: 100%;
}
</style>
