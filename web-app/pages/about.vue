<template>
  <div class="about-page">
    <!-- Hero / Header -->
    <section class="about-hero section-subtle">
      <div class="container container-narrow text-center">
        <div class="badge badge-esperanto">
          ★ {{ t('about.badge') }}
        </div>
        <h1>{{ t('about.title') }}</h1>
        <p class="hero-intro">
          {{ t('about.intro') }}
        </p>
      </div>
    </section>

    <!-- Why Bona Loko Was Born -->
    <section class="section">
      <div class="container container-narrow">
        <div class="story-block">
          <h2>{{ t('story.title') }}</h2>
          <p class="lead-p">
            {{ t('story.p1') }}
          </p>
          <p>
            {{ t('story.p2') }}
          </p>

          <div class="quote-card card shadow-sm">
            <span class="quote-mark">“</span>
            <p>{{ t('story.quote') }}</p>
            <a
              href="https://github.com/assertivecode/bona-loko/blob/main/FOUNDATION.md"
              target="_blank"
              rel="noopener noreferrer"
              class="quote-author"
              title="View FOUNDATION.md on GitHub"
            >
              {{ t('story.quoteAuthor') }} ↗
            </a>
          </div>
        </div>

        <!-- 3 First Principles -->
        <div class="principles-section">
          <h3>{{ t('principles.title') }}</h3>
          <div class="principles-grid">
            <div class="principle-card card">
              <span class="p-num">01</span>
              <h4>{{ t('principles.p1Title') }}</h4>
              <p>{{ t('principles.p1Desc') }}</p>
            </div>
            <div class="principle-card card">
              <span class="p-num">02</span>
              <h4>{{ t('principles.p2Title') }}</h4>
              <p>{{ t('principles.p2Desc') }}</p>
            </div>
            <div class="principle-card card">
              <span class="p-num">03</span>
              <h4>{{ t('principles.p3Title') }}</h4>
              <p>{{ t('principles.p3Desc') }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- 7 Core Moral Values (From FOUNDATION.md) -->
    <section id="values" class="section section-cream">
      <div class="container">
        <div class="section-header">
          <div class="badge badge-primary">
            🌟 {{ t('values.sectionBadge') }}
          </div>
          <h2>{{ t('values.title') }}</h2>
          <p>{{ t('values.subtitle') }}</p>
        </div>

        <div class="values-grid">
          <!-- 1. Faith -->
          <div class="value-card card">
            <div class="value-icon">⭐</div>
            <div class="value-names">
              <h3>{{ t('values.v1_name') }}</h3>
              <span class="trans-names">PT: Fé • EO: Fido</span>
            </div>
            <blockquote class="value-quote">
              “{{ t('values.v1_quote') }}”
            </blockquote>
            <div class="value-practice">
              <strong>{{ t('values.inPractice') }}:</strong>
              <p>{{ t('values.v1_practice') }}</p>
            </div>
          </div>

          <!-- 2. Gratitude -->
          <div class="value-card card">
            <div class="value-icon">☀️</div>
            <div class="value-names">
              <h3>{{ t('values.v2_name') }}</h3>
              <span class="trans-names">PT: Gratidão • EO: Dankemo</span>
            </div>
            <blockquote class="value-quote">
              “{{ t('values.v2_quote') }}”
            </blockquote>
            <div class="value-practice">
              <strong>{{ t('values.inPractice') }}:</strong>
              <p>{{ t('values.v2_practice') }}</p>
            </div>
          </div>

          <!-- 3. Humility -->
          <div class="value-card card">
            <div class="value-icon">🌱</div>
            <div class="value-names">
              <h3>{{ t('values.v3_name') }}</h3>
              <span class="trans-names">PT: Humildade • EO: Humileco</span>
            </div>
            <blockquote class="value-quote">
              “{{ t('values.v3_quote') }}”
            </blockquote>
            <div class="value-practice">
              <strong>{{ t('values.inPractice') }}:</strong>
              <p>{{ t('values.v3_practice') }}</p>
            </div>
          </div>

          <!-- 4. Integrity -->
          <div class="value-card card">
            <div class="value-icon">🛡️</div>
            <div class="value-names">
              <h3>{{ t('values.v4_name') }}</h3>
              <span class="trans-names">PT: Integridade • EO: Integreco</span>
            </div>
            <blockquote class="value-quote">
              “{{ t('values.v4_quote') }}”
            </blockquote>
            <div class="value-practice">
              <strong>{{ t('values.inPractice') }}:</strong>
              <p>{{ t('values.v4_practice') }}</p>
            </div>
          </div>

          <!-- 5. Respect -->
          <div class="value-card card">
            <div class="value-icon">🤝</div>
            <div class="value-names">
              <h3>{{ t('values.v5_name') }}</h3>
              <span class="trans-names">PT: Respeito • EO: Respekto</span>
            </div>
            <blockquote class="value-quote">
              “{{ t('values.v5_quote') }}”
            </blockquote>
            <div class="value-practice">
              <strong>{{ t('values.inPractice') }}:</strong>
              <p>{{ t('values.v5_practice') }}</p>
            </div>
          </div>

          <!-- 6. Empathy -->
          <div class="value-card card">
            <div class="value-icon">❤️</div>
            <div class="value-names">
              <h3>{{ t('values.v6_name') }}</h3>
              <span class="trans-names">PT: Empatia • EO: Empatio</span>
            </div>
            <blockquote class="value-quote">
              “{{ t('values.v6_quote') }}”
            </blockquote>
            <div class="value-practice">
              <strong>{{ t('values.inPractice') }}:</strong>
              <p>{{ t('values.v6_practice') }}</p>
            </div>
          </div>

          <!-- 7. Freedom -->
          <div class="value-card card">
            <div class="value-icon">⚓</div>
            <div class="value-names">
              <h3>{{ t('values.v7_name') }}</h3>
              <span class="trans-names">PT: Liberdade • EO: Libereco</span>
            </div>
            <blockquote class="value-quote">
              “{{ t('values.v7_quote') }}”
            </blockquote>
            <div class="value-practice">
              <strong>{{ t('values.inPractice') }}:</strong>
              <p>{{ t('values.v7_practice') }}</p>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Habit Anatomy & Behavioral Bridge -->
    <section class="section">
      <div class="container container-narrow">
        <div class="section-header">
          <div class="badge badge-blue">
            🌱 {{ t('anatomy.sectionBadge') }}
          </div>
          <h2>{{ t('anatomy.title') }}</h2>
          <p>{{ t('anatomy.subtitle') }}</p>
        </div>

        <div class="anatomy-box card shadow-sm">
          <div class="anatomy-formula">
            <div class="formula-node">Life Area</div>
            <div class="formula-arr">➔</div>
            <div class="formula-node">Priority</div>
            <div class="formula-arr">➔</div>
            <div class="formula-node">Goal</div>
            <div class="formula-arr">➔</div>
            <div class="formula-node highlight-habit">Habit (Context + Trigger ➔ Action ➔ Reward)</div>
          </div>

          <div class="anatomy-list">
            <div class="anatomy-item">
              <strong>{{ t('anatomy.item1Title') }}:</strong>
              <span>{{ t('anatomy.item1Desc') }}</span>
            </div>
            <div class="anatomy-item">
              <strong>{{ t('anatomy.item2Title') }}:</strong>
              <span>{{ t('anatomy.item2Desc') }}</span>
            </div>
            <div class="anatomy-item">
              <strong>{{ t('anatomy.item3Title') }}:</strong>
              <span>{{ t('anatomy.item3Desc') }}</span>
            </div>
            <div class="anatomy-item">
              <strong>{{ t('anatomy.item4Title') }}:</strong>
              <span>{{ t('anatomy.item4Desc') }}</span>
            </div>
          </div>
        </div>

        <!-- Continuous Life Review Cycle -->
        <!-- <div class="review-block card">
          <div class="review-icon">🔁</div>
          <div class="review-content">
            <h3>{{ t('review.title') }}</h3>
            <p>{{ t('review.desc') }}</p>
            <div class="review-tags">
              <span class="tag">Quarterly Reassessments</span>
              <span class="tag">Visual Energy Shifts</span>
              <span class="tag">Longitudinal Growth</span>
            </div>
          </div>
        </div> -->
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { computed } from 'vue'
import { useHead } from '#app'
import { useComponentI18n } from '~/composables/useLocale'

// Component-Scoped Translation Dictionary for About Page (EN-US, PT-BR, EO)
const aboutTranslations = {
  'en-US': {
    meta: {
      title: 'About Bona Loko — Philosophy & Core Values'
    },
    about: {
      badge: 'Philosophy & Core Values',
      title: 'About Bona Loko',
      intro: 'Bona Loko ("Good Place" in Esperanto) was created from a fundamental belief: personal transformation requires a mentality focused in uncorruptibility where human dignity and sovereign attention are held with highest respect.'
    },
    story: {
      title: 'The Purpose Behind Bona Loko',
      p1: 'True personal growth begins with understanding what genuinely matters in life, rather than mindlessly completing arbitrary tasks. Lasting change happens when our daily actions reflect our deepest intentions and values.',
      p2: 'Bona Loko is founded on uncorruptibility, empathy, and responsible freedom. We prioritize understanding what matters first, discovering where energy actually goes, and closing priority gaps with calm compassion.',
      quote: 'Personal transformation requires a mentality focused in uncorruptibility. To help people discover their own life balance, the platform must remain steadfast in its values and uncompromised in its independence.',
      quoteAuthor: 'Platform Moral Constitution (FOUNDATION.md)'
    },
    principles: {
      title: 'Our 3 First Principles',
      p1Title: '1. Defining What Matters',
      p1Desc: 'Clarify your personal values without external judgment or imposed definitions of a "good life".',
      p2Title: '2. Measuring Attention Reality',
      p2Desc: 'Honestly map where your finite physical time and mental energy are realistically invested.',
      p3Title: '3. Closing the Priority Gaps',
      p3Desc: 'Translate intentions into gentle, sustainable micro-habits anchored in daily context.'
    },
    values: {
      sectionBadge: 'Foundational Pillars',
      title: 'The 7 Core Moral Values',
      subtitle: 'These seven values govern every design decision, interaction, and recommendation on Bona Loko:',
      inPractice: 'In Practice',
      v1_name: 'Faith',
      v1_quote: 'Faith in yourself is the first step towards any change. And faith in others is what allows us to walk together and transform individual effort into collective progress.',
      v1_practice: 'The platform never diagnoses a user as broken or hopeless. Every feature assumes that human beings possess an innate capacity for renewal and self-directed transformation.',
      v2_name: 'Gratitude',
      v2_quote: 'We believe that those who practice gratitude learn to see abundance even in simplicity, cultivating appreciation for the helping hands along the way.',
      v2_practice: 'Habit tracking is not built around perpetual inadequacy or toxic hustle. Reflection cycles center on recognizing progress and finding joy in the journey.',
      v3_name: 'Humility',
      v3_quote: 'True integrity naturally takes root in humility: seeing ourselves honestly and gently as we genuinely are creates the foundation for authentic alignment between our inner thoughts and outer actions.',
      v3_practice: 'Assessment and habit tracking are stripped of ego, vanity, and posturing. We celebrate small, honest steps over performative streaks, treating setbacks as quiet invitations to learn and adjust.',
      v4_name: 'Integrity',
      v4_quote: 'Integrity is not a definitive achievement, but rather built on small choices that seem irrelevant, but which added together shape character.',
      v4_practice: 'Zero deceptive UX patterns, no artificial urgency, and absolute confidentiality over private self-reflections and journal notes.',
      v5_name: 'Respect',
      v5_quote: 'Where there is respect, difference is not a threat, but a learning experience. With respect we honor the dignity of each individual without distinction.',
      v5_practice: 'The platform does not impose a single ideology, religious dogma, or standardized life blueprint. Each person’s cultural heritage is held with absolute dignity.',
      v6_name: 'Empathy',
      v6_quote: 'Empathy transforms judgment into listening and indifference into care, giving others the dignity of being understood.',
      v6_practice: 'When users falter or break streaks, the system responds with compassionate understanding rather than punitive scores or guilt-inducing alerts.',
      v7_name: 'Freedom',
      v7_quote: 'Freedom is not the absence of rules, but rather the ability to create your own rules with responsibility.',
      v7_practice: 'You own your schedule, priorities, and data. We provide the canvas; you define the priorities and direct your life intentionally.'
    },
    anatomy: {
      sectionBadge: 'Behavioral Architecture',
      title: 'The Anatomy of a Habit',
      subtitle: 'Every habit in Bona Loko is not an isolated checklist item, but an explicit bridge connecting daily actions to life priorities.',
      item1Title: 'Parent Life Area & Purpose',
      item1Desc: 'Every behavior links to a designated domain (e.g., Mental Health, Relationships) answering the personal "Why".',
      item2Title: 'Type of Habit',
      item2Desc: 'Explicit distinction between additive positive routines and negative cessation or replacement routines.',
      item3Title: 'Contextual Cue & Trigger',
      item3Desc: 'Habits are anchored to specific times, places, or emotional triggers rather than arbitrary reminders.',
      item4Title: 'Friction Budgeting',
      item4Desc: 'Realistic cognitive and physical effort estimation to ensure the habit fits into your actual lifestyle.'
    },
    review: {
      title: 'Continuous Life Reviews',
      desc: 'Life is non-linear. A habit that served you well during one season may become counterproductive in another. Bona Loko fosters quarterly and annual life reviews to compare visual time allocations and realign with changing seasons.'
    }
  },
  'pt-BR': {
    meta: {
      title: 'Sobre a Bona Loko — Filosofia & Valores Fundamentais'
    },
    about: {
      badge: 'Filosofia & Valores Fundamentais',
      title: 'Sobre a Bona Loko',
      intro: 'Bona Loko ("Bom Lugar" em Esperanto) nasceu de uma convicção fundamental: a transformação pessoal exige uma mentalidade focada na incorruptibilidade, onde a dignidade humana e a atenção soberana sejam tratadas com o mais alto respeito.'
    },
    story: {
      title: 'O Propósito da Bona Loko',
      p1: 'O verdadeiro crescimento pessoal começa pela compreensão do que genuinamente importa na vida, em vez do cumprimento mecânico de tarefas arbitrárias. Mudanças duradouras acontecem quando as ações diárias refletem as intenções e os valores mais profundos.',
      p2: 'A Bona Loko é fundamentada na incorruptibilidade, empatia e liberdade responsável. Priorizamos compreender primeiro o que importa, identificar para onde a energia realmente vai e fechar lacunas de prioridade com serenidade e compaixão.',
      quote: 'A transformação pessoal requer uma mentalidade focada na incorruptibilidade. Para ajudar as pessoas a descobrirem seu próprio equilíbrio de vida, a plataforma deve permanecer inabalável em seus valores e independente.',
      quoteAuthor: 'Constituição Moral da Plataforma (FOUNDATION.md)'
    },
    principles: {
      title: 'Nossos 3 Primeiros Princípios',
      p1Title: '1. Definir o que Importa',
      p1Desc: 'Esclareça seus valores pessoais sem julgamentos externos ou definições padronizadas de "vida boa".',
      p2Title: '2. Medir a Realidade da Atenção',
      p2Desc: 'Mapeie honestamente onde seu tempo físico e sua energia mental finitos são investidos na prática.',
      p3Title: '3. Fechar as Lacunas de Prioridade',
      p3Desc: 'Traduza intenções em micro-hábitos sustentáveis ancorados no seu contexto diário.'
    },
    values: {
      sectionBadge: 'Pilares Fundamentais',
      title: 'Os 7 Valores Morais Fundamentais',
      subtitle: 'Esses sete valores governam cada decisão de design, interação e recomendação na Bona Loko:',
      inPractice: 'Na Prática',
      v1_name: 'Fé',
      v1_quote: 'A fé em si mesmo é o primeiro passo para qualquer mudança. E a fé nos outros é o que nos permite caminhar juntos e transformar o esforço individual em progresso coletivo.',
      v1_practice: 'A plataforma nunca diagnostica o usuário como incapaz ou quebrado. Cada recurso pressupõe que os seres humanos possuem uma capacidade inata de renovação.',
      v2_name: 'Gratidão',
      v2_quote: 'Acreditamos que aqueles que praticam a gratidão aprendem a ver abundância até na simplicidade, cultivando apreço pelas mãos estendidas no caminho.',
      v2_practice: 'O rastreamento de hábitos não se baseia em sensação de insuficiência perpétua ou correria tóxica. Os ciclos de reflexão celebram o progresso e o caminho.',
      v3_name: 'Humildade',
      v3_quote: 'A verdadeira integridade floresce a partir da humildade: enxergar a si mesmo com sinceridade e serenidade cria o alicerce para que sentimentos íntimos e conduta externa caminhem em harmonia autêntica.',
      v3_practice: 'A autoavaliação e o rastreamento de hábitos são desprovidos de vaidade ou defesas do ego. Celebramos passos modestos e honestos em vez de sequências performáticas, acolhendo desvios como convites para aprender.',
      v4_name: 'Integridade',
      v4_quote: 'A integridade constrói-se em pequenas escolhas que parecem irrelevantes, mas que, somadas, moldam o caráter.',
      v4_practice: 'Zero padrões obscuros, sem urgência artificial e com absoluta confidencialidade sobre reflexões pessoais.',
      v5_name: 'Respeito',
      v5_quote: 'Onde há respeito, a diferença não é ameaça, mas aprendizado. Com respeito honramos a dignidade de cada indivíduo sem distinção.',
      v5_practice: 'Não impomos ideologias, dogmas religiosos ou moldes fechados. A história e a cultura de cada pessoa são tratadas com dignidade absoluta.',
      v6_name: 'Empatia',
      v6_quote: 'A empatia transforma o julgamento em escuta e a indiferença em cuidado, dando aos outros a dignidade de serem compreendidos.',
      v6_practice: 'Quando o usuário enfrenta dificuldades ou quebra sequências, o sistema responde com acolhimento compreensivo em vez de punição.',
      v7_name: 'Liberdade',
      v7_quote: 'A liberdade não é a ausência de regras, mas a capacidade de criar suas próprias regras com responsabilidade.',
      v7_practice: 'Você é dono do seu tempo e prioridades. Nós fornecemos a tela; você decide o caminho e dirige sua vida com autonomia.'
    },
    anatomy: {
      sectionBadge: 'Arquitetura Comportamental',
      title: 'A Anatomia do Hábito',
      subtitle: 'Na Bona Loko, o hábito não é um checkbox solto, mas uma ponte explícita ligando as ações diárias às prioridades de vida.',
      item1Title: 'Área da Vida Mãe & Propósito',
      item1Desc: 'Cada comportamento liga-se a um domínio específico (Saúde Mental, Relacionamentos) respondendo ao "Porquê".',
      item2Title: 'Tipo de Comportamento',
      item2Desc: 'Diferenciação clara entre hábitos positivos a formar e hábitos nocivos a cessar ou substituir.',
      item3Title: 'Pista Contextual & Gatilho',
      item3Desc: 'Hábitos ancorados em momentos, locais e estados emocionais específicos.',
      item4Title: 'Orçamento de Esforço',
      item4Desc: 'Estimativa realista de esforço para garantir que o hábito caiba na sua vida real.'
    },
    review: {
      title: 'Revisão Contínua de Vida',
      desc: 'A vida não é linear. Um hábito que funcionou bem em uma fase pode se tornar inútil em outra. A Bona Loko incentiva revisões trimestrais e anuais para comparar a alocação de tempo e reajustar o rumo.'
    }
  },
  eo: {
    meta: {
      title: 'Pri Bona Loko — Filozofio & Kernaj Valoroj'
    },
    about: {
      badge: 'Filozofio & Kernaj Valoroj',
      title: 'Pri Bona Loko',
      intro: 'Bona Loko ("Good Place" en Esperanto) naskiĝis el fundamenta kredo: persona transformado postulas pensmanieron fokusitan al nekoruptebleco, kie homa digno kaj suverena atento estas plene respektataj.'
    },
    story: {
      title: 'La Celo de Bona Loko',
      p1: 'Vera persona kresko komenciĝas per kompreno de tio, kio vere gravas en la vivo, anstataŭ mekanika plenumo de arbitraj taskoj. Daŭraj ŝanĝoj okazas kiam ĉiutagaj agoj spegulas viajn plej profundajn intencojn kaj valorojn.',
      p2: 'Bona Loko baziĝas sur nekoruptebleco, empatio kaj respondeca libereco. Ni prioritatigas komprenon de tio kio gravas unue, malkovron de kien energio fakte fluas, kaj fermon de prioritataj mankoj kun kvieta kompato.',
      quote: 'Persona transformado postulas pensmanieron fokusitan al nekoruptebleco. Por helpi homojn malkovri sian viv-ekvilibron, la platformo devas resti fidela al siaj valoroj kaj sendependa.',
      quoteAuthor: 'Morala Konstitucio (FOUNDATION.md)'
    },
    principles: {
      title: 'Niaj 3 Unuaj Principoj',
      p1Title: '1. Difini Kio Gravas',
      p1Desc: 'Klarigu viajn personajn valorojn sen eksteraj juĝoj aŭ truditaj difinoj de "bona vivo".',
      p2Title: '2. Mezuri Atentan Realecon',
      p2Desc: 'Honeste mapu kien via finhava fizika tempo kaj mensa energio fakte estas investitaj.',
      p3Title: '3. Fermi Prioritatajn Mankojn',
      p3Desc: 'Traduku intencojn en mildajn, daŭripovajn mikro-kutimojn ankritajn en via ĉiutaga kunteksto.'
    },
    values: {
      sectionBadge: 'Fundamentaj Kolonoj',
      title: 'La 7 Kernaj Moralaj Valoroj',
      subtitle: 'Ĉi tiuj sep valoroj regas ĉiun dezajnan decidon kaj interagon en Bona Loko:',
      inPractice: 'En Praktiko',
      v1_name: 'Fido',
      v1_quote: 'Fido en si mem estas la unua paŝo al iu ajn ŝanĝo. Kaj fido en aliaj permesas al ni marŝi kune.',
      v1_practice: 'La platformo neniam diagnozas uzanton kiel rompitan. Ĉiu funkcio supozas ke homoj posedas denaskan kapablon por renoviĝo.',
      v2_name: 'Dankemo',
      v2_quote: 'Tiuj, kiuj praktikas dankemon, lernas vidi abundon eĉ en simpleco, kultivante aprezon por la helpantaj manoj.',
      v2_practice: 'Kutimspurigo ne baziĝas sur sento de konstanta malkontento. Reflektaj cikloj festas la progreson kaj vojaĝon.',
      v3_name: 'Humileco',
      v3_quote: 'Vera integreco nature floras el la humileco: vidi sin mem sincere kaj afable kreas la fundamenton por ke internaj pensoj kaj eksteraj agoj akordiĝu en profunda paco.',
      v3_practice: 'Memtaksado kaj kutim-spurado estas liberaj de egoismo kaj afektado. Ni festas etajn, sincerajn paŝojn anstataŭ spektaklajn vicojn, traktante malsukcesojn kiel trankvilajn invitojn lerni kaj pliboniĝi.',
      v4_name: 'Integreco',
      v4_quote: 'Integreco konstruiĝas per malgrandaj elektoj, kiuj ŝajnas negravaj, sed kiuj kune formas karakteron.',
      v4_practice: 'Nul malhelaj ŝablonoj, neniu artefarita urĝo kaj strikta konfidenceco pri personaj pensoj.',
      v5_name: 'Respekto',
      v5_quote: 'Kie estas respekto, diferenco estas lernado. Kun respekto ni honoras la dignon de ĉiu individuo.',
      v5_practice: 'Ni ne trudas ideologiojn aŭ religiajn dogmojn. La kultura fono de ĉiu persono estas traktata kun absoluta digno.',
      v6_name: 'Empatio',
      v6_quote: 'Empatio transformas juĝon en aŭskultadon kaj indiferentecon en zorgon, donante al aliaj la dignon esti komprenataj.',
      v6_practice: 'Kiam uzanto renkontas malfacilaĵojn, la sistemo respondas kun kompato anstataŭ punaj poentaroj.',
      v7_name: 'Libereco',
      v7_quote: 'Libereco estas la kapablo krei viajn proprajn regulojn kun respondeco.',
      v7_practice: 'Vi posedas vian tempon kaj prioritatojn. Ni provizas la tolon; vi elektas vian propran vojon.'
    },
    anatomy: {
      sectionBadge: 'Konduta Arkitekturo',
      title: 'La Anatomio de Kutimo',
      subtitle: 'En Bona Loko, kutimo estas eksplicita ponto liganta ĉiutagajn agojn al vivaj prioritatoj.',
      item1Title: 'Patra Vivareo & Celo',
      item1Desc: 'Ĉiu konduto ligiĝas al specifa vivareo respondante al la persona "Kial".',
      item2Title: 'Konduta Tipo',
      item2Desc: 'Klara distingo inter pozitivaj kutimoj por formi kaj malhelpaj kutimoj por anstataŭi.',
      item3Title: 'Kunteksta Ellasilo',
      item3Desc: 'Kutimoj ankritaj al specifaj tempoj, lokoj aŭ emociaj situacioj.',
      item4Title: 'Forta Buĝeto',
      item4Desc: 'Realisma takso de energio por certigi ke la kutimo konvenas al via vera vivo.'
    },
    review: {
      title: 'Kontinua Viva Revizio',
      desc: 'La vivo ne estas linia. Kutimo kiu bone servis en unu sezono povas fariĝi malutila en alia. Bona Loko instigas trimonatajn kaj jarajn reviziojn.'
    }
  }
}

const { t } = useComponentI18n(aboutTranslations)

useHead({
  title: computed(() => t('meta.title'))
})
</script>

<style scoped>
.about-hero {
  padding: 4.5rem 0 3.5rem 0;
}

.about-hero h1 {
  margin: 1rem 0 1.25rem 0;
  font-size: clamp(2.2rem, 4vw, 3.2rem);
}

.hero-intro {
  font-size: 1.15rem;
  line-height: 1.7;
  color: var(--text-secondary);
}

.story-block h2 {
  margin-bottom: 1.25rem;
  font-size: 1.85rem;
}

.lead-p {
  font-size: 1.12rem;
  color: var(--text-primary);
  line-height: 1.8;
  margin-bottom: 1.25rem;
}

.quote-card {
  position: relative;
  margin: 2.5rem 0;
  padding: 2.25rem;
  background-color: var(--bg-surface);
  border-left: 5px solid var(--primary);
}

.quote-mark {
  position: absolute;
  top: 0.5rem;
  right: 1.5rem;
  font-size: 4rem;
  line-height: 1;
  font-family: serif;
  color: var(--primary-border);
}

.quote-card p {
  font-size: 1.1rem;
  font-style: italic;
  line-height: 1.7;
  color: var(--text-primary);
  margin-bottom: 1rem;
}

.quote-author {
  font-size: 0.85rem;
  font-weight: 700;
  color: var(--primary);
  text-transform: uppercase;
  letter-spacing: 0.05em;
}

a.quote-author {
  display: inline-flex;
  align-items: center;
  gap: 0.35rem;
  text-decoration: underline;
  text-underline-offset: 3px;
  cursor: pointer;
  transition: color var(--transition-fast);
}

a.quote-author:hover {
  color: var(--primary-dark);
}

/* 3 Principles */
.principles-section {
  margin-top: 3.5rem;
}

.principles-section h3 {
  font-size: 1.45rem;
  margin-bottom: 1.5rem;
}

.principles-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.5rem;
}

