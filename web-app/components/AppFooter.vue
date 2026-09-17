<template>
  <footer class="app-footer">
    <div class="footer-top container">
      <!-- Col 1: Brand & Esperanto Meaning -->
      <div class="footer-col brand-col">
        <NuxtLink :to="localePath('home')" class="footer-logo-link">
          <img
            src="/images/horizontal-logo.png"
            alt="Bona Loko"
            class="footer-logo"
            width="180"
            height="34"
          />
        </NuxtLink>

        <p class="footer-tagline">
          {{ t('footer.tagline') }}
        </p>

        <!-- Prominent Esperanto Note -->
        <div class="footer-esperanto-box">
          <span class="star-icon">★</span>
          <div>
            <strong>{{ t('footer.esperantoTitle') }}</strong>
            <p>{{ t('footer.esperantoDesc') }}</p>
          </div>
        </div>
      </div>

      <!-- Col 2: Platform Links -->
      <div class="footer-col">
        <h4 class="footer-col-title">{{ t('footer.platformTitle') }}</h4>
        <ul class="footer-links">
          <li><NuxtLink :to="localePath('home')">{{ t('footer.linkHome') }}</NuxtLink></li>
          <li><NuxtLink :to="localePath('about')">{{ t('footer.linkAbout') }}</NuxtLink></li>
          <li><NuxtLink :to="localePath('mission')">{{ t('footer.linkMission') }}</NuxtLink></li>
          <li><a :href="localePath('home') + '#priority-model'">{{ t('footer.linkPriorityModel') }}</a></li>
          <li><a :href="localePath('home') + '#transformation-engine'">{{ t('footer.linkEngine') }}</a></li>
        </ul>
      </div>

      <!-- Col 3: Core Values & Foundation -->
      <div class="footer-col">
        <h4 class="footer-col-title">{{ t('footer.foundationTitle') }}</h4>
        <ul class="footer-links">
          <li><NuxtLink :to="localePath('mission') + '#guardrails'">{{ t('footer.linkGuardrails') }}</NuxtLink></li>
          <li><NuxtLink :to="localePath('about') + '#values'">{{ t('footer.linkValues') }}</NuxtLink></li>
          <li><NuxtLink :to="localePath('mission') + '#pledge'">{{ t('footer.linkPledge') }}</NuxtLink></li>
          <li>
            <a
              href="https://github.com/assertivecode/bona-loko/blob/main/FOUNDATION.md"
              target="_blank"
              rel="noopener noreferrer"
              class="footer-external-link"
            >
              {{ t('footer.linkFoundationDoc') }} ↗
            </a>
          </li>
        </ul>
      </div>

      <!-- Col 4: Community & Languages -->
      <div class="footer-col">
        <h4 class="footer-col-title">{{ t('footer.languageTitle') }}</h4>
        <p class="footer-subtext">{{ t('footer.languageDesc') }}</p>
        <div class="footer-lang-pills">
          <button
            v-for="loc in locales"
            :key="loc.code"
            type="button"
            class="footer-lang-btn"
            :class="{ active: currentLocale === loc.code }"
            @click="switchLocale(loc.code)"
          >
            <span>{{ loc.flag }}</span>
            <span>{{ loc.name }}</span>
          </button>
        </div>
      </div>
    </div>

    <!-- Moral Independence Guardrail Banner -->
    <div class="guardrail-banner">
      <div class="container guardrail-inner">
        <span class="guardrail-icon">🛡️</span>
        <span class="guardrail-text">{{ t('footer.guardrailNote') }}</span>
      </div>
    </div>

    <!-- Footer Bottom -->
    <div class="footer-bottom">
      <div class="container footer-bottom-inner">
        <p class="copyright">
          © {{ new Date().getFullYear() }} <strong>Bona Loko</strong> —
          <a
            href="https://github.com/assertivecode/bona-loko"
            target="_blank"
            rel="noopener noreferrer"
            class="footer-initiative-link"
          >{{ t('footer.initiative') }}</a>. {{ t('footer.rightsNote') }}
        </p>
        <p class="stewardship-note">
          {{ t('footer.stewardship') }}
        </p>
      </div>
    </div>
  </footer>
</template>

<script setup lang="ts">
import { useRoute, useRouter } from '#app'
import { useComponentI18n, useLocalePath, type Locale } from '~/composables/useLocale'

