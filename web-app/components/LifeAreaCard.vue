<template>
  <div class="area-card card">
    <div class="area-card-top">
      <span class="area-icon">{{ area.icon }}</span>
      <span class="area-category-tag" :class="area.categoryClass">
        {{ t(`categories.${area.category}`) }}
      </span>
    </div>

    <h3 class="area-title">
      {{ t(`areas.${area.id}.name`) }}
    </h3>

    <p class="area-desc">
      {{ t(`areas.${area.id}.desc`) }}
    </p>

    <div class="area-focus-pill">
      <strong>{{ t('labels.focalTarget') }}:</strong>
      <span>{{ t(`areas.${area.id}.target`) }}</span>
    </div>

    <div v-if="guideRoute" class="area-action-link">
      <NuxtLink :to="localePath(guideRoute)" class="dimension-guide-link">
        <span>{{ t('labels.exploreGuide') }}</span>
        <svg width="14" height="14" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
          <path d="M5 12h14"></path>
          <path d="m12 5 7 7-7 7"></path>
        </svg>
      </NuxtLink>
    </div>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useComponentI18n, useLocalePath, type CanonicalRouteKey } from '~/composables/useLocale'

export interface LifeAreaItem {
  id: string
  category: 'vitality' | 'prosperity' | 'connection' | 'attention'
  icon: string
  categoryClass: string
  guideKey?: CanonicalRouteKey | null
}

const props = defineProps<{
  area: LifeAreaItem
}>()

const { localePath } = useLocalePath()

