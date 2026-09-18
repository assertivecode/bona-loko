<template>
  <div class="landing-page">
    <!-- =========================================================================
         1. HERO SECTION
         ========================================================================= -->
    <section class="hero-section">
      <div class="container hero-container">
        <h1 class="hero-title animate-fade-in">
          {{ t('hero.title') }}
        </h1>

        <p class="hero-subtitle animate-fade-in">
          {{ t('hero.subtitle') }}
        </p>

        <!-- CTAs -->
        <div class="hero-cta-group animate-fade-in">
          <a href="#life-areas" class="btn btn-primary btn-lg">
            <span>{{ t('hero.ctaExplore') }}</span>
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <line x1="12" y1="5" x2="12" y2="19"></line>
              <polyline points="19 12 12 19 5 12"></polyline>
            </svg>
          </a>
          <NuxtLink to="/mission" class="btn btn-outline btn-lg">
            <span>{{ t('hero.ctaMission') }}</span>
            <svg width="18" height="18" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
              <path d="M5 12h14"></path>
              <path d="m12 5 7 7-7 7"></path>
            </svg>
          </NuxtLink>
        </div>

        <!-- Interactive Priority Gap Preview Widget -->
        <div class="hero-widget-card card shadow-lg">
          <div class="widget-header">
            <div class="widget-pill">
              <span class="pulse-dot"></span>
              <span>{{ t('hero.widgetTitle') }}</span>
            </div>
            <span class="widget-hint">{{ t('hero.widgetHint') }}</span>
          </div>

          <div class="widget-grid">
            <div class="widget-item">
              <span class="item-label">{{ t('hero.demoAreaLabel') }}</span>
              <span class="item-value highlight-orange">💪 {{ t('hero.demoArea') }}</span>
            </div>
            <div class="widget-item">
              <span class="item-label">{{ t('hero.demoPriority') }}</span>
              <div class="bar-container">
                <div class="bar-fill fill-orange" style="width: 90%;"></div>
              </div>
              <span class="bar-score">9/10 ({{ t('hero.high') }})</span>
            </div>
            <div class="widget-item">
              <span class="item-label">{{ t('hero.demoCurrentInv') }}</span>
              <div class="bar-container">
                <div class="bar-fill fill-slate" style="width: 25%;"></div>
              </div>
              <span class="bar-score">2.5/10 ({{ t('hero.low') }})</span>
            </div>
            <div class="widget-item gap-result">
              <span class="item-label">{{ t('hero.demoGap') }}</span>
              <span class="gap-tag">⚠️ {{ t('hero.demoGapAlert') }}</span>
            </div>
          </div>
          <div class="widget-footer">
            <p>{{ t('hero.widgetResolution') }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- =========================================================================
         2. ESPERANTO ETYMOLOGY & CORE VALUES SECTION
         ========================================================================= -->
    <section class="section section-cream">
      <div class="container">
        <div class="section-header">
          <div class="badge badge-esperanto">
            ★ {{ t('etymology.sectionBadge') }}
          </div>
          <h2>{{ t('etymology.title') }}</h2>
          <p>{{ t('etymology.subtitle') }}</p>
        </div>

        <div class="etymology-grid">
          <!-- Card 1: Bona -->
          <div class="etymology-card card">
            <div class="etymology-header">
              <span class="word-badge badge-primary">Bona</span>
              <span class="lang-tag">Esperanto</span>
            </div>
            <h3>{{ t('etymology.bonaMeaning') }}</h3>
            <p>{{ t('etymology.bonaDesc') }}</p>
            <div class="etymology-pill">
              <span>✨ {{ t('etymology.bonaPill') }}</span>
            </div>
          </div>

          <!-- Connector Symbol -->
          <div class="etymology-connector">
            <span>+</span>
          </div>

          <!-- Card 2: Loko -->
          <div class="etymology-card card">
            <div class="etymology-header">
              <span class="word-badge badge-esperanto">Loko</span>
              <span class="lang-tag">Esperanto</span>
            </div>
            <h3>{{ t('etymology.lokoMeaning') }}</h3>
            <p>{{ t('etymology.lokoDesc') }}</p>
            <div class="etymology-pill pill-secondary">
              <span>🛡️ {{ t('etymology.lokoPill') }}</span>
            </div>
          </div>

          <!-- Equals Symbol -->
          <div class="etymology-connector">
            <span>=</span>
          </div>

          <!-- Card 3: Bona Loko Result -->
          <div class="etymology-card card result-card">
            <div class="etymology-header">
              <span class="word-badge badge-blue">Bona Loko</span>
              <span class="lang-tag">{{ t('etymology.valuesTag') }}</span>
            </div>
            <h3>{{ t('etymology.resultMeaning') }}</h3>
            <p>{{ t('etymology.resultDesc') }}</p>
            <div class="etymology-pill pill-blue">
              <span>🕊️ {{ t('etymology.resultPill') }}</span>
            </div>
          </div>
        </div>

        <div class="mentality-banner card">
          <div class="banner-icon">🌿</div>
          <div class="banner-content">
            <h4>{{ t('etymology.bannerTitle') }}</h4>
            <p>{{ t('etymology.bannerText') }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- =========================================================================
         3. 12 LIFE AREAS FRAMEWORK
         ========================================================================= -->
    <section id="life-areas" class="section">
      <div class="container">
        <div class="section-header">
          <div class="badge badge-primary">
            🧭 {{ t('areas.sectionBadge') }}
          </div>
          <h2>{{ t('areas.title') }}</h2>
          <p>{{ t('areas.subtitle') }}</p>
        </div>

        <!-- Category Filter Tabs -->
        <div class="filter-tabs">
          <button
            v-for="cat in areaCategories"
            :key="cat.id"
            type="button"
            class="tab-btn"
            :class="{ active: selectedCategory === cat.id }"
            @click="selectedCategory = cat.id"
          >
            <span>{{ cat.icon }}</span>
            <span>{{ t(`areas.cat_${cat.id}`) }}</span>
          </button>
        </div>

        <!-- Life Areas Grid -->
        <div class="areas-grid">
          <LifeAreaCard
            v-for="area in filteredAreas"
            :key="area.id"
            :area="area"
          />
        </div>
      </div>
    </section>

    <!-- =========================================================================
         4. MULTI-DIMENSIONAL PRIORITY MODEL
         ========================================================================= -->
    <section id="priority-model" class="section section-cream">
      <div class="container">
        <div class="section-header">
          <div class="badge badge-gold">
            📊 {{ t('model.sectionBadge') }}
          </div>
          <h2>{{ t('model.title') }}</h2>
          <p>{{ t('model.subtitle') }}</p>
        </div>

        <!-- 5-Dimensional Pipeline -->
        <div class="pipeline-container card shadow-md">
          <div class="pipeline-step">
            <span class="step-num">1</span>
            <div class="step-content">
              <h4>{{ t('model.dim1') }}</h4>
              <p>{{ t('model.dim1Desc') }}</p>
            </div>
          </div>
          <div class="pipeline-arrow">➔</div>

          <div class="pipeline-step">
            <span class="step-num">2</span>
            <div class="step-content">
              <h4>{{ t('model.dim2') }}</h4>
              <p>{{ t('model.dim2Desc') }}</p>
            </div>
          </div>
          <div class="pipeline-arrow">➔</div>

          <div class="pipeline-step">
            <span class="step-num">3</span>
            <div class="step-content">
              <h4>{{ t('model.dim3') }}</h4>
              <p>{{ t('model.dim3Desc') }}</p>
            </div>
          </div>
          <div class="pipeline-arrow">➔</div>

          <div class="pipeline-step">
            <span class="step-num">4</span>
            <div class="step-content">
              <h4>{{ t('model.dim4') }}</h4>
              <p>{{ t('model.dim4Desc') }}</p>
            </div>
          </div>
          <div class="pipeline-arrow">➔</div>

          <div class="pipeline-step step-highlight">
            <span class="step-num star">★</span>
            <div class="step-content">
              <h4>{{ t('model.dim5') }}</h4>
              <p>{{ t('model.dim5Desc') }}</p>
            </div>
          </div>
        </div>

        <!-- Core Pillars Grid -->
        <div class="comparison-grid grid-2">
          <div class="comparison-card card card-standard">
            <div class="card-status-badge badge-primary">🧭 {{ t('model.pillar1Badge') }}</div>
            <h3>{{ t('model.pillar1Heading') }}</h3>
            <ul class="comparison-list">
              <li>{{ t('model.pillar1Item1') }}</li>
              <li>{{ t('model.pillar1Item2') }}</li>
              <li>{{ t('model.pillar1Item3') }}</li>
            </ul>
          </div>

          <div class="comparison-card card card-bonaloko">
            <div class="card-status-badge badge-esperanto">🌱 {{ t('model.pillar2Badge') }}</div>
            <h3>{{ t('model.pillar2Heading') }}</h3>
            <ul class="comparison-list">
              <li>{{ t('model.pillar2Item1') }}</li>
              <li>{{ t('model.pillar2Item2') }}</li>
              <li>{{ t('model.pillar2Item3') }}</li>
            </ul>
          </div>
        </div>
      </div>
    </section>

    <!-- =========================================================================
         5. 7-STEP TRANSFORMATION ENGINE
         ========================================================================= -->
    <section id="transformation-engine" class="section">
      <div class="container">
        <div class="section-header">
          <div class="badge badge-primary">
            🔄 {{ t('engine.sectionBadge') }}
          </div>
          <h2>{{ t('engine.title') }}</h2>
          <p>{{ t('engine.subtitle') }}</p>
        </div>

        <div class="engine-steps-grid">
          <div
            v-for="(step, index) in engineSteps"
            :key="index"
            class="engine-card card"
          >
            <div class="engine-num-badge">{{ index + 1 }}</div>
            <div class="engine-icon">{{ step.icon }}</div>
            <h3>{{ t(`engine.step${index + 1}_title`) }}</h3>
            <p>{{ t(`engine.step${index + 1}_desc`) }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- =========================================================================
         6. FOCUS & DISTRACTION MASTERY
         ========================================================================= -->
    <section class="section section-cream">
      <div class="container">
        <div class="focus-layout">
          <div class="focus-text">
            <div class="badge badge-blue">
              🛡️ {{ t('focus.badge') }}
            </div>
            <h2>{{ t('focus.title') }}</h2>
            <p>{{ t('focus.subtitle') }}</p>

            <div class="focus-pillars">
              <div class="focus-pillar-item">
                <span class="pillar-icon">🔍</span>
                <div>
                  <h4>{{ t('focus.pillar1Title') }}</h4>
                  <p>{{ t('focus.pillar1Desc') }}</p>
                </div>
              </div>
              <div class="focus-pillar-item">
                <span class="pillar-icon">🔄</span>
                <div>
                  <h4>{{ t('focus.pillar2Title') }}</h4>
                  <p>{{ t('focus.pillar2Desc') }}</p>
                </div>
              </div>
              <div class="focus-pillar-item">
                <span class="pillar-icon">🧱</span>
                <div>
                  <h4>{{ t('focus.pillar3Title') }}</h4>
                  <p>{{ t('focus.pillar3Desc') }}</p>
                </div>
              </div>
            </div>
          </div>

          <div class="focus-card-side card shadow-lg">
            <div class="habit-bridge-header">
              <span class="bridge-tag">{{ t('focus.bridgeLabel') }}</span>
              <h3>{{ t('focus.bridgeTitle') }}</h3>
            </div>

            <div class="bridge-flow">
              <div class="bridge-node node-area">
                <span class="node-type">{{ t('focus.nodeArea') }}</span>
                <span class="node-val">Mental & Emotional Wellbeing</span>
              </div>
              <div class="bridge-arrow">↓</div>
              <div class="bridge-node node-priority">
                <span class="node-type">{{ t('focus.nodePriority') }}</span>
                <span class="node-val">High Priority Gap</span>
              </div>
              <div class="bridge-arrow">↓</div>
              <div class="bridge-node node-habit">
                <span class="node-type">{{ t('focus.nodeHabit') }}</span>
                <span class="node-val">{{ t('focus.nodeAction') }}</span>
              </div>
            </div>

            <div class="bridge-footer">
              <NuxtLink to="/about" class="btn btn-secondary btn-sm" style="width: 100%;">
                {{ t('focus.learnHabitAnatomy') }}
              </NuxtLink>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- =========================================================================
         7. FINAL CALL TO ACTION
         ========================================================================= -->
    <section class="section section-cta">
      <div class="container text-center">
        <div class="cta-inner card shadow-xl">
          <div class="cta-badge badge badge-esperanto">
            ★ {{ t('cta.badge') }}
          </div>
          <h2>{{ t('cta.title') }}</h2>
          <p class="cta-desc">
            {{ t('cta.desc') }}
          </p>

          <div class="cta-buttons">
            <NuxtLink to="/about" class="btn btn-primary btn-lg">
              {{ t('cta.btnAbout') }}
            </NuxtLink>
            <NuxtLink to="/mission" class="btn btn-outline btn-lg">
              {{ t('cta.btnMission') }}
            </NuxtLink>
          </div>

          <div class="cta-guarantee">
            <span>🛡️ {{ t('cta.guarantee') }}</span>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { useHead } from '#app'
import { useComponentI18n, useLocalePath, type CanonicalRouteKey } from '~/composables/useLocale'

// Component-Scoped Translation Dictionary for Landing Page (EN-US, PT-BR, EO)
const landingTranslations = {
  'en-US': {
    meta: {
      title: 'Bona Loko — Habit & Life Balance'
    },
    hero: {
      title: 'Understand what matters. Focus your attention. Build better habits.',
      subtitle: 'Bona Loko is an open-source personal development platform grounded in core values and a mentality focused in uncorruptibility, designed to bridge the gap between high-level life aspirations and daily actions without guilt or commercial distraction.',
      ctaExplore: 'Explore 12 Life Areas',
      ctaMission: 'Our Moral Constitution',
      widgetTitle: 'Priority Gap Engine',
      widgetHint: 'Live Diagnosis Concept',
      demoAreaLabel: 'Analyzed Life Area:',
      demoArea: 'Health & Physical Vitality',
      demoPriority: 'Current Priority:',
      demoCurrentInv: 'Current Attention/Time:',
      demoGap: 'Identified Priority Gap:',
      demoGapAlert: 'Critical Gap (-6.5 points)',
      widgetResolution: 'Bona Loko automatically creates behavioral micro-habits to incrementally close this gap without burnout.',
      high: 'High',
      low: 'Low'
    },
    etymology: {
      sectionBadge: 'Linguistic Heritage & Meaning',
      title: 'Why "Bona Loko"?',
      subtitle: 'The platform is named in Esperanto — the international language created for universal understanding, peace, and neutral communication.',
      bonaMeaning: 'Good, Virtuous, Healthy',
      bonaDesc: 'Represents authentic human potential, moral character, and what is genuinely positive and nourishing for your life.',
      bonaPill: 'Quality of Being & Action',
      lokoMeaning: 'Place, Space, Environment',
      lokoDesc: 'Represents an uncompromised environment — free from political capture, corporate ads, and manipulative algorithms.',
      lokoPill: 'Protected Digital Space',
      valuesTag: 'Core Values & Philosophy',
      resultMeaning: 'A "Good Place" to Grow',
      resultDesc: 'A neutral, sovereign canvas where you define what a good life means to you, align finite energy, and build sustainable habits.',
      resultPill: 'Universal Human Growth',
      bannerTitle: 'An Environment Guarded by Core Values',
      bannerText: 'Just as Esperanto belongs to all humanity without state ownership, Bona Loko is permanently shielded from political associations and corporate advertising.'
    },
    areas: {
      sectionBadge: 'Holistic Framework',
      title: 'The 12 Life Areas Framework',
      subtitle: 'Human existence is multi-dimensional. Inspired by the Wheel of Life, evaluate your baseline across four holistic quadrants:',
      cat_all: 'All Areas (12)',
      cat_vitality: 'Vitality & Self',
      cat_prosperity: 'Work & Prosperity',
      cat_connection: 'Connection & Heart',
      cat_attention: 'Attention & Spirit',
      focalTarget: 'Focus Target',
      exploreGuide: 'Explore Foundation Guide',
      // Areas
      health_name: 'Health & Physical Fitness',
      health_desc: 'Energy vitality, consistent movement, restorative sleep, and nourishing nutrition.',
      health_target: 'Consistent physical vitality and restorative sleep patterns.',
      mental_name: 'Mental & Emotional Wellbeing',
      mental_desc: 'Mindfulness, emotional regulation, inner calm, and resilience under pressure.',
      mental_target: 'Daily presence practices and compassionate self-talk.',
      learning_name: 'Personal Growth & Learning',
      learning_desc: 'Acquiring craft skills, intellectual curiosity, self-education, and reflection.',
      learning_target: 'Reading, intentional learning blocks, and reflective journaling.',
      career_name: 'Career & Professional Calling',
      career_desc: 'Meaningful work, professional craft mastery, contribution, and impact.',
      career_target: 'Deep work focus on high-impact projects.',
      finances_name: 'Finances & Wealth',
      finances_desc: 'Financial security, responsible stewardship, intentional saving, and freedom.',
      finances_target: 'Conscious budgeting, saving habits, and reducing wasteful expenditures.',
      environment_name: 'Physical Environment & Spaces',
      environment_desc: 'Home order, clean workspace, functional aesthetics, and peaceful surroundings.',
      environment_target: 'Orderly living areas and distraction-free work zones.',
      relationships_name: 'Relationships & Intimacy',
      relationships_desc: 'Deep romantic partnership, mutual vulnerability, trust, and shared vision.',
      relationships_target: 'Protected quality time and honest communication.',
      family_name: 'Family & Parenting',
      family_desc: 'Kinship ties, nurturing children, honoring elders, and familial warmth.',
      family_target: 'Presence during family moments and shared meals.',
      friendships_name: 'Friendships & Community',
      friendships_desc: 'Social circles, genuine camaraderie, belonging, and mutual support.',
      friendships_target: 'Reaching out intentionally and shared community activities.',
      recreation_name: 'Recreation, Hobbies & Play',
      recreation_desc: 'Unapologetic joy, artistic expression, playfulness, and rejuvenation.',
      recreation_target: 'Regular creative leisure away from digital screens.',
      focus_name: 'Focus & Attention Mastery',
      focus_desc: 'Digital hygiene, protective boundaries, deep work, and mindfulness.',
      focus_target: 'Digital curfews and eliminating compulsive attention leaks.',
      contribution_name: 'Contribution & Legacy',
      contribution_desc: 'Giving back, mentoring others, charitable work, and leaving a positive footprint.',
      contribution_target: 'Mentorship, volunteering, and supporting people in need.'
    },
    model: {
      sectionBadge: 'Five-Dimensional Intelligence',
      title: 'The Multi-Dimensional Priority Model',
      subtitle: 'Bona Loko measures the real dynamic between personal values, time, and attention across five complementary dimensions.',
      dim1: 'Current Priority',
      dim1Desc: 'How much priority does this area hold in your current moment of life?',
      dim2: 'Satisfaction',
      dim2Desc: 'How content are you with its current state?',
      dim3: 'Current Investment',
      dim3Desc: 'How much actual time and energy do you spend?',
      dim4: 'Desired Investment',
      dim4Desc: 'How much attention would you consciously like to invest?',
      dim5: 'Priority Gap',
      dim5Desc: 'Identifies where actions diverge from intentions.',
      pillar1Badge: 'Awareness & Reality',
      pillar1Heading: 'Attention Discovery',
      pillar1Item1: 'Maps finite time and physical energy with honest clarity.',
      pillar1Item2: 'Identifies where attention leaks into unintended distractions.',
      pillar1Item3: 'Surfaces personal priority gaps without guilt or judgment.',
      pillar2Badge: 'Intentional Alignment',
      pillar2Heading: 'Purposeful Action',
      pillar2Item1: 'Ties every micro-habit to a parent life area and stated purpose.',
      pillar2Item2: 'Replaces guilt with compassionate reflection and realistic adjustments.',
      pillar2Item3: 'Treats distraction replacement as an equal partner to habit formation.'
    },
    engine: {
      sectionBadge: 'Iterative Engine',
      title: 'The 7-Step Transformation Engine',
      subtitle: 'Continuous, cyclical personal growth grounded in self-awareness and gentle momentum.',
      step1_title: '1. Assess',
      step1_desc: 'Map your holistic baseline across the 12 life areas in minutes.',
      step2_title: '2. Prioritize',
      step2_desc: 'Distinguish your top focal domains from areas to maintain or deprioritize.',
      step3_title: '3. Identify Gaps',
      step3_desc: 'Surface disparities between what matters and where your attention actually goes.',
      step4_title: '4. Define Habits',
      step4_desc: 'Craft specific, trigger-anchored micro-behaviors designed to close priority gaps.',
      step5_title: '5. Practice',
      step5_desc: 'Track consistency, schedules, and momentum without punitive streak penalties.',
      step6_title: '6. Reflect',
      step6_desc: 'Capture qualitative observations on friction, mood, and daily attention.',
      step7_title: '7. Adjust',
      step7_desc: 'Realign priorities periodically as life seasons and circumstances evolve.'
    },
    focus: {
      badge: 'Attention Protection',
      title: 'Attention Mastery & Distraction Defense',
      subtitle: 'Investing time in our genuine priorities flourishes when attention is mindfully protected from unintentional distractions.',
      pillar1Title: 'Distraction Inventory',
      pillar1Desc: 'Identify personal attention leaks (compulsive phone checking, endless feeds, avoidance behaviors).',
      pillar2Title: 'Trigger Awareness',
      pillar2Desc: 'Uncover the contextual cues and emotions preceding mindless scrolling.',
      pillar3Title: 'Replacement Habits',
      pillar3Desc: 'Substitute constructive behaviors (e.g. taking a walk, reading a physical book) in place of distraction triggers.',
      bridgeLabel: 'Behavioral Bridge Concept',
      bridgeTitle: 'From Life Area to Daily Action',
      nodeArea: 'Parent Life Area',
      nodePriority: 'Priority State',
      nodeHabit: 'Actionable Habit',
      nodeAction: '10 min mindful breathing when feeling overwhelmed before checking phone.',
      learnHabitAnatomy: 'Explore Habit Anatomy in About →'
    },
    cta: {
      badge: 'Your Journey Awaits',
      title: 'Start Living in a "Good Place"',
      desc: 'Discover your life balance, clarify what matters, and build daily habits with full autonomy backed by uncorruptible core values.',
      btnAbout: 'Read Our Philosophy',
      btnMission: 'Review Moral Constitution',
      guarantee: '100% Free & Open Source • Zero Dark Patterns • No Political Captivity'
    }
  },
  'pt-BR': {
    meta: {
      title: 'Bona Loko — Hábitos & Equilíbrio de Vida'
    },
    hero: {
      title: 'Entenda o que importa. Foque sua atenção. Construa hábitos melhores.',
      subtitle: 'Bona Loko é uma plataforma de desenvolvimento pessoal de código aberto fundamentada em valores essenciais e uma mentalidade focada na incorruptibilidade, projetada para unir aspirações de vida a ações diárias sem culpa ou distrações comerciais.',
      ctaExplore: 'Explorar as 12 Áreas da Vida',
      ctaMission: 'Nossa Constituição Moral',
      widgetTitle: 'Motor de Lacunas de Prioridade',
      widgetHint: 'Conceito de Diagnóstico ao Vivo',
      demoAreaLabel: 'Área da Vida Analisada:',
      demoArea: 'Saúde & Vitalidade Física',
      demoPriority: 'Prioridade Atual:',
      demoCurrentInv: 'Tempo/Atenção Atual:',
      demoGap: 'Lacuna de Prioridade Identificada:',
      demoGapAlert: 'Lacuna Crítica (-6.5 pontos)',
      widgetResolution: 'Bona Loko cria micro-hábitos comportamentais para fechar essa distância progressivamente, sem esgotamento.',
      high: 'Alta',
      low: 'Baixa'
    },
    etymology: {
      sectionBadge: 'Herança Linguística & Significado',
      title: 'Por que "Bona Loko"?',
      subtitle: 'A plataforma tem seu nome no idioma Esperanto — a língua internacional criada para a compreensão universal, paz e neutralidade.',
      bonaMeaning: 'Bom, Virtuoso, Saudável',
      bonaDesc: 'Representa o autêntico potencial humano, o caráter moral e tudo o que é genuinamente positivo e nutriente para sua vida.',
      bonaPill: 'Qualidade de Ser & Agir',
      lokoMeaning: 'Lugar, Espaço, Ambiente',
      lokoDesc: 'Representa um ambiente incorruptível — livre de captura política, anúncios comerciais e algoritmos manipuladores.',
      lokoPill: 'Espaço Digital Protegido',
      valuesTag: 'Valores Fundamentais & Filosofia',
      resultMeaning: 'Um "Bom Lugar" para Crescer',
      resultDesc: 'Um espaço neutro e soberano onde você define o que significa viver bem, alinha sua energia finita e constrói hábitos sustentáveis.',
      resultPill: 'Crescimento Humano Universal',
      bannerTitle: 'Um Ambiente Protegido por Valores Essenciais',
      bannerText: 'Assim como o Esperanto pertence a toda a humanidade sem propriedade estatal, a Bona Loko é permanentemente protegido de afiliações políticas e mercantilização.'
    },
    areas: {
      sectionBadge: 'Estrutura Holística',
      title: 'O Modelo das 12 Áreas da Vida',
      subtitle: 'A existência humana é multifacetada. Inspirado na Roda da Vida, avalie seu estado atual em quatro quadrantes holísticos:',
      cat_all: 'Todas as Áreas (12)',
      cat_vitality: 'Vitalidade & Eu',
      cat_prosperity: 'Trabalho & Prosperidade',
      cat_connection: 'Conexão & Coração',
      cat_attention: 'Atenção & Espírito',
      focalTarget: 'Foco Central',
      exploreGuide: 'Explorar Guia da Dimensão',
      health_name: 'Saúde & Condicionamento Físico',
      health_desc: 'Vitalidade energética, movimento regular, sono restaurador e alimentação consciente.',
      health_target: 'Vitalidade física sustentável e sono restaurador.',
      mental_name: 'Bem-Estar Mental & Emocional',
      mental_desc: 'Atenção plena, serenidade mental, regulação emocional e resiliência interna.',
      mental_target: 'Práticas diárias de presença e autocompaixão.',
      learning_name: 'Crescimento Pessoal & Aprendizado',
      learning_desc: 'Aquisição de habilidades, curiosidade intelectual, autoeducação e autorreflexão.',
      learning_target: 'Leitura consistente e blocos de aprendizagem intencional.',
      career_name: 'Carreira & Vocação Profissional',
      career_desc: 'Trabalho com propósito, maestria técnica, contribuição e realização profissional.',
      career_target: 'Trabalho focado e sem distrações em projetos de alto impacto.',
      finances_name: 'Finanças & Prosperidade',
      finances_desc: 'Segurança financeira, mordomia responsável, poupança consciente e autonomia.',
      finances_target: 'Orçamento consciente e eliminação de gastos supérfluos.',
      environment_name: 'Ambiente Físico & Espaços',
      environment_desc: 'Ordem no lar, ambiente de trabalho limpo, beleza estética e tranquilidade espacial.',
      environment_target: 'Organização dos espaços cotidianos e zonas livres de bagunça.',
      relationships_name: 'Relacionamentos & Intimidade',
      relationships_desc: 'Parceria amorosa profunda, vulnerabilidade mútua, confiança e visão compartilhada.',
      relationships_target: 'Tempo protegido a dois e diálogo sincero.',
      family_name: 'Família & Parentalidade',
      family_desc: 'Vínculos familiares, cuidado com os filhos, honra aos pais e acolhimento familiar.',
      family_target: 'Presença genuína nos momentos familiares.',
      friendships_name: 'Amizades & Comunidade',
      friendships_desc: 'Círculo de amigos, companheirismo autêntico, sensação de pertença e apoio mútuo.',
      friendships_target: 'Contato intencional e momentos de partilha social.',
      recreation_name: 'Recreação, Hobbies & Lazer',
      recreation_desc: 'Alegria espontânea, expressão artística, criatividade e renovação de energia.',
      recreation_target: 'Lazer ativo longe de telas e redes sociais.',
      focus_name: 'Domínio do Foco & Atenção',
      focus_desc: 'Higiene digital, estabelecimento de limites claros, trabalho profundo e presença.',
      focus_target: 'Toques de recolher digitais e eliminação de distrações compulsivas.',
      contribution_name: 'Contribuição & Legado',
      contribution_desc: 'Generosidade, mentoria, ajuda voluntária e impacto social positivo.',
      contribution_target: 'Ações solidárias e apoio a quem mais precisa.'
    },
    model: {
      sectionBadge: 'Inteligência Pentadimensional',
      title: 'O Modelo de Prioridades Multidimensional',
      subtitle: 'A Bona Loko analisa a dinâmica real entre seus valores pessoais, tempo e atenção através de cinco dimensões complementares.',
      dim1: 'Prioridade Atual',
      dim1Desc: 'Qual o nível de prioridade desta área no seu momento de vida atual?',
      dim2: 'Satisfação',
      dim2Desc: 'Quão satisfeito você está com o estado atual dela?',
      dim3: 'Investimento Atual',
      dim3Desc: 'Quanto tempo e energia você dedica hoje na prática?',
      dim4: 'Investimento Desejado',
      dim4Desc: 'Quanto tempo você conscientemente gostaria de investir?',
      dim5: 'Lacuna de Prioridade',
      dim5Desc: 'Identifica onde as ações diárias divergem dos desejos reais.',
      pillar1Badge: 'Consciência & Realidade',
      pillar1Heading: 'Descoberta da Atenção',
      pillar1Item1: 'Mapeia tempo e energia finitos com clareza serena.',
      pillar1Item2: 'Identifica onde a atenção escapa em distrações inconscientes.',
      pillar1Item3: 'Evidencia lacunas de prioridade sem culpa ou julgamentos.',
      pillar2Badge: 'Alinhamento Intencional',
      pillar2Heading: 'Ação com Propósito',
      pillar2Item1: 'Conecta cada micro-hábito a uma área da vida e a um propósito claro.',
      pillar2Item2: 'Substitui a culpa por reflexão compreensiva e ajustes realistas.',
      pillar2Item3: 'Trata a gestão de distrações com a mesma importância da formação de hábitos.'
    },
    engine: {
      sectionBadge: 'Motor Iterativo',
      title: 'O Motor de Transformação em 7 Passos',
      subtitle: 'Crescimento pessoal contínuo e cíclico, baseado em autoconsciência e constância gentil.',
      step1_title: '1. Avaliar',
      step1_desc: 'Mapeie sua base holística nas 12 áreas da vida em poucos minutos.',
      step2_title: '2. Priorizar',
      step2_desc: 'Distinga seus pontos focais principais das áreas a manter ou despriorizar.',
      step3_title: '3. Identificar Lacunas',
      step3_desc: 'Evidencie onde sua intenção real diverge da sua rotina prática.',
      step4_title: '4. Definir Hábitos',
      step4_desc: 'Crie microcomportamentos ancorados em gatilhos específicos para fechar as lacunas.',
      step5_title: '5. Praticar',
      step5_desc: 'Acompanhe regularidade e ritmo sem sistemas punitivos de sequência.',
      step6_title: '6. Refletir',
      step6_desc: 'Registre notas qualitativas sobre atritos, energia e atenção diária.',
      step7_title: '7. Ajustar',
      step7_desc: 'Realinhe prioridades conforme as estações e circunstâncias da vida mudam.'
    },
    focus: {
      badge: 'Proteção da Atenção',
      title: 'Domínio da Atenção & Gestão de Distrações',
      subtitle: 'O investimento consciente de tempo em nossas verdadeiras prioridades floresce quando protegemos nossa atenção de distrações involuntárias.',
      pillar1Title: 'Inventário de Distrações',
      pillar1Desc: 'Identifique os vazamentos de atenção (rolagem infinita, verificação compulsiva, procrastinação).',
      pillar2Title: 'Consciência de Gatilhos',
      pillar2Desc: 'Reconheça as pistas contextuais e emoções que disparam comportamentos automáticos.',
      pillar3Title: 'Hábitos de Substituição',
      pillar3Desc: 'Substitua impulsos prejudiciais por alternativas saudáveis (caminhar, ler um livro físico).',
      bridgeLabel: 'Conceito da Ponte Comportamental',
      bridgeTitle: 'Da Área da Vida à Ação Diária',
      nodeArea: 'Área da Vida Mãe',
      nodePriority: 'Estado de Prioridade',
      nodeHabit: 'Hábito Prático',
      nodeAction: '10 minutos de respiração consciente ao sentir sobrecarga antes de checar o celular.',
      learnHabitAnatomy: 'Conheça a Anatomia do Hábito na página Sobre →'
    },
    cta: {
      badge: 'Sua Jornada Começa Aqui',
      title: 'Comece a Viver em um "Bom Lugar"',
      desc: 'Descubra seu equilíbrio de vida, esclareça o que importa e construa hábitos diários com autonomia total sustentada por valores incorruptíveis.',
      btnAbout: 'Leia Nossa Filosofia',
      btnMission: 'Ver Constituição Moral',
      guarantee: '100% Gratuito & Aberto • Sem Padrões Obscuros • Sem Captura Política'
    }
  },
  eo: {
    meta: {
      title: 'Bona Loko — Kutimoj & Viv-Ekvilibro'
    },
    hero: {
      title: 'Komprenu kio gravas. Foku vian atenton. Konstruu pli bonajn kutimojn.',
      subtitle: 'Bona Loko estas malfermfonta platformo por persona disvolviĝo bazita sur kernaj valoroj kaj pensmaniero fokusita al nekoruptebleco, desegnita por ligi viv-aspirojn al ĉiutagaj agoj sen kulpo aŭ komercaj distraĵoj.',
      ctaExplore: 'Esplori la 12 Vivareojn',
      ctaMission: 'Nia Morala Konstitucio',
      widgetTitle: 'Motoro de Prioritataj Mankoj',
      widgetHint: 'Viva Diagnoza Koncepto',
      demoAreaLabel: 'Analizita Vivareo:',
      demoArea: 'Sano & Fizika Vigleco',
      demoPriority: 'Nuna Prioritato:',
      demoCurrentInv: 'Nuna Atento/Tempo:',
      demoGap: 'Identigita Prioritata Manko:',
      demoGapAlert: 'Kritika Manko (-6.5 poentoj)',
      widgetResolution: 'Bona Loko kreas kondutajn mikro-kutimojn por iom post iom fermi ĉi tiun breĉon sen elĉerpiĝo.',
      high: 'Alta',
      low: 'Malalta'
    },
    etymology: {
      sectionBadge: 'Lingva Heredaĵo & Signifo',
      title: 'Kial "Bona Loko"?',
      subtitle: 'La platformo estas nomita en Esperanto — la internacia lingvo kreita por universala kompreno, paco kaj neŭtrala komunikado.',
      bonaMeaning: 'Bona, Virta, Sana',
      bonaDesc: 'Reprezentas aŭtentan homan potencialon, moralan karakteron kaj tion, kio estas vere pozitiva kaj nutra por via vivo.',
      bonaPill: 'Kvalito de Esto & Ago',
      lokoMeaning: 'Loko, Spaco, Medio',
      lokoDesc: 'Reprezentas nekorupteblan medion — libera de politika kapto, kompaniaj reklamoj kaj manipulaj algoritmoj.',
      lokoPill: 'Protektita Cifereca Spaco',
      valuesTag: 'Kernaj Valoroj & Filozofio',
      resultMeaning: 'Unu "Bona Loko" por Kreski',
      resultDesc: 'Neŭtrala kaj suverena spaco kie vi difinas kion signifas bona vivo, akordigas vian energion kaj konstruas daŭripovajn kutimojn.',
      resultPill: 'Universala Homa Kresko',
      bannerTitle: 'Medio Protektita per Kernaj Reguloj',
      bannerText: 'Same kiel Esperanto apartenas al la tuta homaro sen ŝtata posedo, Bona Loko estas konstante ŝirmita kontraŭ politikaj asocioj kaj komerca manipulado.'
    },
    areas: {
      sectionBadge: 'Tuteca Kadro',
      title: 'La Kadro de 12 Vivareoj',
      subtitle: 'Homa ekzisto estas multdimensia. Inspirita de la Rado de Vivo, taksu vian bazlinion tra kvar tutaj sektoroj:',
      cat_all: 'Ĉiuj Areoj (12)',
      cat_vitality: 'Vigleco & Memo',
      cat_prosperity: 'Laboro & Prospero',
      cat_connection: 'Konekto & Koro',
      cat_attention: 'Atento & Spirito',
      focalTarget: 'Ĉefa Celo',
      exploreGuide: 'Esplori Gvidilon de Vivfako',
      health_name: 'Sano & Fizika Taŭgeco',
      health_desc: 'Energia vigleco, konstanta movado, restaŭra dormo kaj konscia nutrado.',
      health_target: 'Daŭripova fizika vigleco kaj restaŭraj dormaj kutimoj.',
      mental_name: 'Mensa & Emocia Bonfarto',
      mental_desc: 'Atenteco, trankvilo, emocia ekvilibro kaj interna rezisteco.',
      mental_target: 'Ĉiutagaj praktikoj de ĉeesto kaj kompato al si mem.',
      learning_name: 'Persona Kresko & Lernado',
      learning_desc: 'Akiro de kapabloj, intelekta scivolemo, memedukado kaj memreflekto.',
      learning_target: 'Regula legado kaj intencaj lernblokoj.',
      career_name: 'Kariero & Profesia Vokiĝo',
      career_desc: 'Sencohava laboro, metia majstreco, kontribuo kaj sukceso.',
      career_target: 'Profunda kaj sendistra laboro pri gravaj projektoj.',
      finances_name: 'Financoj & Riĉo',
      finances_desc: 'Financa sekureco, respondeca mastrumado, ŝparado kaj libereco.',
      finances_target: 'Konscia buĝetado kaj forigo de senutilaj elspezoj.',
      environment_name: 'Fizika Medio & Spacoj',
      environment_desc: 'Ordo en la hejmo, pura laborspaco, estetiko kaj paco.',
      environment_target: 'Ordigitaj loĝspacoj kaj puraj laborzonoj.',
      relationships_name: 'Rilatoj & Intimeco',
      relationships_desc: 'Profunda ampartnereco, reciproka fido kaj komuna vizio.',
      relationships_target: 'Protektita tempo kune kaj sincera komunikado.',
      family_name: 'Familio & Gepatreco',
      family_desc: 'Familiaj ligoj, zorgado pri infanoj, honoro al prauloj kaj hejma varmo.',
      family_target: 'Genuina ĉeesto dum familiaj momentoj.',
      friendships_name: 'Amikecoj & Komunumo',
      friendships_desc: 'Amikaro, vera kamaradeco, aparteneco kaj reciproka subteno.',
      friendships_target: 'Intenca kontakto kaj komunaj spertoj.',
      recreation_name: 'Distrado, Ŝatokupoj & Ludo',
      recreation_desc: 'Spontana ĝojo, arta esprimo, kreivo kaj renovigo de fortoj.',
      recreation_target: 'Aktiva distrado for de ekranoj.',
      focus_name: 'Majstreco pri Atento & Fokuso',
      focus_desc: 'Cifereca higieno, klaraj limoj, profunda laboro kaj ĉeesto.',
      focus_target: 'Cifereca horlimo kaj forigo de senkonsciaj distraĵoj.',
      contribution_name: 'Kontribuo & Heredaĵo',
      contribution_desc: 'Malavareco, mentoreco, volontula helpo kaj pozitiva spuro en la mondo.',
      contribution_target: 'Solidarecaj agoj kaj helpo al bezonantoj.'
    },
    model: {
      sectionBadge: 'Kvindimensia Inteligenteco',
      title: 'La Multdimensia Prioritata Modelo',
      subtitle: 'Bona Loko analizas la veran rilaton inter viaj personaj valoroj, tempo kaj atento trans kvin komplementaj dimensioj.',
      dim1: 'Nuna Prioritato',
      dim1Desc: 'Kiom da prioritato havas ĉi tiu areo en via nuna vivofazo?',
      dim2: 'Kontento',
      dim2Desc: 'Kiel kontenta vi estas pri ĝia nuna stato?',
      dim3: 'Nuna Investo',
      dim3Desc: 'Kiom da reala tempo kaj energio vi dediĉas nun?',
      dim4: 'Dezirata Investo',
      dim4Desc: 'Kiom da atento vi konscie deziras investi?',
      dim5: 'Prioritata Manko',
      dim5Desc: 'Montras kie ĉiutagaj agoj malkongruas kun veraj deziroj.',
      pillar1Badge: 'Konscio & Realeco',
      pillar1Heading: 'Atenta Malkovro',
      pillar1Item1: 'Mapas finian tempon kaj fizikan energion kun trankvila klareco.',
      pillar1Item2: 'Identigas kien atento forfluas en senkonsciajn distraĵojn.',
      pillar1Item3: 'Montras prioritatajn mankojn sen kulpo aŭ juĝo.',
      pillar2Badge: 'Intenca Kongrueco',
      pillar2Heading: 'Celema Agado',
      pillar2Item1: 'Ligas ĉiun mikro-kutimon al vivareo kaj klara celo.',
      pillar2Item2: 'Anstataŭigas kulpon per kompata reflekto kaj realismaj alĝustigoj.',
      pillar2Item3: 'Taksas administradon de distraĵoj tiel grava kiel formadon de kutimoj.'
    },
    engine: {
      sectionBadge: 'Ripetada Motoro',
      title: 'La 7-Paŝa Transformada Motoro',
      subtitle: 'Kontinua kaj cikla persona kresko bazita sur memkonscio kaj kvieta daŭro.',
      step1_title: '1. Taksi',
      step1_desc: 'Mapu vian tutecan bazlinion tra la 12 vivareoj en kelkaj minutoj.',
      step2_title: '2. Prioritigi',
      step2_desc: 'Distingu viajn ĉefajn fokusajn areojn de tiuj por konservi.',
      step3_title: '3. Identigi Mankojn',
      step3_desc: 'Malkaŝu kie via intenco malkongruas kun ĉiutaga realo.',
      step4_title: '4. Difini Kutimojn',
      step4_desc: 'Kreu specifajn mikro-kondutojn ankritajn al eksplicitaj ellasilon.',
      step5_title: '5. Praktiki',
      step5_desc: 'Spuru regulecon kaj ritmon sen punaj sinsekvaj sistemoj.',
      step6_title: '6. Reflekti',
      step6_desc: 'Kaptu kvalitajn notojn pri froto, humoro kaj ĉiutaga atento.',
      step7_title: '7. Alĝustigi',
      step7_desc: 'Reakordigu prioritatojn laŭ la evoluo de vivaj cirkonstancoj.'
    },
    focus: {
      badge: 'Protektado de Atento',
      title: 'Atenta Majstreco & Distrada Defendo',
      subtitle: 'Investi tempon en niajn verajn prioritatojn floras kiam ni atente protektas atenton kontraŭ neintencitaj distraĵoj.',
      pillar1Title: 'Distrada Inventaro',
      pillar1Desc: 'Identigu personajn atentajn likojn (senfina rulumado, kompulsia kontrolo).',
      pillar2Title: 'Konscio pri Ellasiloj',
      pillar2Desc: 'Malkovru la kuntekstajn signalojn kaj emociojn antaŭ senkonsciaj kondutoj.',
      pillar3Title: 'Anstataŭaj Kutimoj',
      pillar3Desc: 'Anstataŭigu malhelpajn impulsojn per sanaj alternativoj (promeno, fizika libro).',
      bridgeLabel: 'Konduta Ponta Koncepto',
      bridgeTitle: 'De Vivareo al Ĉiutaga Ago',
      nodeArea: 'Patra Vivareo',
      nodePriority: 'Prioritata Stato',
      nodeHabit: 'Agada Kutimo',
      nodeAction: '10 minutoj da konscia spirado kiam oni sentas streson antaŭ uzo de telefono.',
      learnHabitAnatomy: 'Vidu la Kutiman Anatomion en Pri Ni →'
    },
    cta: {
      badge: 'Via Vojo Atendas',
      title: 'Komencu Vivi en "Bona Loko"',
      desc: 'Malkovru vian viv-ekvilibron, klarigu kio gravas kaj konstruu ĉiutagajn kutimojn kun plena aŭtonomio.',
      btnAbout: 'Legu Nian Filozofion',
      btnMission: 'Vidu Moralan Konstitucion',
      guarantee: '100% Senpaga & Malfermita • Neniuj Malhelaj Ŝablonoj • Neniu Politika Kaptiteco'
    }
  }
}

const { t } = useComponentI18n(landingTranslations)
const { localePath } = useLocalePath()

useHead({
  title: computed(() => t('meta.title'))
})

// Life areas data
const selectedCategory = ref('all')

const areaCategories = [
  { id: 'all', icon: '✨' },
  { id: 'vitality', icon: '🌱' },
  { id: 'prosperity', icon: '💼' },
  { id: 'connection', icon: '🤝' },
  { id: 'attention', icon: '🧠' }
]

const allLifeAreas = [
  { id: 'health', category: 'vitality', icon: '🏃‍♂️', categoryClass: 'badge-primary' },
  { id: 'mental', category: 'vitality', icon: '🧘', categoryClass: 'badge-primary' },
  { id: 'learning', category: 'vitality', icon: '📚', categoryClass: 'badge-primary' },
  { id: 'career', category: 'prosperity', icon: '💼', categoryClass: 'badge-blue' },
  { id: 'finances', category: 'prosperity', icon: '💰', categoryClass: 'badge-blue' },
  { id: 'environment', category: 'prosperity', icon: '🏡', categoryClass: 'badge-blue' },
  { id: 'relationships', category: 'connection', icon: '❤️', categoryClass: 'badge-esperanto' },
  { id: 'family', category: 'connection', icon: '👨‍👩‍👧', categoryClass: 'badge-esperanto' },
  { id: 'friendships', category: 'connection', icon: '👥', categoryClass: 'badge-esperanto' },
  { id: 'recreation', category: 'attention', icon: '🎨', categoryClass: 'badge-gold' },
  { id: 'focus', category: 'attention', icon: '🎯', categoryClass: 'badge-gold' },
  { id: 'contribution', category: 'attention', icon: '🤝', categoryClass: 'badge-gold' }
]

const filteredAreas = computed(() => {
  if (selectedCategory.value === 'all') return allLifeAreas
  return allLifeAreas.filter(a => a.category === selectedCategory.value)
})

// Dimension Guide Navigation Mapping for all 12 Life Areas
const areaGuideMap: Record<string, CanonicalRouteKey> = {
  health: 'dimension_health_fitness',
  mental: 'dimension_mental_emotional',
  learning: 'dimension_personal_growth',
  career: 'dimension_career_calling',
  finances: 'dimension_finances_wealth',
  environment: 'dimension_physical_environment',
  relationships: 'dimension_relationships_intimacy',
  family: 'dimension_family_parenting',
  friendships: 'dimension_friendships_community',
  recreation: 'dimension_recreation_play',
  focus: 'dimension_focus_mastery',
  contribution: 'dimension_contribution_legacy'
}

function getAreaGuideKey(areaId: string): CanonicalRouteKey | null {
  return areaGuideMap[areaId] || null
}

// 7 Transformation Engine Steps
const engineSteps = [
  { icon: '📝' },
  { icon: '🎯' },
  { icon: '🔍' },
  { icon: '🌱' },
  { icon: '⚡' },
  { icon: '📓' },
  { icon: '🔄' }
]
</script>

<style scoped>
/* Hero */
.hero-section {
  padding: 5rem 0 4rem 0;
  text-align: center;
  background: radial-gradient(circle at 50% 10%, rgba(254, 243, 235, 0.8) 0%, var(--bg-canvas) 70%);
}

.hero-container {
  max-width: 960px;
  margin: 0 auto;
}

.hero-badge {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.45rem 1.1rem;
  background-color: var(--secondary-light);
  border: 1px solid var(--secondary-border);
  border-radius: var(--radius-pill);
  font-size: 0.9rem;
  font-weight: 700;
  color: var(--secondary);
  margin-bottom: 1.75rem;
  box-shadow: var(--shadow-sm);
}

.esperanto-symbol {
  font-size: 1rem;
}

.hero-title {
  margin-bottom: 1.5rem;
  font-size: clamp(2.4rem, 5.2vw, 3.8rem);
  font-weight: 800;
  letter-spacing: -0.03em;
  color: var(--text-primary);
  line-height: 1.15;
}

.hero-subtitle {
  font-size: clamp(1.05rem, 2vw, 1.25rem);
  color: var(--text-secondary);
  max-width: 780px;
  margin: 0 auto 2.5rem auto;
  line-height: 1.7;
}

.hero-cta-group {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
  margin-bottom: 3.5rem;
}

/* Hero Widget */
.hero-widget-card {
  max-width: 740px;
  margin: 0 auto;
  text-align: left;
  border-color: var(--border-color);
  background: var(--bg-surface);
  border-radius: var(--radius-xl);
}

.widget-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 1.5rem;
  flex-wrap: wrap;
  gap: 0.5rem;
}

.widget-pill {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  font-size: 0.85rem;
  font-weight: 700;
  color: var(--primary);
  background-color: var(--primary-light);
  padding: 0.3rem 0.8rem;
  border-radius: var(--radius-pill);
}

.pulse-dot {
  width: 8px;
  height: 8px;
  background-color: var(--primary);
  border-radius: 50%;
  box-shadow: 0 0 0 3px var(--primary-glow);
}

.widget-hint {
  font-size: 0.8rem;
  color: var(--text-muted);
}

.widget-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1rem;
  background-color: var(--bg-subtle);
  padding: 1.25rem;
  border-radius: var(--radius-md);
  margin-bottom: 1.25rem;
}

.widget-item {
  display: flex;
  flex-direction: column;
  gap: 0.35rem;
}

.item-label {
  font-size: 0.76rem;
  font-weight: 600;
  color: var(--text-muted);
  text-transform: uppercase;
}

.item-value {
  font-size: 0.95rem;
  font-weight: 700;
}

.highlight-orange {
  color: var(--primary);
}

.bar-container {
  width: 100%;
  height: 7px;
  background-color: var(--border-color);
  border-radius: 4px;
  overflow: hidden;
  margin-top: 2px;
}

.bar-fill {
  height: 100%;
  border-radius: 4px;
}

.fill-orange { background-color: var(--primary); }
.fill-slate { background-color: var(--tertiary-blue); }

.bar-score {
  font-size: 0.78rem;
  color: var(--text-secondary);
  font-weight: 600;
}

.gap-tag {
  font-size: 0.82rem;
  font-weight: 700;
  color: #b45309;
  background-color: var(--tertiary-gold-light);
  padding: 0.2rem 0.5rem;
  border-radius: var(--radius-xs);
  display: inline-block;
}

.widget-footer p {
  font-size: 0.88rem;
  color: var(--text-secondary);
}

/* Etymology Section */
.etymology-grid {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1.25rem;
  margin-bottom: 2.5rem;
  flex-wrap: wrap;
}

.etymology-card {
  flex: 1;
  min-width: 250px;
  max-width: 320px;
  display: flex;
  flex-direction: column;
  gap: 0.85rem;
  background-color: var(--bg-surface);
}

.result-card {
  border-color: var(--secondary-border);
  background-color: var(--secondary-light);
}

.etymology-header {
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.word-badge {
  font-size: 1.05rem;
  font-weight: 800;
  padding: 0.3rem 0.85rem;
}

.lang-tag {
  font-size: 0.75rem;
  font-weight: 600;
  color: var(--text-muted);
}

.etymology-card h3 {
  font-size: 1.25rem;
  color: var(--text-primary);
}

.etymology-card p {
  font-size: 0.92rem;
}

.etymology-pill {
  margin-top: auto;
  font-size: 0.82rem;
  font-weight: 700;
  color: var(--primary);
  background-color: var(--primary-light);
  padding: 0.4rem 0.75rem;
  border-radius: var(--radius-sm);
}

.pill-secondary {
  color: var(--secondary);
  background-color: var(--secondary-light);
}

.pill-blue {
  color: var(--tertiary-blue);
  background-color: var(--tertiary-blue-light);
}

.etymology-connector {
  font-size: 2rem;
  font-weight: 800;
  color: var(--border-strong);
}

.mentality-banner {
  display: flex;
  align-items: center;
  gap: 1.5rem;
  padding: 1.75rem 2rem;
  background-color: var(--bg-surface);
  border-left: 5px solid var(--secondary);
}

.banner-icon {
  font-size: 2.5rem;
}

.banner-content h4 {
  font-size: 1.15rem;
  margin-bottom: 0.25rem;
  color: var(--text-primary);
}

.banner-content p {
  font-size: 0.95rem;
}

/* Life Areas Framework */
.filter-tabs {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.65rem;
  flex-wrap: wrap;
  margin-bottom: 2.5rem;
}

.tab-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.5rem;
  padding: 0.6rem 1.25rem;
  background-color: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-pill);
  font-size: 0.9rem;
  font-weight: 600;
  color: var(--text-secondary);
  cursor: pointer;
  transition: all var(--transition-fast);
}