// Component-Scoped Translation Dictionary (EN-US, PT-BR, EO)
const footerTranslations = {
  'en-US': {
    footer: {
      tagline: 'Understand what matters. Focus your attention. Build better habits. Shape the life you want to live.',
      esperantoTitle: 'Esperanto Origin: "Good Place"',
      esperantoDesc: '"Bona Loko" translates directly to "Good Place" in Esperanto — symbolizing a neutral, peaceful, and universally accessible environment built on uncorruptible core values and human growth.',
      platformTitle: 'Platform',
      linkHome: 'Home / Foundation',
      linkAbout: 'About & Philosophy',
      linkMission: 'Mission & Moral Constitution',
      linkPriorityModel: 'Priority Model',
      linkEngine: '7-Step Transformation Engine',
      foundationTitle: 'Core Values & Foundation',
      linkGuardrails: 'Inviolable Guardrails',
      linkValues: '6 Core Values',
      linkPledge: 'Stewardship Pledge',
      linkFoundationDoc: 'Moral Constitution (FOUNDATION.md)',
      languageTitle: 'Languages',
      languageDesc: 'Bona Loko natively supports three international languages:',
      guardrailNote: 'Mentality Focused in Uncorruptibility: Strictly prohibited from political associations, corporate advertising, or commercial manipulation. 100% user sovereign.',
      initiative: 'Assertive Code Open Source Initiative',
      rightsNote: 'Released under open stewardship.',
      stewardship: 'Faith • Gratitude • Integrity • Respect • Empathy • Freedom'
    }
  },
  'pt-BR': {
    footer: {
      tagline: 'Entenda o que importa. Foque sua atenção. Construa hábitos melhores. Molde a vida que você deseja viver.',
      esperantoTitle: 'Origem no Esperanto: "Bom Lugar"',
      esperantoDesc: '"Bona Loko" traduz-se diretamente como "Bom Lugar" em Esperanto — simbolizando um ambiente neutro, pacífico e universal fundamentado em valores essenciais e crescimento humano.',
      platformTitle: 'Plataforma',
      linkHome: 'Início / Fundação',
      linkAbout: 'Sobre & Filosofia',
      linkMission: 'Missão & Constituição Moral',
      linkPriorityModel: 'Modelo de Prioridades',
      linkEngine: 'Motor de Transformação em 7 Passos',
      foundationTitle: 'Valores Fundamentais & Fundação',
      linkGuardrails: 'Guard rails Invioláveis',
      linkValues: '6 Valores Fundamentais',
      linkPledge: 'Compromisso de Mordomia',
      linkFoundationDoc: 'Constituição Moral (FOUNDATION.md)',
      languageTitle: 'Idiomas',
      languageDesc: 'Bona Loko suporta nativamente três idiomas internacionais:',
      guardrailNote: 'Mentalidade Focada na Incorruptibilidade: Estritamente proibido de associações políticas, anúncios corporativos ou manipulação comercial. 100% soberano do usuário.',
      initiative: 'Iniciativa Open Source Assertive Code',
      rightsNote: 'Sob custódia aberta.',
      stewardship: 'Fé • Gratidão • Integridade • Respeito • Empatia • Liberdade'
    }
  },
  eo: {
    footer: {
      tagline: 'Komprenu kio gravas. Foku vian atenton. Konstruu pli bonajn kutimojn. Formu la vivon kiun vi deziras.',
      esperantoTitle: 'Esperanta Deveno: "Good Place"',
      esperantoDesc: '"Bona Loko" signifas rekte "Bona Loko" en Esperanto — simbolante neŭtralan, pacan kaj universalan medion bazitan sur kernaj valoroj por homa disvolviĝo.',
      platformTitle: 'Platformo',
      linkHome: 'Ĉefpaĝo / Fondo',
      linkAbout: 'Pri Ni & Filozofio',
      linkMission: 'Misio & Morala Konstitucio',
      linkPriorityModel: 'Prioritata Modelo',
      linkEngine: '7-Paŝa Transformada Motoro',
      foundationTitle: 'Kernaj Valoroj & Fondo',
      linkGuardrails: 'Netuŝeblaj Sekurbariloj',
      linkValues: '6 Kernaj Valoroj',
      linkPledge: 'Diligenta Promeso',
      linkFoundationDoc: 'Morala Konstitucio (FOUNDATION.md)',
      languageTitle: 'Lingvoj',
      languageDesc: 'Bona Loko denaske subtenas tri internaciajn lingvojn:',
      guardrailNote: 'Pensmaniero Fokusita al Nekoruptebleco: Strikte malpermesita de politikaj rilatoj, kompaniaj reklamoj aŭ komerca manipulado. 100% uzanta suvereneco.',
      initiative: 'Malfermfonta Iniciato de Assertive Code',
      rightsNote: 'Eldonita sub malferma kuratoreco.',
      stewardship: 'Fido • Dankemo • Integreco • Respekto • Empatio • Libereco'
    }
  }
}