// Component-Scoped Translation Dictionary (en-US, pt-BR, eo)
const cardTranslations = {
  'en-US': {
    labels: {
      focalTarget: 'Focus Target',
      exploreGuide: 'Explore Foundation Guide'
    },
    categories: {
      vitality: 'Vitality & Self',
      prosperity: 'Work & Prosperity',
      connection: 'Connection & Heart',
      attention: 'Attention & Spirit'
    },
    areas: {
      health: {
        name: 'Health & Physical Fitness',
        desc: 'Energy vitality, consistent movement, restorative sleep, and nourishing nutrition.',
        target: 'Consistent physical vitality and restorative sleep patterns.'
      },
      mental: {
        name: 'Mental & Emotional Wellbeing',
        desc: 'Mindfulness, emotional regulation, inner calm, and resilience under pressure.',
        target: 'Daily presence practices and compassionate self-talk.'
      },
      learning: {
        name: 'Personal Growth & Learning',
        desc: 'Acquiring craft skills, intellectual curiosity, self-education, and reflection.',
        target: 'Reading, intentional learning blocks, and reflective journaling.'
      },
      career: {
        name: 'Career & Professional Calling',
        desc: 'Meaningful work, professional craft mastery, contribution, and impact.',
        target: 'Deep work focus on high-impact projects.'
      },
      finances: {
        name: 'Finances & Wealth',
        desc: 'Financial security, responsible stewardship, intentional saving, and freedom.',
        target: 'Conscious budgeting, saving habits, and reducing wasteful expenditures.'
      },
      environment: {
        name: 'Physical Environment & Spaces',
        desc: 'Home order, clean workspace, functional aesthetics, and peaceful surroundings.',
        target: 'Orderly living areas and distraction-free work zones.'
      },
      relationships: {
        name: 'Relationships & Intimacy',
        desc: 'Deep romantic partnership, mutual vulnerability, trust, and shared vision.',
        target: 'Protected quality time and honest communication.'
      },
      family: {
        name: 'Family & Parenting',
        desc: 'Kinship ties, nurturing children, honoring elders, and familial warmth.',
        target: 'Presence during family moments and shared meals.'
      },
      friendships: {
        name: 'Friendships & Community',
        desc: 'Social circles, genuine camaraderie, belonging, and mutual support.',
        target: 'Reaching out intentionally and shared community activities.'
      },
      recreation: {
        name: 'Recreation, Hobbies & Play',
        desc: 'Unapologetic joy, artistic expression, playfulness, and rejuvenation.',
        target: 'Regular creative leisure away from digital screens.'
      },
      focus: {
        name: 'Focus & Attention Mastery',
        desc: 'Digital hygiene, protective boundaries, deep work, and mindfulness.',
        target: 'Digital curfews and eliminating compulsive attention leaks.'
      },
      contribution: {
        name: 'Contribution & Legacy',
        desc: 'Giving back, mentoring others, charitable work, and leaving a positive footprint.',
        target: 'Mentorship, volunteering, and supporting people in need.'
      }
    }
  },
  'pt-BR': {
    labels: {
      focalTarget: 'Foco Central',
      exploreGuide: 'Explorar Guia da Dimensão'
    },
    categories: {
      vitality: 'Vitalidade & Eu',
      prosperity: 'Trabalho & Prosperidade',
      connection: 'Conexão & Coração',
      attention: 'Atenção & Espírito'
    },
    areas: {
      health: {
        name: 'Saúde & Condicionamento Físico',
        desc: 'Vitalidade energética, movimento regular, sono restaurador e alimentação consciente.',
        target: 'Vitalidade física sustentável e sono restaurador.'
      },
      mental: {
        name: 'Bem-Estar Mental & Emocional',
        desc: 'Atenção plena, serenidade mental, regulação emocional e resiliência interna.',
        target: 'Práticas diárias de presença e autocompaixão.'
      },
      learning: {
        name: 'Crescimento Pessoal & Aprendizado',
        desc: 'Aquisição de habilidades, curiosidade intelectual, autoeducação e autorreflexão.',
        target: 'Leitura consistente e blocos de aprendizagem intencional.'
      },
      career: {
        name: 'Carreira & Vocação Profissional',
        desc: 'Trabalho com propósito, maestria técnica, vocação e impacto positivo.',
        target: 'Foco em trabalho profundo e projetos de alto impacto.'
      },
      finances: {
        name: 'Finanças & Prosperidade',
        desc: 'Segurança financeira, gestão consciente, poupança metódica e autonomia.',
        target: 'Orçamento consciente e disciplina sustentável de poupança.'
      },
      environment: {
        name: 'Ambiente Físico & Espaços',
        desc: 'Harmonia doméstica, espaço de trabalho funcional, estética e paz ao redor.',
        target: 'Ambientes ordenados e livres de ruído visual desnecessário.'
      },
      relationships: {
        name: 'Relacionamentos & Intimidade',
        desc: 'Parceria amorosa genuína, vulnerabilidade mútua, confiança e cumplicidade.',
        target: 'Tempo de qualidade intencional e diálogo transparente.'
      },
      family: {
        name: 'Família & Parentalidade',
        desc: 'Vínculos familiares, cuidado com filhos, respeito aos ancestrais e acolhimento.',
        target: 'Presença ativa em momentos familiares e refeições conjuntas.'
      },
      friendships: {
        name: 'Amizades & Comunidade',
        desc: 'Círculo social autêntico, fraternidade leal, pertencimento e apoio mútuo.',
        target: 'Cultivo deliberado de laços sinceros e projetos comunitários.'
      },
      recreation: {
        name: 'Lazer, Hobbies & Diversão',
        desc: 'Alegria espontânea, expressão criativa, brincadeira saudável e renovação.',
        target: 'Momentos regulares de descompressão criativa sem telas.'
      },
      focus: {
        name: 'Domínio da Atenção & Foco',
        desc: 'Higiene digital, fronteiras conscientes, foco profundo e discernimento.',
        target: 'Pausas programadas de conectividade e defesa contra distrações.'
      },
      contribution: {
        name: 'Contribuição & Legado',
        desc: 'Serviço ao próximo, mentoria, generosidade ativa e pegada transformadora.',
        target: 'Ações voluntárias e dedicação ao bem-estar coletivo.'
      }
    }
  },
  'eo': {
    labels: {
      focalTarget: 'Ĉefa Celo',
      exploreGuide: 'Esplori Gvidilon de Vivfako'
    },
    categories: {
      vitality: 'Vigleco & Memo',
      prosperity: 'Laboro & Prospero',
      connection: 'Konekto & Koro',
      attention: 'Atento & Spirito'
    },
    areas: {
      health: {
        name: 'Sano & Fizika Taŭgeco',
        desc: 'Energia vigleco, konstanta movado, restaŭra dormo kaj konscia nutrado.',
        target: 'Daŭripova fizika vigleco kaj restaŭraj dormkutimoj.'
      },
      mental: {
        name: 'Mensa & Emocia Bonfarto',
        desc: 'Atenteco, trankvilo, emocia ekvilibro kaj rezistemo sub premo.',
        target: 'Ĉiutagaj praktikoj de nuntempeco kaj interna trankvilo.'
      },
      learning: {
        name: 'Persona Kresko & Lernado',
        desc: 'Akiro de kapabloj, intelekta scivolemo, mem-edukado kaj profunda pensado.',
        target: 'Regula legado kaj celkonsciaj lernblokoj.'
      },
      career: {
        name: 'Kariero & Profesia Vokiĝo',
        desc: 'Signifoplena laboro, profesia majstreco, kontribuo kaj persona efiko.',
        target: 'Profunda fokuso sur alt-efikaj projektoj.'
      },
      finances: {
        name: 'Financoj & Riĉo',
        desc: 'Financa sekureco, respondeca administrado, celkonscia ŝparado kaj libereco.',
        target: 'Konscia buĝetado kaj daŭripova financa trankvilo.'
      },
      environment: {
        name: 'Fizika Medio & Spacoj',
        desc: 'Hejma ordo, pura laborejo, funkcia estetiko kaj trankvilaj ĉirkaŭaĵoj.',
        target: 'Ordigitaj loĝspacoj kaj seninterrompaj laborzonoj.'
      },
      relationships: {
        name: 'Rilatoj & Intimeco',
        desc: 'Profunda romantika partnereco, reciproka fidindeco kaj komuna viv-vizio.',
        target: 'Protektita kvalita tempo kaj sincera komunikado.'
      },
      family: {
        name: 'Familio & Gepatreco',
        desc: 'Familiaj ligoj, zorgado pri infanoj, respekto al aĝuloj kaj hejma varmo.',
        target: 'Ĉeesto dum familiaj momentoj kaj komunaj manĝoj.'
      },
      friendships: {
        name: 'Amikecoj & Komunumo',
        desc: 'Aŭtentika socia rondo, sincera kamaradeco, aparteno kaj reciproka subteno.',
        target: 'Intenca kontakto kaj komunaj sociaj aktivecoj.'
      },
      recreation: {
        name: 'Distrado, Ŝatokupoj & Ludo',
        desc: 'Aŭtenta ĝojo, arta esprimo, kreemo kaj anim-ripozo.',
        target: 'Regula krea libertempo for de ciferecaj ekranoj.'
      },
      focus: {
        name: 'Fokuso & Atenta Majstreco',
        desc: 'Cifereca higieno, protektaj limoj, profunda laboro kaj spirita trankvilo.',
        target: 'Ciferecaj limoj kaj forigo de senkonsciaj distroj.'
      },
      contribution: {
        name: 'Kontribuo & Heredaĵo',
        desc: 'Helpo al aliuloj, mentorado, bonfarado kaj pozitiva spuro en la mondo.',
        target: 'Volontulado, mentorado kaj helpo al bezonantoj.'
      }
    }
  }
}

