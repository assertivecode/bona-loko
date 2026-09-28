<template>
  <div class="sponsor-page">
    <!-- Hero / Header -->
    <section class="sponsor-hero section-subtle">
      <div class="container container-narrow text-center">
        <div class="badge badge-heart">
          💖 {{ t('hero.badge') }}
        </div>
        <h1>{{ t('hero.title') }}</h1>
        <p class="hero-intro">
          {{ t('hero.intro') }}
        </p>
        <div class="hero-actions">
          <a
            href="https://github.com/sponsors/assertivecode"
            target="_blank"
            rel="noopener noreferrer"
            class="btn btn-primary btn-lg github-sponsor-btn"
          >
            <svg class="heart-icon" viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
              <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
            </svg>
            {{ t('hero.ctaPrimary') }} ↗
          </a>
          <a
            href="https://github.com/assertivecode/bona-loko"
            target="_blank"
            rel="noopener noreferrer"
            class="btn btn-outline btn-lg"
          >
            {{ t('hero.ctaSecondary') }} ↗
          </a>
        </div>
      </div>
    </section>

    <!-- Moral Guardrail Banner: Rule 4 Incorruptibility -->
    <section class="section guardrail-section">
      <div class="container container-narrow">
        <div class="guardrail-card card">
          <div class="guardrail-header">
            <span class="guardrail-badge">🛡️ {{ t('guardrails.badge') }}</span>
            <h2>{{ t('guardrails.title') }}</h2>
          </div>
          <p class="guardrail-quote">
            “{{ t('guardrails.quote') }}”
          </p>
          <div class="guardrail-points">
            <div class="point-item">
              <span class="point-icon">✓</span>
              <div>
                <strong>{{ t('guardrails.p1Title') }}</strong>
                <p>{{ t('guardrails.p1Desc') }}</p>
              </div>
            </div>
            <div class="point-item">
              <span class="point-icon">✓</span>
              <div>
                <strong>{{ t('guardrails.p2Title') }}</strong>
                <p>{{ t('guardrails.p2Desc') }}</p>
              </div>
            </div>
            <div class="point-item">
              <span class="point-icon">✓</span>
              <div>
                <strong>{{ t('guardrails.p3Title') }}</strong>
                <p>{{ t('guardrails.p3Desc') }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Why Your Sponsorship Matters -->
    <section class="section section-subtle">
      <div class="container">
        <div class="text-center section-header">
          <span class="section-tag">{{ t('impact.tag') }}</span>
          <h2>{{ t('impact.title') }}</h2>
          <p class="section-desc">{{ t('impact.desc') }}</p>
        </div>

        <div class="impact-grid">
          <div class="impact-card card">
            <div class="impact-icon-wrapper">
              <span class="impact-icon">🌱</span>
            </div>
            <h3>{{ t('impact.c1Title') }}</h3>
            <p>{{ t('impact.c1Desc') }}</p>
          </div>

          <div class="impact-card card">
            <div class="impact-icon-wrapper">
              <span class="impact-icon">🌐</span>
            </div>
            <h3>{{ t('impact.c2Title') }}</h3>
            <p>{{ t('impact.c2Desc') }}</p>
          </div>

          <div class="impact-card card">
            <div class="impact-icon-wrapper">
              <span class="impact-icon">📱</span>
            </div>
            <h3>{{ t('impact.c3Title') }}</h3>
            <p>{{ t('impact.c3Desc') }}</p>
          </div>

          <div class="impact-card card">
            <div class="impact-icon-wrapper">
              <span class="impact-icon">🔒</span>
            </div>
            <h3>{{ t('impact.c4Title') }}</h3>
            <p>{{ t('impact.c4Desc') }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Sponsorship Tiers -->
    <section class="section">
      <div class="container">
        <div class="text-center section-header">
          <span class="section-tag">{{ t('tiers.tag') }}</span>
          <h2>{{ t('tiers.title') }}</h2>
          <p class="section-desc">{{ t('tiers.desc') }}</p>
        </div>

        <div class="tiers-grid">
          <!-- Tier 1 -->
          <div class="tier-card card">
            <div class="tier-badge">{{ t('tiers.t1Badge') }}</div>
            <h3 class="tier-name">{{ t('tiers.t1Name') }}</h3>
            <div class="tier-amount">$5 <span class="tier-freq">/ month</span></div>
            <p class="tier-desc">{{ t('tiers.t1Desc') }}</p>
            <a
              href="https://github.com/sponsors/assertivecode"
              target="_blank"
              rel="noopener noreferrer"
              class="btn btn-outline btn-full tier-btn"
            >
              {{ t('tiers.selectTier') }} ↗
            </a>
          </div>

          <!-- Tier 2 (Highlighted) -->
          <div class="tier-card card tier-featured">
            <div class="tier-featured-pill">{{ t('tiers.popularBadge') }}</div>
            <div class="tier-badge">{{ t('tiers.t2Badge') }}</div>
            <h3 class="tier-name">{{ t('tiers.t2Name') }}</h3>
            <div class="tier-amount">$15 <span class="tier-freq">/ month</span></div>
            <p class="tier-desc">{{ t('tiers.t2Desc') }}</p>
            <a
              href="https://github.com/sponsors/assertivecode"
              target="_blank"
              rel="noopener noreferrer"
              class="btn btn-primary btn-full tier-btn"
            >
              {{ t('tiers.selectTier') }} ↗
            </a>
          </div>

          <!-- Tier 3 -->
          <div class="tier-card card">
            <div class="tier-badge">{{ t('tiers.t3Badge') }}</div>
            <h3 class="tier-name">{{ t('tiers.t3Name') }}</h3>
            <div class="tier-amount">$50 <span class="tier-freq">/ month</span></div>
            <p class="tier-desc">{{ t('tiers.t3Desc') }}</p>
            <a
              href="https://github.com/sponsors/assertivecode"
              target="_blank"
              rel="noopener noreferrer"
              class="btn btn-outline btn-full tier-btn"
            >
              {{ t('tiers.selectTier') }} ↗
            </a>
          </div>

          <!-- Tier 4 -->
          <div class="tier-card card">
            <div class="tier-badge">{{ t('tiers.t4Badge') }}</div>
            <h3 class="tier-name">{{ t('tiers.t4Name') }}</h3>
            <div class="tier-amount">$100+ <span class="tier-freq">/ month</span></div>
            <p class="tier-desc">{{ t('tiers.t4Desc') }}</p>
            <a
              href="https://github.com/sponsors/assertivecode"
              target="_blank"
              rel="noopener noreferrer"
              class="btn btn-outline btn-full tier-btn"
            >
              {{ t('tiers.selectTier') }} ↗
            </a>
          </div>
        </div>

        <div class="one-time-note text-center">
          <p>
            {{ t('tiers.oneTimeNote') }}
            <a
              href="https://github.com/sponsors/assertivecode"
              target="_blank"
              rel="noopener noreferrer"
              class="link-inline"
            >{{ t('tiers.oneTimeLink') }} ↗</a>
          </p>
        </div>
      </div>
    </section>

    <!-- FAQ Section -->
    <section class="section section-subtle">
      <div class="container container-narrow">
        <div class="text-center section-header">
          <span class="section-tag">{{ t('faq.tag') }}</span>
          <h2>{{ t('faq.title') }}</h2>
        </div>

        <div class="faq-list">
          <div class="faq-item card">
            <h4>{{ t('faq.q1') }}</h4>
            <p>{{ t('faq.a1') }}</p>
          </div>
          <div class="faq-item card">
            <h4>{{ t('faq.q2') }}</h4>
            <p>{{ t('faq.a2') }}</p>
          </div>
          <div class="faq-item card">
            <h4>{{ t('faq.q3') }}</h4>
            <p>{{ t('faq.a3') }}</p>
          </div>
        </div>
      </div>
    </section>

    <!-- Bottom CTA -->
    <section class="section sponsor-bottom-cta">
      <div class="container container-narrow text-center">
        <h2>{{ t('bottomCta.title') }}</h2>
        <p class="bottom-cta-desc">{{ t('bottomCta.desc') }}</p>
        <a
          href="https://github.com/sponsors/assertivecode"
          target="_blank"
          rel="noopener noreferrer"
          class="btn btn-primary btn-lg github-sponsor-btn"
        >
          <svg class="heart-icon" viewBox="0 0 24 24" width="20" height="20" fill="currentColor">
            <path d="M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z"/>
          </svg>
          {{ t('bottomCta.button') }} ↗
        </a>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useHead } from '#app'
import { useComponentI18n } from '~/composables/useLocale'

// Component-Scoped Translation Dictionary (EN-US, PT-BR, EO)
const sponsorTranslations = {
  'en-US': {
    meta: {
      title: 'Sponsor Bona Loko — Support Independent Open Source & Life Balance'
    },
    hero: {
      badge: 'GitHub Sponsors Community',
      title: 'Support Bona Loko',
      intro: 'Bona Loko is an open-source personal development platform built on a mentality focused in uncorruptibility. We operate completely free of advertising, corporate leverage, and data monetization. Voluntary sponsorship keeps our software independent, private, and accessible to everyone.',
      ctaPrimary: 'Sponsor on GitHub',
      ctaSecondary: 'Explore the Repository'
    },
    guardrails: {
      badge: 'Moral Constitution (FOUNDATION.md)',
      title: 'Rule 4: Incorruptibility & Unconditional Giving',
      quote: 'The platform must never be corrupted by money, commercial interests, corporate leverage, political agendas, or any other means. It is categorically prohibited to accept donations in exchange for advertising, propaganda, algorithmic favoritism, or commercial endorsements of any kind.',
      p1Title: 'Zero Quid-Pro-Quo',
      p1Desc: 'Financial contributions confer zero editorial power, feature gatekeeping, or algorithmic bias. The platform serves the user, always.',
      p2Title: 'Unconditional Patronage',
      p2Desc: 'All sponsorships are voluntary gifts that support ethical open-source tools for human flourishing across the globe.',
      p3Title: 'Clear Ethical Pre-Clearance',
      p3Desc: 'Every supporter participates with full knowledge that their contribution directly preserves human privacy and software autonomy.'
    },
    impact: {
      tag: 'Platform Impact',
      title: 'Where Your Support Goes',
      desc: 'Your sponsorship directly empowers the ongoing development and ethical maintenance of the Bona Loko ecosystem.',
      c1Title: 'Active Open Source Engineering',
      c1Desc: 'Continuous development of habit-building engines, life area assessment tools, and local-first SQLite databases.',
      c2Title: 'Trilingual Educational Synergy',
      c2Desc: 'Deep didactic guides, articles, and reflection tools natively written and maintained in English, Portuguese, and Esperanto.',
      c3Title: 'Mobile App Distribution',
      c3Desc: 'Maintaining active developer memberships and publishing seamless, tracker-free builds to the Google Play Store and Apple App Store.',
      c4Title: 'Absolute Privacy & Zero Ads',
      c4Desc: 'Keeping our servers and tools completely free of behavioral trackers, analytics brokers, and invasive corporate marketing.'
    },
    tiers: {
      tag: 'Sponsorship Tiers',
      title: 'Become an Open Source Steward',
      desc: 'Choose a monthly tier or contribute a one-time sponsorship via GitHub Sponsors.',
      popularBadge: 'Most Popular',
      selectTier: 'Sponsor via GitHub',
      oneTimeNote: 'Prefer to make a one-time contribution instead of monthly?',
      oneTimeLink: 'One-time donations are available on our GitHub Sponsors profile',
      t1Badge: 'Amiko',
      t1Name: 'Friendly Supporter',
      t1Desc: 'A warm, voluntary gesture of support to help keep our open-source tools independent and freely accessible to everyone.',
      t2Badge: 'Kuratoro',
      t2Name: 'Mindful Steward',
      t2Desc: 'Mindful patronage supporting the care, privacy, and continuous maintenance of the Bona Loko ecosystem.',
      t3Badge: 'Gardanto',
      t3Name: 'Open Source Guardian',
      t3Desc: 'Substantial support championing ad-free, sovereign personal growth and trilingual education across the globe.',
      t4Badge: 'Heroo',
      t4Name: 'Platform Hero',
      t4Desc: 'Deep, transformative generosity empowering the long-term independence and uncorruptible mission of the platform.'
    },
    faq: {
      tag: 'Frequently Asked Questions',
      title: 'Transparency & Giving',
      q1: 'How does GitHub Sponsors work?',
      a1: 'GitHub Sponsors allows you to support open-source creators directly using your existing GitHub account. GitHub charges 0% payment processing fees for individuals, ensuring maximum impact for your contribution.',
      q2: 'Are there any commercial perks or advertising for sponsors?',
      a2: 'No. Under Rule 4 of our Platform Foundation, sponsorship is strictly non-transactional and confers zero advertising, algorithmic favoritism, or commercial influence. We protect the uncorruptible integrity of our users and tools.',
      q3: 'Can I sponsor on behalf of an organization or team?',
      a3: 'Yes, organizations can sponsor through their GitHub organization account under the same non-transactional principles: supporting open-source software that respects human dignity and attention.'
    },
    bottomCta: {
      title: 'Nurture Ethical, Sovereign Software',
      desc: 'Join us in building a calmer, more intentional space for personal growth and sustainable habits.',
      button: 'Sponsor Bona Loko on GitHub'
    }
  },
  'pt-BR': {
    meta: {
      title: 'Apoie o Bona Loko — Apoie o Código Aberto Independente e o Equilíbrio de Vida'
    },
    hero: {
      badge: 'Comunidade GitHub Sponsors',
      title: 'Apoie o Bona Loko',
      intro: 'O Bona Loko é uma plataforma de desenvolvimento pessoal em código aberto construída sobre uma mentalidade focada na incorruptibilidade. Operamos sem anúncios, sem influências corporativas e sem monetização de dados. O patrocínio voluntário mantém nosso software independente, privado e acessível a todas as pessoas.',
      ctaPrimary: 'Apoiar no GitHub',
      ctaSecondary: 'Explorar o Repositório'
    },
    guardrails: {
      badge: 'Constituição Moral (FOUNDATION.md)',
      title: 'Regra 4: Incorruptibilidade & Doações Incondicionais',
      quote: 'A plataforma nunca deve ser corrompida por dinheiro, interesses comerciais, pressão corporativa, agendas políticas ou quaisquer outros meios. É categoricamente proibido aceitar doações em troca de publicidade, propaganda, favorecimento algorítmico ou endossos comerciais de qualquer tipo.',
      p1Title: 'Zero Troca de Favores (Quid-Pro-Quo)',
      p1Desc: 'Contribuições financeiras conferem zero poder editorial, privilégios de recursos ou viés algorítmico. A plataforma serve ao usuário, sempre.',
      p2Title: 'Patronato Incondicional',
      p2Desc: 'Todos os apoios são doações voluntárias que sustentam ferramentas éticas de código aberto para o florescimento humano.',
      p3Title: 'Clareza Ética Prévia',
      p3Desc: 'Cada apoiador participa com plena consciência de que sua contribuição preserva diretamente a privacidade e a autonomia do software.'
    },
    impact: {
      tag: 'Impacto da Plataforma',
      title: 'Para Onde Vai o Seu Apoio',
      desc: 'Seu patrocínio fortalece diretamente o desenvolvimento contínuo e a manutenção ética do ecossistema Bona Loko.',
      c1Title: 'Engenharia Ativa em Código Aberto',
      c1Desc: 'Desenvolvimento contínuo de motores de construção de hábitos, ferramentas de avaliação de áreas da vida e bancos SQLite locais.',
      c2Title: 'Sinergia Educacional Trilíngue',
      c2Desc: 'Guias didáticos profundos, artigos e ferramentas de reflexão escritos nativamente em Português, Inglês e Esperanto.',
      c3Title: 'Distribuição nos Aplicativos Móveis',
      c3Desc: 'Manutenção de contas de desenvolvedor e publicação de compilações transparentes e sem rastreadores no Google Play e na App Store.',
      c4Title: 'Privacidade Absoluta & Zero Anúncios',
      c4Desc: 'Mantendo nossos servidores e ferramentas totalmente livres de rastreadores comportamentais e anúncios comerciais invasivos.'
    },
    tiers: {
      tag: 'Níveis de Apoio',
      title: 'Torne-se um Custódio do Código Aberto',
      desc: 'Escolha um valor mensal ou contribua com um apoio pontual através do GitHub Sponsors.',
      popularBadge: 'Mais Popular',
      selectTier: 'Apoiar via GitHub',
      oneTimeNote: 'Prefere fazer uma contribuição única em vez de mensal?',
      oneTimeLink: 'Doações pontuais estão disponíveis em nosso perfil do GitHub Sponsors',
      t1Badge: 'Amigo',
      t1Name: 'Apoiador Amigo',
      t1Desc: 'Um gesto acolhedor e voluntário de apoio para manter nossas ferramentas de código aberto independentes e acessíveis a todos.',
      t2Badge: 'Curador',
      t2Name: 'Custódio Consciente',
      t2Desc: 'Patronato consciente apoiando o cuidado, a privacidade e a manutenção contínua do ecossistema Bona Loko.',
      t3Badge: 'Guardião',
      t3Name: 'Guardião do Código Aberto',
      t3Desc: 'Apoio generoso defendendo o desenvolvimento pessoal soberano, livre de anúncios e a educação trilíngue.',
      t4Badge: 'Herói',
      t4Name: 'Herói da Plataforma',
      t4Desc: 'Generosidade profunda e transformadora que fortalece a independência duradoura e a missão incorruptível da plataforma.'
    },
    faq: {
      tag: 'Perguntas Frequentes',
      title: 'Transparência & Doações',
      q1: 'Como funciona o GitHub Sponsors?',
      a1: 'O GitHub Sponsors permite que você apoie criadores de código aberto diretamente através da sua conta do GitHub, com 0% de taxas de intermediação para pessoas físicas.',
      q2: 'Existem vantagens comerciais ou publicidade para patrocinadores?',
      a2: 'Não. Pela Regra 4 de nossa Fundação, o patrocínio é estritamente não transacional e não concede anúncios, favorecimento algorítmico ou influência comercial.',
      q3: 'Posso patrocinar em nome de uma empresa ou equipe?',
      a3: 'Sim, empresas e equipes podem patrocinar através de suas contas corporativas no GitHub sob o mesmo princípio ético incondicional.'
    },
    bottomCta: {
      title: 'Cultive um Software Ético e Soberano',
      desc: 'Una-se a nós na construção de um espaço calmo e intencional para o desenvolvimento pessoal e hábitos sustentáveis.',
      button: 'Apoiar o Bona Loko no GitHub'
    }
  },
  'eo': {
    meta: {
      title: 'Subtenu Bona Loko — Subtenu Sendependan Malfermfonton kaj Viv-Ekvilibron'
    },
    hero: {
      badge: 'Komunumo de GitHub Sponsors',
      title: 'Subtenu Bona Loko',
      intro: 'Bona Loko estas malfermfonta platformo por persona disvolviĝo bazita sur pensmaniero fokusita al nekoruptebleco. Ni funkcias tute sen reklamoj, kompaniaj premoj aŭ ekspluatado de datumoj. Libervola subteno konservas nian programaron sendependa, privata kaj alirebla por ĉiuj.',
      ctaPrimary: 'Subteni ĉe GitHub',
      ctaSecondary: 'Esplori la Kodujon'
    },
    guardrails: {
      badge: 'Morala Konstitucio (FOUNDATION.md)',
      title: 'Regulo 4: Nekoruptebleco & Senkondiĉaj Donacoj',
      quote: 'La platformo neniam devas esti koruptita per mono, komercaj interesoj, kompania premo, politikaj agendoj aŭ aliaj rimedoj. Estas kategorie malpermesite akcepti donacojn kontraŭ reklamado, propagando, algoritma favorado aŭ ajnaj komercaj rekomendoj.',
      p1Title: 'Nula Komerca Interŝanĝo (Quid-Pro-Quo)',
      p1Desc: 'Monaj kontribuoj donas nulan redaktan potencon aŭ algoritman antaŭjuĝon. La platformo ĉiam servas la uzanton.',
      p2Title: 'Senkondiĉa Subteno',
      p2Desc: 'Ĉiuj subtenoj estas libervolaj donacoj, kiuj subtenas etikajn malfermfontajn ilojn por homa florado.',
      p3Title: 'Klareca Etika Informo',
      p3Desc: 'Ĉiu subtenanto partoprenas kun plena scio, ke ilia kontribuo rekte konservas privatecon kaj aŭtonomecon.'
    },
    impact: {
      tag: 'Platforma Efiko',
      title: 'Kien Iras Via Subteno',
      desc: 'Via subteno rekte ebligas la daŭran disvolviĝon kaj etikan prizorgadon de la ekosistemo Bona Loko.',
      c1Title: 'Aktiva Malfermfonta Inĝenierado',
      c1Desc: 'Daŭra kreado de kutim-konstruaj motoroj, viv-areaj taksadiloj kaj lokaj SQLite-datumbazoj.',
      c2Title: 'Trilingva Eduka Sinergio',
      c2Desc: 'Profundaj gvidiloj, artikoloj kaj reflektaj iloj denaske verkitaj en la angla, portugala kaj Esperanto.',
      c3Title: 'Poŝtelefona Distribuo',
      c3Desc: 'Konservado de programistaj kontoj kaj publikigo de senpagaj, sen-spuantaj versioj en Google Play kaj Apple App Store.',
      c4Title: 'Absoluta Privateco & Nulaj Reklamoj',
      c4Desc: 'Konservi niajn servilojn kaj ilojn tute liberaj de kondutaj spuriloj kaj trudema merkatado.'
    },
    tiers: {
      tag: 'Subtenaj Niveloj',
      title: 'Fariĝu Kuratoro de Malfermfonto',
      desc: 'Elektu monatan nivelon aŭ faru unuhoman donacon per GitHub Sponsors.',
      popularBadge: 'Plej Populara',
      selectTier: 'Subteni per GitHub',
      oneTimeNote: 'Ĉu vi preferas fari ununuran donacon anstataŭ monata?',
      oneTimeLink: 'Unufojaj donacoj estas disponeblaj en nia profilo de GitHub Sponsors',
      t1Badge: 'Amiko',
      t1Name: 'Amika Subtenanto',
      t1Desc: 'Kora, libervola subtena gesto por helpi konservi niajn malfermfontajn ilojn sendependaj kaj libere alireblaj por ĉiuj.',
      t2Badge: 'Kuratoro',
      t2Name: 'Pripensanta Kuratoro',
      t2Desc: 'Pripensita kuratoreco subtenanta la zorgon, privatecon kaj daŭran bontenadon de la ekosistemo Bona Loko.',
      t3Badge: 'Gardanto',
      t3Name: 'Malfermfonta Gardanto',
      t3Desc: 'Signifa subteno defendanta senreklaman, suverenan personan kreskon kaj trilingvan edukadon tutmonde.',
      t4Badge: 'Heroo',
      t4Name: 'Platforma Heroo',
      t4Desc: 'Profunda, transforma malavareco ebliganta la longdaŭran sendependecon kaj nekorupteblan mision de la platformo.'
    },
    faq: {
      tag: 'Oftaj Demandoj',
      title: 'Travidebleco & Donacoj',
      q1: 'Kiel funkcias GitHub Sponsors?',
      a1: 'GitHub Sponsors ebligas vin subteni malfermfontajn kreintojn rekte per via ekzistanta GitHub-konto sen aldonaj peraj kotizoj por individuoj.',
      q2: 'Ĉu ekzistas komercaj avantaĝoj aŭ reklamoj por sponsoroj?',
      a2: 'Ne. Laŭ Regulo 4 de nia Fondaĵo, sponsorado estas strikte senkondiĉa kaj donas nulan reklamon, algoritman preferon aŭ komercan influon.',
      q3: 'Ĉu mi povas sponsori nome de organizo aŭ teamo?',
      a3: 'Jes, organizoj povas sponsori per siaj GitHub-organizo-kontoj sub la samaj etikaj principoj de senkondiĉa subteno.'
    },
    bottomCta: {
      title: 'Subtenu Etikan kaj Suverenan Programaron',
      desc: 'Aliĝu al ni en la konstruado de paca kaj intenca spaco por persona kresko kaj daŭripovaj kutimoj.',
      button: 'Subteni Bona Loko ĉe GitHub'
    }
  }
}

const { t } = useComponentI18n(sponsorTranslations)

useHead({
  title: computed(() => t('meta.title'))
})
</script>

<style scoped>
.sponsor-hero {
  padding: 4.5rem 1.5rem 3.5rem 1.5rem;
}

.badge-heart {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.35rem 0.85rem;
  background-color: #fee2e2;
  border: 1px solid #fca5a5;
  border-radius: var(--radius-pill);
  font-size: 0.82rem;
  font-weight: 700;
  color: #b91c1c;
  margin-bottom: 1.25rem;
}

.hero-intro {
  font-size: 1.15rem;
  line-height: 1.7;
  color: var(--text-secondary);
  max-width: 680px;
  margin: 1.25rem auto 2rem auto;
}

.hero-actions {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.github-sponsor-btn {
  display: inline-flex;
  align-items: center;
  gap: 0.6rem;
  background-color: #db2777;
  border-color: #db2777;
  color: #ffffff;
  font-weight: 700;
  transition: all var(--transition-fast);
}

.github-sponsor-btn:hover {
  background-color: #be185d;
  border-color: #be185d;
  color: #ffffff;
  transform: translateY(-2px);
  box-shadow: 0 4px 12px rgba(219, 39, 119, 0.3);
}

.heart-icon {
  fill: currentColor;
}

/* Guardrails section */
.guardrail-section {
  padding-top: 2rem;
  padding-bottom: 2rem;
}

.guardrail-card {
  background-color: var(--tertiary-blue-light);
  border: 1px solid var(--tertiary-blue-border);
  padding: 2.25rem;
  border-radius: var(--radius-lg);
}

.guardrail-header {
  margin-bottom: 1rem;
}

.guardrail-badge {
  display: inline-block;
  font-size: 0.8rem;
  font-weight: 700;
  color: var(--tertiary-blue);
  text-transform: uppercase;
  letter-spacing: 0.05em;
  margin-bottom: 0.5rem;
}

.guardrail-header h2 {
  font-size: 1.45rem;
  color: var(--text-primary);
  margin: 0;
}

.guardrail-quote {
  font-family: var(--font-display);
  font-size: 1rem;
  font-style: italic;
  line-height: 1.6;
  color: var(--tertiary-blue);
  background: rgba(255, 255, 255, 0.6);
  padding: 1rem 1.25rem;
  border-left: 4px solid var(--tertiary-blue);
  border-radius: var(--radius-sm);
  margin-bottom: 1.5rem;
}

.guardrail-points {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.5rem;
}

.point-item {
  display: flex;
  align-items: flex-start;
  gap: 0.75rem;
}

.point-icon {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 24px;
  height: 24px;
  border-radius: 50%;
  background-color: var(--tertiary-blue);
  color: #ffffff;
  font-size: 0.8rem;
  font-weight: bold;
  flex-shrink: 0;
  margin-top: 2px;
}

.point-item strong {
  display: block;
  font-size: 0.95rem;
  color: var(--text-primary);
  margin-bottom: 0.25rem;
}

.point-item p {
  font-size: 0.85rem;
  line-height: 1.5;
  color: var(--text-secondary);
  margin: 0;
}

/* Impact section */
.section-header {
  margin-bottom: 2.75rem;
}

.section-tag {
  display: inline-block;
  font-size: 0.82rem;
  font-weight: 700;
  color: var(--primary);
  text-transform: uppercase;
  letter-spacing: 0.08em;
  margin-bottom: 0.5rem;
}

.section-desc {
  font-size: 1.05rem;
  color: var(--text-secondary);
  max-width: 600px;
  margin: 0.5rem auto 0 auto;
}

.impact-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1.5rem;
}

.impact-card {
  padding: 2rem 1.5rem;
  text-align: center;
  transition: transform var(--transition-fast), box-shadow var(--transition-fast);
}

.impact-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-md);
}