const { t, currentLocale, setLocale, locales } = useComponentI18n(footerTranslations)
const { localePath, getEquivalentPathForLocale } = useLocalePath()
const route = useRoute()
const router = useRouter()

const switchLocale = async (code: Locale) => {
  setLocale(code)
  const targetPath = getEquivalentPathForLocale(route.fullPath, code)
  if (targetPath !== route.fullPath) {
    await router.push(targetPath)
  }
}
</script>

<style scoped>
.app-footer {
  background-color: var(--bg-cream);
  border-top: 1px solid var(--border-color);
  color: var(--text-secondary);
  font-size: 0.95rem;
  margin-top: auto;
}

.footer-top {
  padding: 4.5rem 1.5rem 3rem 1.5rem;
  display: grid;
  grid-template-columns: 1.6fr 1fr 1fr 1.2fr;
  gap: 2.5rem;
}

.footer-logo {
  height: 34px;
  width: auto;
  object-fit: contain;
  margin-bottom: 1rem;
}

.footer-tagline {
  font-size: 0.95rem;
  line-height: 1.6;
  color: var(--text-secondary);
  margin-bottom: 1.5rem;
}

.footer-esperanto-box {
  display: flex;
  align-items: flex-start;
  gap: 0.75rem;
  padding: 1rem;
  background-color: var(--bg-surface);
  border: 1px solid var(--secondary-border);
  border-radius: var(--radius-md);
}

.star-icon {
  color: var(--secondary);
  font-size: 1.2rem;
  line-height: 1;
}

.footer-esperanto-box strong {
  display: block;
  font-family: var(--font-display);
  font-size: 0.88rem;
  color: var(--secondary);
  margin-bottom: 0.25rem;
}

.footer-esperanto-box p {
  font-size: 0.82rem;
  line-height: 1.5;
  color: var(--text-secondary);
}

.footer-col-title {
  font-size: 1.05rem;
  color: var(--text-primary);
  margin-bottom: 1.25rem;
  font-weight: 700;
}

.footer-links {
  list-style: none;
  display: flex;
  flex-direction: column;
  gap: 0.65rem;
}

.footer-links a {
  color: var(--text-secondary);
  transition: color var(--transition-fast);
  font-size: 0.92rem;
}

.footer-links a:hover {
  color: var(--primary);
  padding-left: 3px;
}

.footer-subtext {
  font-size: 0.88rem;
  margin-bottom: 1rem;
  color: var(--text-muted);
}

.footer-lang-pills {
  display: flex;
  flex-direction: column;
  gap: 0.45rem;
}

.footer-lang-btn {
  display: flex;
  align-items: center;
  gap: 0.6rem;
  padding: 0.5rem 0.8rem;
  background-color: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  font-size: 0.85rem;
  color: var(--text-primary);
  cursor: pointer;
  transition: all var(--transition-fast);
}

.footer-lang-btn:hover {
  border-color: var(--primary);
  background-color: var(--primary-light);
}

.footer-lang-btn.active {
  border-color: var(--primary);
  background-color: var(--primary-light);
  color: var(--primary);
  font-weight: 600;
}

/* Guardrail banner */
.guardrail-banner {
  background-color: var(--tertiary-blue-light);
  border-top: 1px solid var(--tertiary-blue-border);
  border-bottom: 1px solid var(--tertiary-blue-border);
  padding: 0.9rem 0;
}

.guardrail-inner {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  text-align: center;
}

.guardrail-icon {
  font-size: 1.1rem;
}

.guardrail-text {
  font-size: 0.85rem;
  font-weight: 600;
  color: var(--tertiary-blue);
}

/* Bottom */
.footer-bottom {
  padding: 1.75rem 0;
  border-top: 1px solid var(--border-subtle);
  background-color: var(--bg-subtle);
  font-size: 0.85rem;
  color: var(--text-muted);
}

.footer-bottom-inner {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 1.5rem;
  flex-wrap: wrap;
}

.stewardship-note {
  font-weight: 600;
  color: var(--secondary);
}

.footer-initiative-link {
  color: var(--secondary);
  font-weight: 600;
  text-decoration: underline;
  text-underline-offset: 3px;
  transition: color var(--transition-fast);
}

.footer-initiative-link:hover {
  color: var(--primary);
}

.footer-external-link {
  display: inline-flex;
  align-items: center;
  gap: 0.25rem;
}

@media (max-width: 992px) {
  .footer-top {
    grid-template-columns: 1fr 1fr;
    gap: 2rem;
  }
}

@media (max-width: 640px) {
  .footer-top {
    grid-template-columns: 1fr;
  }

  .footer-bottom-inner {
    flex-direction: column;
    text-align: center;
    gap: 0.75rem;
  }
}
</style>