.tab-btn:hover {
  border-color: var(--primary);
  color: var(--primary);
}

.tab-btn.active {
  background-color: var(--primary);
  border-color: var(--primary);
  color: var(--text-inverse);
  box-shadow: 0 4px 12px var(--primary-glow);
}

.areas-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.5rem;
}

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

/* Priority Model Pipeline */
.pipeline-container {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 2.25rem 1.75rem;
  margin-bottom: 3rem;
  gap: 0.75rem;
  overflow-x: auto;
}

.pipeline-step {
  flex: 1;
  min-width: 150px;
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  gap: 0.65rem;
}

.step-num {
  width: 38px;
  height: 38px;
  border-radius: 50%;
  background-color: var(--bg-subtle);
  border: 1px solid var(--border-color);
  display: flex;
  align-items: center;
  justify-content: center;
  font-weight: 800;
  color: var(--text-primary);
  font-size: 1.05rem;
}

.step-highlight .step-num {
  background-color: var(--primary);
  color: var(--text-inverse);
  border-color: var(--primary);
  box-shadow: 0 4px 12px var(--primary-glow);
}

.pipeline-step h4 {
  font-size: 1rem;
  margin-bottom: 0.25rem;
}

.pipeline-step p {
  font-size: 0.8rem;
  line-height: 1.4;
}