.principle-card {
  display: flex;
  flex-direction: column;
  gap: 0.5rem;
}

.p-num {
  font-family: var(--font-display);
  font-size: 1.75rem;
  font-weight: 800;
  color: var(--primary);
}

.principle-card h4 {
  font-size: 1.1rem;
}

.principle-card p {
  font-size: 0.92rem;
}

/* Values Grid */
.values-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(320px, 1fr));
  gap: 1.5rem;
}

.value-card {
  display: flex;
  flex-direction: column;
  gap: 1rem;
  background-color: var(--bg-surface);
}

.value-icon {
  font-size: 2.25rem;
}

.value-names h3 {
  font-size: 1.35rem;
  margin-bottom: 0.2rem;
}

.trans-names {
  font-size: 0.78rem;
  font-weight: 600;
  color: var(--text-muted);
}

.value-quote {
  font-style: italic;
  font-size: 0.92rem;
  color: var(--text-secondary);
  line-height: 1.6;
  border-left: 2px solid var(--border-color);
  padding-left: 0.85rem;
}

.value-practice {
  margin-top: auto;
  padding-top: 0.85rem;
  border-top: 1px solid var(--border-subtle);
  font-size: 0.85rem;
}

.value-practice strong {
  display: block;
  font-size: 0.78rem;
  text-transform: uppercase;
  letter-spacing: 0.05em;
  color: var(--secondary);
  margin-bottom: 0.25rem;
}