.impact-icon-wrapper {
  width: 56px;
  height: 56px;
  border-radius: 16px;
  background-color: var(--primary-light);
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 1.25rem auto;
}

.impact-icon {
  font-size: 1.75rem;
}

.impact-card h3 {
  font-size: 1.1rem;
  margin-bottom: 0.75rem;
  color: var(--text-primary);
}

.impact-card p {
  font-size: 0.9rem;
  line-height: 1.6;
  color: var(--text-secondary);
  margin: 0;
}

/* Tiers section */
.tiers-grid {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1.5rem;
  align-items: stretch;
}

.tier-card {
  padding: 2rem 1.5rem;
  display: flex;
  flex-direction: column;
  position: relative;
  border-radius: var(--radius-lg);
  border: 1px solid var(--border-color);
  background: var(--bg-surface);
  transition: transform var(--transition-fast), box-shadow var(--transition-fast);
}

.tier-card:hover {
  transform: translateY(-4px);
  box-shadow: var(--shadow-md);
}

.tier-featured {
  border: 2px solid var(--primary);
  background-color: #ffffff;
  box-shadow: var(--shadow-md);
}

.tier-featured-pill {
  position: absolute;
  top: -12px;
  left: 50%;
  transform: translateX(-50%);
  background-color: var(--primary);
  color: #ffffff;
  font-size: 0.75rem;
  font-weight: 700;
  padding: 0.2rem 0.75rem;
  border-radius: var(--radius-pill);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

.tier-badge {
  font-size: 0.8rem;
  font-weight: 700;
  color: var(--secondary);
  text-transform: uppercase;
  letter-spacing: 0.05em;
  margin-bottom: 0.35rem;
}

.tier-name {
  font-size: 1.2rem;
  color: var(--text-primary);
  margin-bottom: 0.75rem;
}

.tier-amount {
  font-family: var(--font-display);
  font-size: 1.9rem;
  font-weight: 800;
  color: var(--text-primary);
  margin-bottom: 0.75rem;
}

.tier-freq {
  font-size: 0.85rem;
  font-weight: 500;
  color: var(--text-muted);
}

.tier-desc {
  font-size: 0.92rem;
  line-height: 1.6;
  color: var(--text-secondary);
  margin-bottom: 2rem;
  flex-grow: 1;
}

.tier-btn {
  margin-top: auto;
  text-align: center;
  font-weight: 600;
}

.one-time-note {
  margin-top: 2rem;
  font-size: 0.95rem;
  color: var(--text-muted);
}

.link-inline {
  color: var(--primary);
  font-weight: 600;
  text-decoration: underline;
  text-underline-offset: 3px;
}

/* FAQ */
.faq-list {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

.faq-item {
  padding: 1.5rem;
}

.faq-item h4 {
  font-size: 1.05rem;
  color: var(--text-primary);
  margin-bottom: 0.5rem;
}

.faq-item p {
  font-size: 0.92rem;
  line-height: 1.6;
  color: var(--text-secondary);
  margin: 0;
}

/* Bottom CTA */
.sponsor-bottom-cta {
  background-color: var(--bg-surface);
  border-top: 1px solid var(--border-color);
  padding: 4rem 1.5rem;
}

.bottom-cta-desc {
  font-size: 1.1rem;
  color: var(--text-secondary);
  max-width: 580px;
  margin: 0.75rem auto 1.75rem auto;
}

/* Responsive */
@media (max-width: 1024px) {
  .impact-grid,
  .tiers-grid {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 768px) {
  .guardrail-points {
    grid-template-columns: 1fr;
    gap: 1rem;
  }
}

@media (max-width: 640px) {
  .impact-grid,
  .tiers-grid {
    grid-template-columns: 1fr;
  }
  
  .hero-actions {
    flex-direction: column;
    width: 100%;
  }

  .hero-actions .btn {
    width: 100%;
    text-align: center;
    justify-content: center;
  }
}
</style>
