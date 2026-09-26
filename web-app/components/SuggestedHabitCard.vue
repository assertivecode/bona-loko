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

    <div v-if="areaWeightsList.length > 0" class="habit-impact-section">
      <span class="habit-impact-label">{{ t('impactTitle') }}</span>
      <div class="habit-impact-list">
        <span
          v-for="item in areaWeightsList"
          :key="item.areaKey"
          class="habit-impact-badge"
          :class="`weight-${item.weight}`"
        >
          <span class="impact-name">{{ item.name }}</span>
          <span class="impact-score">★ {{ item.weight }}/5</span>
        </span>
      </div>
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
    impactTitle: 'Life Area Impact',
    actions: {
      readGuide: 'Read Habit Guide'
    },
    lifeAreas: {
      health_fitness: 'Health & Fitness',
      emotional_wellbeing: 'Emotional Wellbeing',
      personal_growth: 'Personal Growth',
      career_calling: 'Career & Calling',
      finances_wealth: 'Finances & Wealth',
      physical_environment: 'Environment & Spaces',
      relationships_intimacy: 'Relationships',
      family_parenting: 'Family & Parenting',
      friendships_community: 'Friendships',
      recreation_play: 'Recreation & Play',
      focus_mastery: 'Focus Mastery',
      contribution_legacy: 'Contribution & Legacy'
    }
  },
  'pt-BR': {
    impactTitle: 'Impacto nas Áreas da Vida',
    actions: {
      readGuide: 'Ler Guia do Hábito'
    },
    lifeAreas: {
      health_fitness: 'Saúde & Físico',
      emotional_wellbeing: 'Bem-Estar Emocional',
      personal_growth: 'Crescimento Pessoal',
      career_calling: 'Carreira & Vocação',
      finances_wealth: 'Finanças & Prosperidade',
      physical_environment: 'Ambiente & Espaços',
      relationships_intimacy: 'Relacionamentos',
      family_parenting: 'Família & Parentalidade',
      friendships_community: 'Amizades & Comunidade',
      recreation_play: 'Recreação & Lazer',
      focus_mastery: 'Domínio do Foco',
      contribution_legacy: 'Contribuição & Legado'
    }
  },
  'eo': {
    impactTitle: 'Efikoj sur Viv-Areoj',
    actions: {
      readGuide: 'Legi Gvidilon de Kutimo'
    },
    lifeAreas: {
      health_fitness: 'Sano & Taŭgeco',
      emotional_wellbeing: 'Emocia Bonfarto',
      personal_growth: 'Persona Kresko',
      career_calling: 'Kariero & Vokiĝo',
      finances_wealth: 'Financoj & Riĉo',
      physical_environment: 'Medio & Spacoj',
      relationships_intimacy: 'Rilatoj & Intimeco',
      family_parenting: 'Familio & Gepatreco',
      friendships_community: 'Amikecoj & Komunumo',
      recreation_play: 'Distrado & Ludo',
      focus_mastery: 'Majstreco pri Atento',
      contribution_legacy: 'Kontribuo & Heredaĵo'
    }
  }
}

const { t } = useComponentI18n(cardTranslations)

const frontmatter = computed(() => props.habit.frontmatter || {})

// Canonical Emoji mapping for keystone habits
const HABIT_ICONS: Record<string, string> = {
  habit_regular_exercise_workout: '🏃‍♂️',
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

// Ranked list of weighted life area relations (weights 1..5)
const areaWeightsList = computed(() => {
  const weights = frontmatter.value.life_area_weights
  if (!weights || typeof weights !== 'object') return []
  return Object.entries(weights)
    .filter(([_, weight]) => Number(weight) >= 1 && Number(weight) <= 5)
    .sort((a, b) => Number(b[1]) - Number(a[1]))
    .map(([areaKey, weight]) => ({
      areaKey,
      weight: Number(weight),
      name: t(`lifeAreas.${areaKey}`) || areaKey
    }))
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

.habit-impact-section {
  display: flex;
  flex-direction: column;
  gap: 0.4rem;
  margin-bottom: 1.15rem;
  padding: 0.75rem;
  background-color: var(--bg-subtle);
  border-radius: var(--radius-md);
  border: 1px solid var(--border-subtle);
}

.habit-impact-label {
  font-size: 0.72rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  font-weight: 700;
  color: var(--text-muted);
}

.habit-impact-list {
  display: flex;
  flex-wrap: wrap;
  gap: 0.35rem;
}

.habit-impact-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  padding: 0.2rem 0.55rem;
  border-radius: var(--radius-pill);
  font-size: 0.76rem;
  font-weight: 500;
  background-color: var(--bg-surface);
  border: 1px solid var(--border-subtle);
  color: var(--text-primary);
}

.habit-impact-badge.weight-5 {
  border-color: rgba(34, 139, 34, 0.4);
  background-color: rgba(34, 139, 34, 0.08);
}

.habit-impact-badge.weight-4 {
  border-color: rgba(66, 133, 244, 0.35);
  background-color: rgba(66, 133, 244, 0.07);
}

.impact-score {
  font-weight: 700;
  font-size: 0.7rem;
  color: var(--primary);
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