.pipeline-arrow {
  color: var(--border-strong);
  font-size: 1.25rem;
  font-weight: bold;
}

.card-status-badge {
  display: inline-block;
  padding: 0.3rem 0.75rem;
  border-radius: var(--radius-pill);
  font-size: 0.8rem;
  font-weight: 700;
  margin-bottom: 1rem;
}

.badge-warning {
  background-color: #fee2e2;
  color: #991b1b;
}

.comparison-card h3 {
  margin-bottom: 1rem;
  font-size: 1.25rem;
}

.comparison-list {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.comparison-list li {
  position: relative;
  padding-left: 1.5rem;
  font-size: 0.95rem;
  color: var(--text-secondary);
}

.card-standard .comparison-list li::before {
  content: '✕';
  position: absolute;
  left: 0;
  color: #ef4444;
  font-weight: bold;
}

.card-bonaloko .comparison-list li::before {
  content: '✓';
  position: absolute;
  left: 0;
  color: var(--secondary);
  font-weight: bold;
}

/* 7-Step Engine */
.engine-steps-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1.25rem;
}

.engine-card {
  position: relative;
  display: flex;
  flex-direction: column;
  gap: 0.65rem;
  padding: 1.75rem 1.5rem;
}

.engine-num-badge {
  position: absolute;
  top: 1rem;
  right: 1rem;
  font-family: var(--font-display);
  font-size: 1.5rem;
  font-weight: 800;
  color: var(--border-subtle);
}

