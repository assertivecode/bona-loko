<template>
  <div class="mission-page">
    <!-- Header -->
    <section class="mission-hero section-subtle">
      <div class="container container-narrow text-center">
        <div class="badge badge-blue">
          🛡️ {{ t('mission.badge') }}
        </div>
        <h1>{{ t('mission.title') }}</h1>
        <p class="mission-intro">
          {{ t('mission.intro') }}
        </p>
      </div>
    </section>

    <!-- Moral Constitution & Core Values Intro -->
    <section class="section">
      <div class="container container-narrow">
        <div class="constitution-lead">
          <div class="quote-box card">
            <span class="shield-badge">🛡️</span>
            <blockquote>
              “{{ t('constitution.quote') }}”
            </blockquote>
            <a
              href="https://github.com/assertivecode/bona-loko/blob/main/FOUNDATION.md"
              target="_blank"
              rel="noopener noreferrer"
              class="source-tag"
              title="View FOUNDATION.md on GitHub"
            >
              FOUNDATION.md — {{ t('constitution.sourceTag') }} ↗
            </a>
          </div>

          <p class="lead-text">
            {{ t('constitution.leadText') }}
          </p>
        </div>

        <!-- 4 Inviolable Guardrails -->
        <div id="guardrails" class="guardrails-wrapper">
          <div class="section-header text-left">
            <div class="badge badge-gold">
              🚫 {{ t('guardrails.badge') }}
            </div>
            <h2>{{ t('guardrails.title') }}</h2>
            <p>{{ t('guardrails.subtitle') }}</p>
          </div>

          <div class="guardrails-list">
            <!-- Rule 1 -->
            <div class="guardrail-card card">
              <div class="rule-indicator">
                <span class="rule-no">01</span>
                <span class="rule-lock">🔒</span>
              </div>
              <div class="rule-details">
                <h3>{{ t('guardrails.r1_title') }}</h3>
                <blockquote class="rule-decree">
                  {{ t('guardrails.r1_decree') }}
                </blockquote>
                <p>{{ t('guardrails.r1_desc') }}</p>
              </div>
            </div>

            <!-- Rule 2 -->
            <div class="guardrail-card card">
              <div class="rule-indicator">
                <span class="rule-no">02</span>
                <span class="rule-lock">🔒</span>
              </div>
              <div class="rule-details">
                <h3>{{ t('guardrails.r2_title') }}</h3>
                <blockquote class="rule-decree">
                  {{ t('guardrails.r2_decree') }}
                </blockquote>
                <p>{{ t('guardrails.r2_desc') }}</p>
              </div>
            </div>

            <!-- Rule 3 -->
            <div class="guardrail-card card">
              <div class="rule-indicator">
                <span class="rule-no">03</span>
                <span class="rule-lock">🔒</span>
              </div>
              <div class="rule-details">
                <h3>{{ t('guardrails.r3_title') }}</h3>
                <blockquote class="rule-decree">
                  {{ t('guardrails.r3_decree') }}
                </blockquote>
                <p>{{ t('guardrails.r3_desc') }}</p>
              </div>
            </div>

            <!-- Rule 4 -->
            <div class="guardrail-card card">
              <div class="rule-indicator">
                <span class="rule-no">04</span>
                <span class="rule-lock">🔒</span>
              </div>
              <div class="rule-details">
                <h3>{{ t('guardrails.r4_title') }}</h3>
                <blockquote class="rule-decree">
                  {{ t('guardrails.r4_decree') }}
                </blockquote>
                <p>{{ t('guardrails.r4_desc') }}</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Stewardship Pledge -->
        <div id="pledge" class="pledge-section card shadow-md">
          <div class="pledge-header">
            <span class="pledge-icon">📜</span>
            <div>
              <h3>{{ t('pledge.title') }}</h3>
              <p>{{ t('pledge.subtitle') }}</p>
            </div>
          </div>

          <div class="pledge-items">
            <div class="pledge-item">
              <span class="check-icon">✓</span>
              <div>
                <strong>{{ t('pledge.item1Title') }}</strong>
                <p>{{ t('pledge.item1Desc') }}</p>
              </div>
            </div>
            <div class="pledge-item">
              <span class="check-icon">✓</span>
              <div>
                <strong>{{ t('pledge.item2Title') }}</strong>
                <p>{{ t('pledge.item2Desc') }}</p>
              </div>
            </div>
            <div class="pledge-item">
              <span class="check-icon">✓</span>
              <div>
                <strong>{{ t('pledge.item3Title') }}</strong>
                <p>{{ t('pledge.item3Desc') }}</p>
              </div>
            </div>
          </div>
        </div>

        <!-- Strategic Roadmap Evolution -->
        <div id="roadmap" class="roadmap-section">
          <div class="section-header text-left">
            <div class="badge badge-primary">
              🚀 {{ t('roadmap.badge') }}
            </div>
            <h2>{{ t('roadmap.title') }}</h2>
            <p>{{ t('roadmap.subtitle') }}</p>
          </div>

          <div class="roadmap-timeline">
            <div
              v-for="(phase, idx) in roadmapPhases"
              :key="idx"
              class="roadmap-node card"
            >
              <div class="phase-badge">{{ t(`roadmap.phase${idx + 1}_badge`) }}</div>
              <h4>{{ t(`roadmap.phase${idx + 1}_title`) }}</h4>
              <p>{{ t(`roadmap.phase${idx + 1}_desc`) }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useHead } from '#app'