/* Habit Anatomy Box */
.anatomy-box {
  background-color: var(--bg-surface);
  padding: 2.25rem;
  border-radius: var(--radius-xl);
  margin-bottom: 2.5rem;
}

.anatomy-formula {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 0.75rem;
  flex-wrap: wrap;
  padding: 1.25rem;
  background-color: var(--bg-subtle);
  border-radius: var(--radius-md);
  margin-bottom: 2rem;
}

.formula-node {
  font-size: 0.88rem;
  font-weight: 700;
  padding: 0.4rem 0.8rem;
  background-color: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
}

.formula-arr {
  color: var(--text-muted);
  font-weight: bold;
}

.highlight-habit {
  background-color: var(--primary-light);
  border-color: var(--primary-border);
  color: var(--primary);
}

.anatomy-list {
  display: flex;
  flex-direction: column;
  gap: 1.15rem;
}

.anatomy-item strong {
  display: block;
  font-size: 1rem;
  color: var(--text-primary);
  margin-bottom: 0.2rem;
}

.anatomy-item span {
  font-size: 0.92rem;
  color: var(--text-secondary);
}

/* Review Block */
.review-block {
  display: flex;
  align-items: flex-start;
  gap: 1.5rem;
  padding: 2rem;
  background-color: var(--secondary-light);
  border-color: var(--secondary-border);
}

.review-icon {
  font-size: 2.5rem;
}

.review-content h3 {
  font-size: 1.25rem;
  color: var(--secondary);
  margin-bottom: 0.5rem;
}

.review-content p {
  font-size: 0.95rem;
  margin-bottom: 1rem;
}

.review-tags {
  display: flex;
  gap: 0.5rem;
  flex-wrap: wrap;
}

.tag {
  font-size: 0.78rem;
  font-weight: 700;
  padding: 0.25rem 0.65rem;
  background-color: var(--bg-surface);
  border: 1px solid var(--secondary-border);
  border-radius: var(--radius-pill);
  color: var(--secondary);
}

@media (max-width: 992px) {
  .values-grid { grid-template-columns: repeat(2, 1fr); }
  .principles-grid { grid-template-columns: 1fr; }
}

@media (max-width: 640px) {
  .values-grid { grid-template-columns: 1fr; }
  .review-block { flex-direction: column; }
}
</style>