const { t } = useComponentI18n(cardTranslations)

// Mapping from area id to canonical route key for all 12 life areas
const defaultGuideMap: Record<string, CanonicalRouteKey> = {
  health: 'life_area_health_fitness',
  mental: 'life_area_mental_emotional',
  learning: 'life_area_personal_growth',
  career: 'life_area_career_calling',
  finances: 'life_area_finances_wealth',
  environment: 'life_area_physical_environment',
  relationships: 'life_area_relationships_intimacy',
  family: 'life_area_family_parenting',
  friendships: 'life_area_friendships_community',
  recreation: 'life_area_recreation_play',
  focus: 'life_area_focus_mastery',
  contribution: 'life_area_contribution_legacy'
}

const guideRoute = computed<CanonicalRouteKey | string | null>(() => {
  if (props.area.guideKey !== undefined) {
    return props.area.guideKey
  }
  return defaultGuideMap[props.area.id] || null
})
</script>

<style scoped>
.area-card {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  background-color: var(--bg-surface);
}

.area-card-top {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.area-icon {
  font-size: 1.75rem;
}

.area-category-tag {
  font-size: 0.75rem;
  font-weight: 700;
  padding: 0.25rem 0.65rem;
  border-radius: var(--radius-pill);
}

.area-title {
  font-size: 1.15rem;
  color: var(--text-primary);
}

.area-desc {
  font-size: 0.9rem;
  line-height: 1.6;
  color: var(--text-secondary);
}

.area-focus-pill {
  margin-top: auto;
  padding-top: 0.75rem;
  border-top: 1px solid var(--border-subtle);
  font-size: 0.82rem;
  color: var(--text-muted);
}

.area-focus-pill strong {
  color: var(--text-primary);
  display: block;
  margin-bottom: 2px;
}

.area-action-link {
  margin-top: 0.75rem;
  padding-top: 0.75rem;
  border-top: 1px dashed var(--border-subtle);
}

.dimension-guide-link {
  display: inline-flex;
  align-items: center;
  gap: 6px;
  font-size: 0.8125rem;
  font-weight: 600;
  color: var(--primary);
  text-decoration: none;
  transition: all var(--transition-fast);
}

.dimension-guide-link:hover {
  color: var(--primary-hover);
  transform: translateX(3px);
}
</style>