import { useComponentI18n } from '~/composables/useLocale'

// Component-Scoped Translation Dictionary for Mission Page (EN-US, PT-BR, EO)
const missionTranslations = {
  'en-US': {
    meta: {
      title: 'Mission & Moral Constitution — Bona Loko'
    },
    mission: {
      badge: 'Moral Bedrock & Core Values',
      title: 'Platform Mission & Moral Constitution',
      intro: 'Bona Loko ("Good Place" in Esperanto) is governed by an enduring ethical bedrock and inviolable guardrails to ensure it never loses its soul or deviates from its core purpose.'
    },
    constitution: {
      quote: 'Personal transformation requires a mentality focused in uncorruptibility. To help people discover their own life balance, the platform must remain steadfast in its values and uncompromised in its independence.',
      leadText: 'Most commercial apps eventually sell user attention to advertisers, accept corporate sponsors with hidden agendas, or become stepping stones for partisan ambitions. Bona Loko is structurally shielded by design.',
      sourceTag: 'Core Moral Bedrock'
    },
    guardrails: {
      badge: 'Non-Negotiable Guardrails',
      title: 'The 4 Inviolable Rules',
      subtitle: 'Permanent, immutable principles that protect user sovereignty and platform independence:',
      r1_title: 'Rule 1: Absolute Prohibition of Political Leadership',
      r1_decree: 'It is strictly prohibited for leaders, board members, or executive stewards of the platform to be active politicians, candidates for public office, or maintain associations with political figures.',
      r1_desc: 'The governance of Bona Loko must never be used as a political stepping stone, promotional megaphone, or apparatus for personal partisan ambition.',
      r2_title: 'Rule 2: Ban on Political Association & Public / Government Funding',
      r2_decree: 'The platform is strictly forbidden from engaging in any political affiliation or endorsement, and shall under no circumstances accept donations, subsidies, or grants derived from public money or state coffers.',
      r2_desc: 'True independence requires financial and ideological autonomy. The platform will never owe its existence to government administrations or tax-funded political allocations.',
      r3_title: 'Rule 3: Active Defense of Platform Mission & Purity of Purpose',
      r3_decree: 'Platform leadership must actively block political interference, external ideological capture, and partisan agendas from infiltrating the platform’s primary goal.',
      r3_desc: 'The platform exists for one essential purpose: to help human beings understand what matters, achieve personal balance, and cultivate sustainable self-development.',
      r4_title: 'Rule 4: Incorruptibility & Unconditional Anonymous Donations',
      r4_decree: 'The platform must never be corrupted by money, corporate leverage, commercial agendas or any other means. It is categorically prohibited to accept donations in exchange for advertising, propaganda, or algorithmic favoritism.',
      r4_desc: 'Zero quid-pro-quo. All contributions are treated as unconditional gifts conferring zero influence, visibility, or commercial benefit.'
    },
    pledge: {
      title: 'The Stewardship Pledge',
      subtitle: 'Committed by every contributor, developer, and automated agent working on Bona Loko:',
      item1Title: '1. Never Compromise User Trust',
      item1Desc: 'We will never sacrifice genuine user wellbeing or privacy for vanity engagement metrics or addictive loops.',
      item2Title: '2. Uphold User Sovereignty',
      item2Desc: 'Absolute respect over user attention, personal data, and unique spiritual and moral convictions.',
      item3Title: '3. Preserve the Core Values',
      item3Desc: 'Actively protect the space from partisan warfare, cynicism, and commercial exploitation.'
    },
    roadmap: {
      badge: 'Development Roadmap',
      title: 'Phased Platform Evolution',
      subtitle: 'How Bona Loko moves from foundation to full life reflection:',
      phase1_badge: 'Phase 1 — Foundation',
      phase1_title: 'Life Assessment Foundation',
      phase1_desc: 'Wheel of Life balance visualizer, multi-dimensional assessment questionnaire, and baseline profile.',
      phase2_badge: 'Phase 2 — Priorities',
      phase2_title: 'Priority Management & Gaps',
      phase2_desc: 'Gap analysis engine, focus area categorization, and conscious deprioritization tools.',
      phase3_badge: 'Phase 3 — Habits',
      phase3_title: 'Habits & Behavioral Bridge',
      phase3_desc: 'Habit creation workflow tied to life areas, consistency tracking, and momentum indicators.',
      phase4_badge: 'Phase 4 — Focus',
      phase4_title: 'Focus & Distraction Management',
      phase4_desc: 'Distraction logging, trigger analysis, replacement habits, and digital curfews.',
      phase5_badge: 'Phase 5 — Continuous',
      phase5_title: 'Reflection & Continuous Cycle',
      phase5_desc: 'Periodic reassessments, historical comparison views, and longitudinal habit efficacy analysis.'
    }
  },
  'pt-BR': {
    meta: {
      title: 'Missão & Constituição Moral — Bona Loko'
    },
    mission: {
      badge: 'Base Moral & Valores Fundamentais',
      title: 'Missão da Plataforma & Constituição Moral',
      intro: 'Bona Loko ("Bom Lugar" em Esperanto) é regido por uma base ética permanente e limites invioláveis para garantir que nunca perca sua alma ou desvie do seu propósito.'
    },
    constitution: {
      quote: 'A transformação pessoal requer uma mentalidade focada na incorruptibilidade. Para ajudar as pessoas a descobrirem seu próprio equilíbrio de vida, a plataforma deve permanecer inabalável em seus valores e independente.',
      leadText: 'A maioria dos aplicativos comerciais eventualmente vende a atenção do usuário para anunciantes ou se torna trampolim para interesses partidários. A Bona Loko é estruturalmente blindado.',
      sourceTag: 'Base Moral Fundamental'
    },
    guardrails: {
      badge: 'Limites Invioláveis',
      title: 'As 4 Regras Invioláveis',
      subtitle: 'Princípios permanentes e imutáveis que garantem a soberania do usuário:',
      r1_title: 'Regra 1: Proibição Absoluta de Liderança Política',
      r1_decree: 'É estritamente proibido que líderes, membros do conselho ou administradores da plataforma sejam políticos ativos, candidatos a cargos públicos ou mantenham associações com figuras políticas.',
      r1_desc: 'A governança da Bona Loko nunca poderá ser usada como palanque eleitoral, megafone de promoção ou aparelho partidário.',
      r2_title: 'Regra 2: Proibição de Associação Política & Financiamento Público',
      r2_decree: 'A plataforma está estritamente proibida de qualquer afiliação política e sob nenhuma circunstância aceitará doações, subsídios ou verbas públicas de governos.',
      r2_desc: 'A verdadeira independência exige autonomia financeira e ideológica. A plataforma nunca dependerá de administrações estatais.',
      r3_title: 'Regra 3: Defesa Ativa da Missão da Plataforma & Pureza de Propósito',
      r3_decree: 'A liderança da plataforma deve bloquear ativamente interferências políticas e pautas partidárias que tentem desviar o objetivo principal.',
      r3_desc: 'A plataforma existe para um propósito essencial: ajudar seres humanos a entenderem o que importa e construírem autodesenvolvimento sustentável.',
      r4_title: 'Regra 4: Incorruptibilidade & Doações Anônimas Incondicionais',
      r4_decree: 'A plataforma nunca será corrompida por dinheiro, influência corporativa, agendas comerciais ou qualquer outro meio. É categoricamente proibido aceitar doações em troca de publicidade, propaganda ou favorecimento algorítmico.',
      r4_desc: 'Zero toma-lá-dá-cá. Doações conferem zero influência, visibilidade ou benefícios comerciais.'
    },
    pledge: {
      title: 'Compromisso de Mordomia',
      subtitle: 'Assumido por cada colaborador, desenvolvedor e agente de IA que atua na Bona Loko:',
      item1Title: '1. Nunca Comprometer a Confiança do Usuário',
      item1Desc: 'Jamais sacrificaremos a privacidade ou bem-estar do usuário por métricas vazias de engajamento.',
      item2Title: '2. Sustentar a Soberania do Usuário',
      item2Desc: 'Respeito absoluto sobre a atenção, dados pessoais e crenças individuais de cada pessoa.',
      item3Title: '3. Preservar os Valores Fundamentais',
      item3Desc: 'Manter o espaço protegido contra guerras partidárias, cinismo e mercantilização da vida.',
    },
    roadmap: {
      badge: 'Roteiro de Desenvolvimento',
      title: 'Evolução Estratégica da Plataforma',
      subtitle: 'Como a Bona Loko se desenvolve da base inicial à reflexão contínua:',
      phase1_badge: 'Fase 1 — Fundação',
      phase1_title: 'Avaliação da Vida (Fundação)',
      phase1_desc: 'Visualizador da Roda da Vida, questionário multidimensional e perfil basal inicial.',
      phase2_badge: 'Fase 2 — Prioridades',
      phase2_title: 'Gestão de Prioridades & Lacunas',
      phase2_desc: 'Motor de análise de lacunas, categorização de focos e despriorização intencional.',
      phase3_badge: 'Fase 3 — Hábitos',
      phase3_title: 'Hábitos & Ponte Comportamental',
      phase3_desc: 'Criação de hábitos vinculados a áreas da vida, acompanhamento de consistência e ritmo.',
      phase4_badge: 'Fase 4 — Foco',
      phase4_title: 'Domínio do Foco & Gestão de Distrações',
      phase4_desc: 'Registro de distrações, análise de gatilhos, hábitos de substituição e limites digitais.',
      phase5_badge: 'Fase 5 — Contínua',
      phase5_title: 'Reflexão & Melhoria Contínua',
      phase5_desc: 'Reavaliações periódicas, comparativos históricos e eficácia longitudinal de hábitos.'
    }
  },
  eo: {
    meta: {
      title: 'Misio & Morala Konstitucio — Bona Loko'
    },
    mission: {
      badge: 'Morala Bazo & Kernaj Valoroj',
      title: 'Platforma Misio & Morala Konstitucio',
      intro: 'Bona Loko ("Good Place" en Esperanto) estas regata de fortika etika bazo kaj netuŝeblaj sekurbariloj por certigi ke ĝi neniam perdu sian animon.'
    },
    constitution: {
      quote: 'Persona transformado postulas pensmanieron fokusitan al nekoruptebleco. Por helpi homojn malkovri sian viv-ekvilibron, la platformo devas resti fidela al siaj valoroj kaj sendependa.',
      leadText: 'Plej multaj komercaj aplikaĵoj vendas atenton de uzantoj aŭ servas al politikaj celoj. Bona Loko estas strukture protektita.',
      sourceTag: 'Kernaj Moralaj Fundamentoj'
    },
    guardrails: {
      badge: 'Netuŝeblaj Sekurbariloj',
      title: 'La 4 Netuŝeblaj Reguloj',
      subtitle: 'Konstantaj kaj neŝanĝeblaj principoj por protekti uzantan suverenecon:',
      r1_title: 'Regulo 1: Absoluta Malpermeso de Politika Gvidado',
      r1_decree: 'Estas strikte malpermesite al gvidantoj aŭ administrantoj esti aktivaj politikistoj, kandidatoj por publikaj oficoj aŭ teni rilatojn kun politikistoj.',
      r1_desc: 'La regado de Bona Loko neniam estu uzata kiel politika megafono aŭ partia aparato.',
      r2_title: 'Regulo 2: Malpermeso de Politika Asocio & Ŝtata Financado',
      r2_decree: 'La platformo estas strikte malpermesita de ajna politika alligiteco kaj sub neniu cirkonstanco akceptos publikan monon de registaroj.',
      r2_desc: 'Vera sendependeco postulas financan kaj ideologian aŭtonomion.',
      r3_title: 'Regulo 3: Aktiva Defendo de Platforma Misio & Pureco',
      r3_decree: 'Gvidantaro devas aktive bloki politikan enmiksiĝon kaj eksterajn ideologiojn de infiltrado.',
      r3_desc: 'La platformo ekzistas por unu esenca celo: helpi homojn kompreni kio gravas kaj atingi personan ekvilibron.',
      r4_title: 'Regulo 4: Nekoruptebleco & Nekondiĉaj Anonimaj Donacoj',
      r4_decree: 'La platformo neniam estu koruptita per mono, kompania influo, komercaj tagordoj aŭ ajnaj aliaj rimedoj. Estas kategorie malpermesite akcepti donacojn kontraŭ reklamado, propagando aŭ algoritma favoro.',
      r4_desc: 'Nul kontraŭstaraj favoroj. Donacoj donas nul influon aŭ komercan videblecon.'
    },
    pledge: {
      title: 'Diligenta Promeso',
      subtitle: 'Subskribita de ĉiu kontribuanto, programisto kaj agento:',
      item1Title: '1. Neniam Kompromiti Uzantan Fidon',
      item1Desc: 'Ni neniam oferos privatan bonfarton por malplenaj ciferecaj mezuroj.',
      item2Title: '2. Subteni Uzantan Suverenecon',
      item2Desc: 'Absoluta respekto super uzanta atento, personaj datumoj kaj moralaj konviktoj.',
      item3Title: '3. Konservi la Kernajn Valorojn',
      item3Desc: 'Konservi la spacon libera de partia batalado, cinikismo kaj komerca ekspluato.'
    },
    roadmap: {
      badge: 'Vojmapo',
      title: 'Strategia Platforma Evoluo',
      subtitle: 'Kiel Bona Loko evoluas de la bazo al kontinua reflekto:',
      phase1_badge: 'Fazo 1 — Bazo',
      phase1_title: 'Vivtaksado (Bazo)',
      phase1_desc: 'Rado de Vivo, multdimensia taksada demandaro kaj komenca vivprofilo.',
      phase2_badge: 'Fazo 2 — Prioritatoj',
      phase2_title: 'Prioritata Administrado & Mankoj',
      phase2_desc: 'Motoro por analizo de prioritataj mankoj kaj intenca malprioritatigo.',
      phase3_badge: 'Fazo 3 — Kutimoj',
      phase3_title: 'Kutimoj & Konduta Ponto',
      phase3_desc: 'Kutimkreado ligita al vivareoj kaj reguleca spurado.',
      phase4_badge: 'Fazo 4 — Fokuso',
      phase4_title: 'Majstreco pri Atento & Distraĵoj',
      phase4_desc: 'Spurado de distraĵoj, analizo de ellasiloj kaj anstataŭaj kutimoj.',
      phase5_badge: 'Fazo 5 — Kontinua',
      phase5_title: 'Reflekto & Kontinua Plibonigo',
      phase5_desc: 'Periodaj retaksadoj, historiaj komparoj kaj longtempa efikeca analizo.'
    }
  }
}

