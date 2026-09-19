<template>
  <article class="habit-card card shadow-sm">
    <div class="habit-card-top">
      <div class="habit-icon-badge" aria-hidden="true">
        <span>{{ habitIcon }}</span>
      </div>
      <span v-if="frontmatter.reading_time" class="habit-reading-pill">
        ⏱️ {{ frontmatter.reading_time }}
      </span>
    </div>

    <h3 class="habit-title">
      {{ frontmatter.title }}
    </h3>

    <p v-if="frontmatter.summary" class="habit-desc">
      {{ frontmatter.summary }}
    </p>

    <div v-if="displayTags.length > 0" class="habit-tags-list">
      <span v-for="tag in displayTags" :key="tag" class="habit-tag">
        #{{ tag }}
      </span>
    </div>

    <div class="habit-action-bar">
      <NuxtLink :to="habit.path" class="habit-guide-btn">
        <span>{{ t('actions.readGuide') }}</span>
        <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2.2" stroke-linecap="round" stroke-linejoin="round">
          <path d="M5 12h14"></path>
          <path d="m12 5 7 7-7 7"></path>
        </svg>
      </NuxtLink>
    </div>
  </article>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import type { ArticleRecord } from '~/composables/useArticleContent'
import { useComponentI18n } from '~/composables/useLocale'

const props = defineProps<{
  habit: ArticleRecord
}>()

// Component-Scoped Translation Dictionary (en-US, pt-BR, eo)
const cardTranslations = {
  'en-US': {
    actions: {
      readGuide: 'Read Habit Guide'
    }
  },
  'pt-BR': {
    actions: {
      readGuide: 'Ler Guia do Hábito'
    }
  },
  'eo': {
    actions: {
      readGuide: 'Legi Gvidilon de Kutimo'
    }
  }
}

const { t } = useComponentI18n(cardTranslations)

const frontmatter = computed(() => props.habit.frontmatter || {})

// Canonical Emoji mapping for the 7 keystone habits
const HABIT_ICONS: Record<string, string> = {
  habit_consistent_sleep_evening_transition: '🌙',
  habit_morning_screen_free_window: '🌅',
  habit_nurture_of_gratitude: '🌻',
  habit_daily_protected_reading: '📚',
  habit_mindful_daily_expense_tracking: '💰',
  habit_daily_family_connection_ritual: '👨‍👩‍👧',
  habit_weekly_personal_outreach: '🤝',
  habit_daily_guilt_free_micro_leisure: '🎨'
}

const habitIcon = computed(() => {
  if (HABIT_ICONS[props.habit.id]) {
    return HABIT_ICONS[props.habit.id]
  }
  const pillars = frontmatter.value.pillars
  if (Array.isArray(pillars) && pillars.length > 0 && pillars[0].emoji) {
    return pillars[0].emoji
  }
  return '🌱'
})

// Limit displayed tags to top 3 for clean card aesthetics
const displayTags = computed(() => {
  const tags = frontmatter.value.tags
  if (!Array.isArray(tags)) return []
  return tags.slice(0, 3)
})
</script>

<style scoped>
.habit-card {
  display: flex;
  flex-direction: column;
  padding: 1.75rem;
  background-color: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
  transition: all var(--transition-normal);
  height: 100%;
}

.habit-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-md);
  border-color: var(--primary-border);
}

.habit-card-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 1.25rem;
}

.habit-icon-badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 46px;
  height: 46px;
  border-radius: var(--radius-md);
  background: var(--bg-subtle);
  border: 1px solid var(--border-subtle);
  font-size: 1.5rem;
  line-height: 1;
}

.habit-reading-pill {
  font-size: 0.78rem;
  font-weight: 500;
  color: var(--text-muted);
  background: var(--bg-subtle);
  padding: 0.25rem 0.65rem;
  border-radius: var(--radius-pill);
  border: 1px solid var(--border-subtle);
}

.habit-title {
  font-size: 1.22rem;
  line-height: 1.35;
  color: var(--text-primary);
  margin-bottom: 0.75rem;
  font-weight: 700;
}

.habit-desc {
  font-size: 0.92rem;
  line-height: 1.6;
  color: var(--text-secondary);
  margin-bottom: 1.25rem;
  flex: 1;
}

.habit-tags-list {
  display: flex;
  flex-wrap: wrap;
  gap: 0.4rem;
  margin-bottom: 1.25rem;
}

.habit-tag {
  font-size: 0.75rem;
  font-weight: 500;
  color: var(--text-muted);
  background: var(--bg-canvas);
  padding: 0.2rem 0.55rem;
  border-radius: var(--radius-sm);
  border: 1px solid var(--border-subtle);
}

.habit-action-bar {
  margin-top: auto;
  padding-top: 1rem;
  border-top: 1px solid var(--border-subtle);
}

.habit-guide-btn {
  display: inline-flex;
  align-items: center;
  justify-content: space-between;
  width: 100%;
  padding: 0.6rem 0.9rem;
  background-color: var(--bg-subtle);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-md);
  font-size: 0.88rem;
  font-weight: 600;
  color: var(--primary);
  text-decoration: none;
  transition: all var(--transition-fast);
}

.habit-guide-btn:hover {
  background-color: var(--primary-light);
  border-color: var(--primary-border);
  color: var(--primary-hover);
  padding-right: 0.75rem;
}

.habit-guide-btn svg {
  transition: transform var(--transition-fast);
}

.habit-guide-btn:hover svg {
  transform: translateX(3px);
}
</style>