.engine-icon {
  font-size: 2rem;
}

.engine-card h3 {
  font-size: 1.15rem;
  color: var(--text-primary);
}

.engine-card p {
  font-size: 0.88rem;
}

/* Focus Section */
.focus-layout {
  display: grid;
  grid-template-columns: 1.2fr 1fr;
  gap: 3rem;
  align-items: center;
}

.focus-text h2 {
  margin: 0.75rem 0 1rem 0;
}

.focus-pillars {
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
  margin-top: 2rem;
}

.focus-pillar-item {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
}

.pillar-icon {
  font-size: 1.6rem;
  background-color: var(--bg-surface);
  padding: 0.6rem;
  border-radius: var(--radius-md);
  border: 1px solid var(--border-color);
}

.focus-pillar-item h4 {
  font-size: 1.05rem;
  margin-bottom: 0.25rem;
}

.focus-pillar-item p {
  font-size: 0.88rem;
}

/* Focus Card Side */
.focus-card-side {
  background-color: var(--bg-surface);
  border-radius: var(--radius-xl);
  padding: 2rem;
}

.bridge-tag {
  font-size: 0.75rem;
  font-weight: 700;
  color: var(--secondary);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.habit-bridge-header h3 {
  font-size: 1.25rem;
  margin: 0.25rem 0 1.5rem 0;
}

.bridge-flow {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
  margin-bottom: 1.75rem;
}

.bridge-node {
  padding: 0.9rem 1rem;
  border-radius: var(--radius-md);
  border: 1px solid var(--border-color);
  display: flex;
  flex-direction: column;
  gap: 0.25rem;
}

.node-type {
  font-size: 0.72rem;
  font-weight: 700;
  text-transform: uppercase;
  color: var(--text-muted);
}

.node-val {
  font-size: 0.95rem;
  font-weight: 600;
}

.node-area { background-color: var(--primary-light); border-color: var(--primary-border); }
.node-area .node-val { color: var(--primary); }

.node-priority { background-color: var(--tertiary-gold-light); border-color: var(--tertiary-gold-border); }
.node-priority .node-val { color: #b45309; }

.node-habit { background-color: var(--secondary-light); border-color: var(--secondary-border); }
.node-habit .node-val { color: var(--secondary); }

.bridge-arrow {
  text-align: center;
  font-weight: bold;
  color: var(--text-muted);
}

/* Final CTA */
.section-cta {
  padding: 4rem 0 6rem 0;
}

.cta-inner {
  max-width: 820px;
  margin: 0 auto;
  padding: 4rem 2rem;
  background: radial-gradient(circle at 50% 20%, rgba(254, 243, 235, 0.9) 0%, var(--bg-surface) 80%);
  border-radius: var(--radius-xl);
  border: 1px solid var(--border-color);
}

.cta-inner h2 {
  font-size: clamp(2rem, 3.8vw, 2.75rem);
  margin: 1.25rem 0 1rem 0;
}

.cta-desc {
  font-size: 1.1rem;
  max-width: 620px;
  margin: 0 auto 2.25rem auto;
}

.cta-buttons {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
  margin-bottom: 2rem;
}

.cta-guarantee {
  font-size: 0.85rem;
  color: var(--secondary);
  font-weight: 600;
}

/* Responsive adjustments */
@media (max-width: 992px) {
  .areas-grid { grid-template-columns: repeat(2, 1fr); }
  .engine-steps-grid { grid-template-columns: repeat(2, 1fr); }
  .focus-layout { grid-template-columns: 1fr; }
  .widget-grid { grid-template-columns: repeat(2, 1fr); }
}

@media (max-width: 640px) {
  .areas-grid { grid-template-columns: 1fr; }
  .engine-steps-grid { grid-template-columns: 1fr; }
  .widget-grid { grid-template-columns: 1fr; }
  .pipeline-container { flex-direction: column; align-items: stretch; }
  .pipeline-arrow { transform: rotate(90deg); margin: 0.5rem auto; }
}
</style>