const { t } = useComponentI18n(missionTranslations)

useHead({
  title: computed(() => t('meta.title'))
})

const roadmapPhases = [0, 1, 2, 3, 4]
</script>

<style scoped>
.mission-hero {
  padding: 4.5rem 0 3.5rem 0;
}

.mission-hero h1 {
  margin: 1rem 0 1.25rem 0;
  font-size: clamp(2.2rem, 4vw, 3.2rem);
}

.mission-intro {
  font-size: 1.15rem;
  line-height: 1.7;
  color: var(--text-secondary);
}

.constitution-lead {
  margin-bottom: 3.5rem;
}

.quote-box {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
  padding: 2.25rem;
  background-color: var(--bg-surface);
  border-left: 5px solid var(--tertiary-blue);
  margin-bottom: 2rem;
}

.shield-badge {
  font-size: 2rem;
}

.quote-box blockquote {
  font-size: 1.15rem;
  font-style: italic;
  line-height: 1.7;
  color: var(--text-primary);
}

.source-tag {
  font-size: 0.82rem;
  font-weight: 700;
  color: var(--tertiary-blue);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

a.source-tag {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  text-decoration: underline;
  text-underline-offset: 3px;
  cursor: pointer;
  transition: color var(--transition-fast);
}

a.source-tag:hover {
  color: var(--primary);
}

.lead-text {
  font-size: 1.1rem;
  line-height: 1.8;
  color: var(--text-secondary);
}

/* Guardrails List */
.guardrails-wrapper {
  margin-bottom: 4rem;
}

.guardrails-list {
  display: flex;
  flex-direction: column;
  gap: 1.5rem;
  margin-top: 2rem;
}

.guardrail-card {
  display: flex;
  align-items: flex-start;
  gap: 1.5rem;
  padding: 2rem;
  background-color: var(--bg-surface);
  border-radius: var(--radius-lg);
}

.rule-indicator {
  display: flex;
  flex-direction: column;
  align-items: center;
  gap: 0.25rem;
}

.rule-no {
  font-family: var(--font-display);
  font-size: 1.75rem;
  font-weight: 800;
  color: var(--primary);
}

.rule-lock {
  font-size: 1.25rem;
}

.rule-details {
  display: flex;
  flex-direction: column;
  gap: 0.75rem;
}

.rule-details h3 {
  font-size: 1.25rem;
  color: var(--text-primary);
}

.rule-decree {
  background-color: var(--bg-subtle);
  border-left: 3px solid var(--primary);
  padding: 0.85rem 1rem;
  border-radius: var(--radius-xs);
  font-size: 0.92rem;
  font-weight: 600;
  color: var(--text-primary);
  line-height: 1.6;
}

.rule-details p {
  font-size: 0.92rem;
}

/* Stewardship Pledge */
.pledge-section {
  padding: 2.5rem;
  background: radial-gradient(circle at 10% 20%, rgba(254, 243, 235, 0.7) 0%, var(--bg-surface) 90%);
  border-radius: var(--radius-xl);
  margin-bottom: 4rem;
}

.pledge-header {
  display: flex;
  align-items: center;
  gap: 1rem;
  margin-bottom: 2rem;
}

.pledge-icon {
  font-size: 2.5rem;
}

.pledge-header h3 {
  font-size: 1.35rem;
  margin-bottom: 0.25rem;
}

.pledge-header p {
  font-size: 0.95rem;
}

.pledge-items {
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
}

.pledge-item {
  display: flex;
  align-items: flex-start;
  gap: 1rem;
}

.check-icon {
  display: flex;
  align-items: center;
  justify-content: center;
  width: 26px;
  height: 26px;
  border-radius: 50%;
  background-color: var(--secondary);
  color: white;
  font-weight: bold;
  font-size: 0.85rem;
  flex-shrink: 0;
  margin-top: 2px;
}

.pledge-item strong {
  display: block;
  font-size: 1.05rem;
  color: var(--text-primary);
  margin-bottom: 0.2rem;
}

.pledge-item p {
  font-size: 0.92rem;
}

/* Roadmap */
.roadmap-timeline {
  display: flex;
  flex-direction: column;
  gap: 1.25rem;
  margin-top: 2rem;
}

.roadmap-node {
  padding: 1.5rem 1.75rem;
  background-color: var(--bg-surface);
  border-left: 4px solid var(--secondary);
}

.phase-badge {
  display: inline-block;
  font-size: 0.75rem;
  font-weight: 700;
  color: var(--secondary);
  background-color: var(--secondary-light);
  padding: 0.2rem 0.6rem;
  border-radius: var(--radius-pill);
  margin-bottom: 0.5rem;
}

.roadmap-node h4 {
  font-size: 1.15rem;
  margin-bottom: 0.35rem;
}

.roadmap-node p {
  font-size: 0.92rem;
}

@media (max-width: 640px) {
  .guardrail-card {
    flex-direction: column;
  }
}
</style>
