<template>
  <div class="closed-testing-page">
    <!-- Hero Header -->
    <section class="testing-hero section-subtle">
      <div class="container container-narrow text-center">
        <div class="badge badge-beta">
          📱 {{ t('hero.badge') }}
        </div>
        <h1>{{ t('hero.title') }}</h1>
        <p class="hero-intro">
          {{ t('hero.intro') }}
        </p>
      </div>
    </section>

    <!-- Why Closed Testing Matters Section -->
    <section class="section testing-process-section">
      <div class="container container-narrow">
        <div class="process-card card">
          <div class="process-header text-center">
            <span class="process-tag">{{ t('process.tag') }}</span>
            <h2>{{ t('process.title') }}</h2>
            <p class="process-desc">{{ t('process.desc') }}</p>
          </div>

          <div class="steps-grid">
            <div class="step-item">
              <div class="step-number">1</div>
              <div class="step-content">
                <h4>{{ t('process.step1Title') }}</h4>
                <p>{{ t('process.step1Desc') }}</p>
              </div>
            </div>

            <div class="step-item">
              <div class="step-number">2</div>
              <div class="step-content">
                <h4>{{ t('process.step2Title') }}</h4>
                <p>{{ t('process.step2Desc') }}</p>
              </div>
            </div>

            <div class="step-item">
              <div class="step-number">3</div>
              <div class="step-content">
                <h4>{{ t('process.step3Title') }}</h4>
                <p>{{ t('process.step3Desc') }}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </section>

    <!-- Application Form Section -->
    <section class="section form-section">
      <div class="container container-narrow">
        <div class="card form-card">
          <!-- Success State -->
          <div v-if="submissionState === 'success'" class="submission-success text-center">
            <div class="success-icon-wrapper">
              <span class="success-icon">✓</span>
            </div>
            <h3 class="success-title">{{ t('form.successTitle') }}</h3>
            <p class="success-desc">
              {{ t('form.successDesc') }}
            </p>
            <div class="success-info-box">
              <p>
                <strong>{{ t('form.successNextLabel') }}</strong>
                {{ t('form.successNextText') }}
              </p>
            </div>
            <div class="success-actions">
              <button type="button" class="btn btn-outline" @click="resetForm">
                {{ t('form.submitAnother') }}
              </button>
              <NuxtLink :to="localePath('home')" class="btn btn-primary">
                {{ t('form.exploreWeb') }}
              </NuxtLink>
            </div>
          </div>

          <!-- Form View -->
          <form v-else @submit.prevent="handleSubmit" class="testing-form" novalidate>
            <div class="form-header text-center">
              <h3>{{ t('form.heading') }}</h3>
              <p>{{ t('form.subheading') }}</p>
            </div>

            <!-- Error Banner -->
            <div v-if="errorMessage" class="form-error-banner" role="alert">
              <span>⚠️ {{ errorMessage }}</span>
            </div>

            <!-- Bot Honeypot -->
            <div class="honeypot-field" aria-hidden="true">
              <label for="testing_honeypot">Leave empty</label>
              <input
                id="testing_honeypot"
                v-model="formData.honeypot"
                type="text"
                name="honeypot"
                tabindex="-1"
                autocomplete="off"
              />
            </div>

            <!-- Row 1: Name & Store Email -->
            <div class="form-row">
              <div class="form-group">
                <label for="applicant_name" class="form-label">
                  {{ t('form.nameLabel') }} <span class="required-star">*</span>
                </label>
                <input
                  id="applicant_name"
                  v-model="formData.name"
                  type="text"
                  class="form-input"
                  :placeholder="t('form.namePlaceholder')"
                  required
                  :disabled="isSubmitting"
                />
              </div>

              <div class="form-group">
                <label for="applicant_email" class="form-label">
                  {{ t('form.emailLabel') }} <span class="required-star">*</span>
                </label>
                <input
                  id="applicant_email"
                  v-model="formData.email"
                  type="email"
                  class="form-input"
                  :placeholder="t('form.emailPlaceholder')"
                  required
                  :disabled="isSubmitting"
                />
                <span class="field-hint">{{ t('form.emailHint') }}</span>
              </div>
            </div>

            <!-- Row 2: Target Platform & Device Model -->
            <div class="form-row">
              <div class="form-group">
                <label for="applicant_platform" class="form-label">
                  {{ t('form.platformLabel') }} <span class="required-star">*</span>
                </label>
                <select
                  id="applicant_platform"
                  v-model="formData.platform"
                  class="form-select"
                  :disabled="isSubmitting"
                >
                  <option value="android">{{ t('form.optAndroid') }}</option>
                  <option value="ios">{{ t('form.optIos') }}</option>
                  <option value="both">{{ t('form.optBoth') }}</option>
                </select>
                <span class="field-hint">{{ t('form.platformHint') }}</span>
              </div>

              <div class="form-group">
                <label for="applicant_device" class="form-label">
                  {{ t('form.deviceLabel') }}
                </label>
                <input
                  id="applicant_device"
                  v-model="formData.deviceModel"
                  type="text"
                  class="form-input"
                  :placeholder="t('form.devicePlaceholder')"
                  :disabled="isSubmitting"
                />
                <span class="field-hint">{{ t('form.deviceHint') }}</span>
              </div>
            </div>

            <!-- Motivation & Habit Focus Notes -->
            <div class="form-group">
              <label for="applicant_notes" class="form-label">
                {{ t('form.notesLabel') }}
              </label>
              <textarea
                id="applicant_notes"
                v-model="formData.notes"
                class="form-textarea"
                rows="4"
                :placeholder="t('form.notesPlaceholder')"
                :disabled="isSubmitting"
              ></textarea>
              <span class="field-hint">{{ t('form.notesHint') }}</span>
            </div>

            <!-- Submit Button & Privacy Note -->
            <div class="form-actions text-center">
              <button
                type="submit"
                class="btn btn-primary btn-lg submit-btn"
                :disabled="isSubmitting"
              >
                <span v-if="isSubmitting" class="loading-spinner"></span>
                <span>{{ isSubmitting ? t('form.submittingBtn') : t('form.submitBtn') }}</span>
              </button>

              <p class="privacy-note">
                🔒 {{ t('form.privacyGuarantee') }}
              </p>
            </div>
          </form>
        </div>

        <!-- Open Source Transparency Note -->
        <div class="open-source-note text-center">
          <p>
            {{ t('footerNote.text') }}
            <a
              href="https://github.com/assertivecode/bona-loko"
              target="_blank"
              rel="noopener noreferrer"
              class="link-inline"
            >
              {{ t('footerNote.link') }} ↗
            </a>
          </p>
        </div>
      </div>
    </section>
  </div>
</template>

<script setup lang="ts">
import { ref, reactive, computed } from 'vue'
import { useHead } from '#app'
import { useComponentI18n, useLocalePath } from '~/composables/useLocale'

const localePath = useLocalePath()

// Component-Scoped Translation Dictionary (en-US, pt-BR, eo)
const testingTranslations = {
  'en-US': {
    meta: {
      title: 'Apply for Mobile App Closed Testing — Bona Loko',
      desc: 'Join the closed testing community of the Bona Loko mobile app for Android (Google Play) and iOS (TestFlight). Help build a calmer, uncorruptible habit platform.'
    },
    hero: {
      badge: 'Early Access & Community Testing',
      title: 'Join the Mobile App Closed Testing',
      intro: 'Bona Loko is preparing for its official release on the Google Play Store and Apple App Store. We invite thoughtful community members to test early mobile builds, experience our offline-first habit tracker, and help verify platform stability.'
    },
    process: {
      tag: 'How It Works',
      title: 'The Closed Testing Journey',
      desc: 'Google Play requires 20 dedicated community testers to run the app continuously for 14 days before public release. Here is how you can help us reach this milestone:',
      step1Title: 'Submit Your Store Email',
      step1Desc: 'Fill out the application below with the Google Play or Apple ID account email you use on your phone.',
      step2Title: 'Receive Your Invitation Link',
      step2Desc: 'We will register your email in the Google Play Console or Apple TestFlight and send your direct opt-in link.',
      step3Title: 'Install & Reflect Daily',
      step3Desc: 'Download the app, track your daily habits and life areas with complete offline privacy, and share any feedback.'
    },
    form: {
      heading: 'Closed Testing Application Form',
      subheading: 'Please provide your details below. We keep your information strictly confidential.',
      nameLabel: 'Your Name',
      namePlaceholder: 'e.g., Alex Morgan',
      emailLabel: 'Store Account Email (Google Play or Apple ID)',
      emailPlaceholder: 'e.g., alex@gmail.com or alex@icloud.com',
      emailHint: 'Must match the email logged into Google Play or the App Store on your test device.',
      platformLabel: 'Target Platform',
      platformHint: 'Choose which operating system you will use to test.',
      optAndroid: 'Android (Google Play Closed Testing)',
      optIos: 'iOS (Apple TestFlight)',
      optBoth: 'Both Android and iOS',
      deviceLabel: 'Device Model & OS Version (Optional)',
      devicePlaceholder: 'e.g., Pixel 7 Pro (Android 14) or iPhone 13 (iOS 17)',
      deviceHint: 'Helps us ensure broad hardware compatibility.',
      notesLabel: 'Notes or Habits of Interest (Optional)',
      notesPlaceholder: 'Share what life areas you are most focused on, or any specific features you look forward to testing...',
      notesHint: 'Any context that helps us understand your testing background.',
      submitBtn: 'Submit Testing Application',
      submittingBtn: 'Submitting Application...',
      privacyGuarantee: 'Your email is used strictly to send you the official store testing invitation. We will never share your information, sell data, or send promotional spam.',
      successTitle: 'Application Received with Gratitude!',
      successDesc: 'Thank you for volunteering to help test Bona Loko. Your application has been dispatched directly to the development team.',
      successNextLabel: 'What happens next:',
      successNextText: 'You will receive an official invitation link to join the closed test track on Google Play or Apple TestFlight as soon as your batch is added.',
      submitAnother: 'Submit another application',
      exploreWeb: 'Explore Web Platform',
      errFillFields: 'Please fill in all required fields.',
      errInvalidEmail: 'Please provide a valid email address so we can send your testing invite.',
      errGeneral: 'Failed to submit application. Please check your connection or reach out on GitHub.'
    },
    footerNote: {
      text: 'Curious about how Bona Loko is engineered?',
      link: 'Inspect our open-source Flutter mobile codebase on GitHub'
    }
  },
  'pt-BR': {
    meta: {
      title: 'Inscreva-se para o Teste Fechado do App — Bona Loko',
      desc: 'Participe da comunidade de teste fechado do aplicativo móvel Bona Loko para Android (Google Play) e iOS (TestFlight). Ajude a construir uma plataforma ética de hábitos.'
    },
    hero: {
      badge: 'Acesso Antecipado & Testes da Comunidade',
      title: 'Participe do Teste Fechado do App Móvel',
      intro: 'O Bona Loko está se preparando para seu lançamento oficial na Google Play Store e Apple App Store. Convidamos membros da comunidade a testarem compilações antecipadas do app, experimentando nosso rastreador de hábitos local e fortalecendo a estabilidade do sistema.'
    },
    process: {
      tag: 'Como Funciona',
      title: 'A Jornada do Teste Fechado',
      desc: 'A Google Play requer 20 testadores dedicados utilizando o aplicativo continuamente por 14 dias antes da publicação aberta. Veja como participar deste marco:',
      step1Title: 'Envie Seu E-mail da Loja',
      step1Desc: 'Preencha o formulário abaixo com o e-mail da conta Google Play ou Apple ID que você utiliza no celular.',
      step2Title: 'Receba Seu Link de Convite',
      step2Desc: 'Cadastraremos seu e-mail no Google Play Console ou TestFlight e enviaremos o link oficial para aceitar o teste.',
      step3Title: 'Instale e Pratique Diariamente',
      step3Desc: 'Baixe o app, acompanhe seus hábitos e áreas da vida com privacidade total offline e envie suas impressões.'
    },
    form: {
      heading: 'Formulário de Inscrição para Testadores',
      subheading: 'Informe seus dados abaixo. Tratamos suas informações com total confidencialidade.',
      nameLabel: 'Seu Nome',
      namePlaceholder: 'ex: Alex Silva',
      emailLabel: 'E-mail da Loja (Google Play ou Apple ID)',
      emailPlaceholder: 'ex: alex@gmail.com ou alex@icloud.com',
      emailHint: 'Deve corresponder à conta conectada à Google Play ou App Store no seu aparelho.',
      platformLabel: 'Plataforma de Teste',
      platformHint: 'Escolha qual sistema operacional você usará para testar.',
      optAndroid: 'Android (Google Play Closed Testing)',
      optIos: 'iOS (Apple TestFlight)',
      optBoth: 'Ambos (Android e iOS)',
      deviceLabel: 'Modelo do Aparelho & Versão do SO (Opcional)',
      devicePlaceholder: 'ex: Samsung Galaxy S23 (Android 14) ou iPhone 14 (iOS 17)',
      deviceHint: 'Nos ajuda a garantir ampla compatibilidade com diferentes modelos.',
      notesLabel: 'Observações ou Áreas de Interesse (Opcional)',
      notesPlaceholder: 'Conte quais áreas da vida você mais deseja equilibrar ou quais funcionalidades mais chamam sua atenção...',
      notesHint: 'Qualquer contexto sobre como você planeja utilizar o app.',
      submitBtn: 'Enviar Inscrição de Testador',
      submittingBtn: 'Enviando Inscrição...',
      privacyGuarantee: 'Seu e-mail será utilizado exclusivamente para enviar o convite oficial da loja. Jamais venderemos seus dados ou enviaremos publicidade.',
      successTitle: 'Inscrição Recebida com Gratidão!',
      successDesc: 'Muito obrigado por se voluntariar para testar o Bona Loko. Sua inscrição foi encaminhada diretamente à equipe de engenharia.',
      successNextLabel: 'O que acontece a seguir:',
      successNextText: 'Você receberá um link oficial de convite para ingressar na faixa de teste fechado da Google Play ou TestFlight assim que seu lote for liberado.',
      submitAnother: 'Enviar outra inscrição',
      exploreWeb: 'Explorar Plataforma Web',
      errFillFields: 'Por favor, preencha todos os campos obrigatórios.',
      errInvalidEmail: 'Por favor, informe um endereço de e-mail válido.',
      errGeneral: 'Não foi possível enviar a inscrição. Verifique sua conexão ou fale conosco no GitHub.'
    },
    footerNote: {
      text: 'Tem curiosidade sobre a arquitetura do aplicativo?',
      link: 'Conheça o código-fonte em Flutter no GitHub'
    }
  },
  'eo': {
    meta: {
      title: 'Aliĝu al la Fermita Testado de la Poŝaplikaĵo — Bona Loko',
      desc: 'Partoprenu en la komunumo de fermita testado por la poŝtelefono Bona Loko por Android (Google Play) kaj iOS (TestFlight). Helpu konstrui etikan ilon por kutimoj.'
    },
    hero: {
      badge: 'Frua Aliro & Komunuma Testado',
      title: 'Aliĝu al la Fermita Testado de la Aplikaĵo',
      intro: 'Bona Loko prepariĝas por sia oficiala eldono en Google Play Store kaj Apple App Store. Ni invitas amikojn el la komunumo testi fruajn eldonojn, sperti nian senretan kutim-spurilon kaj helpi certigi la stabilecon de la sistemo.'
    },
    process: {
      tag: 'Kiel Ĝi Funkcias',
      title: 'La Procezo de Fermita Testado',
      desc: 'Google Play postulas 20 dediĉitajn testantojn uzantajn la apon seninterrompe dum 14 tagoj antaŭ la publika eldono. Jen kiel vi povas helpi nin:',
      step1Title: 'Sendu Vian Butikan Retpoŝton',
      step1Desc: 'Plenigu la suban formularon per la retadreso de via Google Play aŭ Apple ID konto uzata en via telefono.',
      step2Title: 'Ricevu Vian Invitan Ligilon',
      step2Desc: 'Ni aldonos vian retadreson en Google Play Console aŭ TestFlight kaj sendos rektan ligilon por akcepti la teston.',
      step3Title: 'Instalu kaj Praktiku Ĉiutage',
      step3Desc: 'Elŝutu la apon, spurigu viajn kutimojn kaj viv-areojn kun plena senreta privateco kaj dividu viajn rimarkojn.'
    },
    form: {
      heading: 'Aliĝilo por Testantoj',
      subheading: 'Bonvolu provizi viajn detalojn sube. Ni traktas viajn informojn kun plena konfidenco.',
      nameLabel: 'Via Nomo',
      namePlaceholder: 'ekz. Karolo Piĉ',
      emailLabel: 'Butika Retpoŝto (Google Play aŭ Apple ID)',
      emailPlaceholder: 'ekz. karolo@gmail.com aŭ karolo@icloud.com',
      emailHint: 'Devas kongrui kun la konto uzata en via Google Play aŭ App Store.',
      platformLabel: 'Testa Platformo',
      platformHint: 'Elektu kiun operaciumon vi uzos por testi.',
      optAndroid: 'Android (Google Play Fermita Testado)',
      optIos: 'iOS (Apple TestFlight)',
      optBoth: 'Ambaŭ (Android kaj iOS)',
      deviceLabel: 'Aparata Modelo & OS-Versio (Laŭvola)',
      devicePlaceholder: 'ekz. Samsung Galaxy S23 (Android 14) aŭ iPhone 14 (iOS 17)',
      deviceHint: 'Helpas nin certigi larĝan kongruecon.',
      notesLabel: 'Rimarkoj aŭ Kutimaj Celoj (Laŭvola)',
      notesPlaceholder: 'Dividu kiujn viv-areojn vi plej deziras plibonigi aŭ viajn pensojn pri kutimoj...',
      notesHint: 'Kunteksto pri via intenco uzi la aplikaĵon.',
      submitBtn: 'Sendi Testan Aliĝon',
      submittingBtn: 'Sendante Aliĝon...',
      privacyGuarantee: 'Via retpoŝto estos uzata nur por sendi la oficialan butikan inviton. Ni neniam vendos datumojn aŭ sendos reklamojn.',
      successTitle: 'Aliĝo Ricevita kun Dankemo!',
      successDesc: 'Dankegon pro via volontula helpo por testi Bona Loko. Via aliĝo estis sendita rekte al la programista teamo.',
      successNextLabel: 'Kio sekvas:',
      successNextText: 'Vi ricevos oficialan invitan ligilon por aliĝi al la fermita testa trako en Google Play aŭ TestFlight tuj kiam via grupo estos aldonita.',
      submitAnother: 'Sendi alian aliĝon',
      exploreWeb: 'Esplori Retan Platformon',
      errFillFields: 'Bonvolu plenigi ĉiujn devigajn kampojn.',
      errInvalidEmail: 'Bonvolu provizi validan retpoŝtan adreson.',
      errGeneral: 'Malsukcesis sendi la aliĝon. Bonvolu kontroli vian retkonekton aŭ kontakti nin ĉe GitHub.'
    },
    footerNote: {
      text: 'Ĉu vi volas vidi kiel la aplikaĵo estas konstruita?',
      link: 'Esploru nian malfermfontan Flutter-kodujon ĉe GitHub'
    }
  }
}

const { t } = useComponentI18n(testingTranslations)

useHead({
  title: computed(() => t('meta.title')),
  meta: [
    {
      name: 'description',
      content: computed(() => t('meta.desc'))
    },
    {
      property: 'og:title',
      content: computed(() => t('meta.title'))
    },
    {
      property: 'og:description',
      content: computed(() => t('meta.desc'))
    }
  ]
})

// Form State Management
const formData = reactive({
  name: '',
  email: '',
  platform: 'android',
  deviceModel: '',
  notes: '',
  honeypot: ''
})

const isSubmitting = ref(false)
const submissionState = ref<'idle' | 'success'>('idle')
const errorMessage = ref('')

const validateForm = (): boolean => {
  errorMessage.value = ''

  if (!formData.name.trim()) {
    errorMessage.value = t('form.errFillFields')
    return false
  }

  if (!formData.email.trim() || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(formData.email.trim())) {
    errorMessage.value = t('form.errInvalidEmail')
    return false
  }

  return true
}

const handleSubmit = async () => {
  if (!validateForm()) return

  isSubmitting.value = true
  errorMessage.value = ''

  try {
    const response = await $fetch('/api/closed-testing', {
      method: 'POST',
      body: {
        name: formData.name,
        email: formData.email,
        platform: formData.platform,
        deviceModel: formData.deviceModel,
        notes: formData.notes,
        honeypot: formData.honeypot
      }
    })

    if (response && response.success) {
      submissionState.value = 'success'
    } else {
      errorMessage.value = t('form.errGeneral')
    }
  } catch (err: any) {
    console.error('[Closed Testing Submit Error]:', err)
    errorMessage.value = err?.data?.statusMessage || t('form.errGeneral')
  } finally {
    isSubmitting.value = false
  }
}

const resetForm = () => {
  formData.name = ''
  formData.email = ''
  formData.platform = 'android'
  formData.deviceModel = ''
  formData.notes = ''
  formData.honeypot = ''
  errorMessage.value = ''
  submissionState.value = 'idle'
}
</script>

<style scoped>
.testing-hero {
  padding: 4.5rem 1.5rem 3rem 1.5rem;
}

.badge-beta {
  display: inline-flex;
  align-items: center;
  gap: 0.4rem;
  padding: 0.35rem 0.85rem;
  background-color: var(--primary-light);
  border: 1px solid var(--primary-border);
  border-radius: var(--radius-pill);
  font-size: 0.82rem;
  font-weight: 700;
  color: var(--primary-dark);
  margin-bottom: 1.25rem;
}

.hero-intro {
  font-size: 1.15rem;
  line-height: 1.7;
  color: var(--text-secondary);
  max-width: 680px;
  margin: 1.25rem auto 0 auto;
}

/* Process Section */
.testing-process-section {
  padding-top: 1rem;
  padding-bottom: 2rem;
}

.process-card {
  padding: 2.5rem 2rem;
  background: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
}

.process-tag {
  display: inline-block;
  font-size: 0.8rem;
  font-weight: 700;
  color: var(--primary);
  text-transform: uppercase;
  letter-spacing: 0.08em;
  margin-bottom: 0.4rem;
}

.process-header h2 {
  font-size: 1.5rem;
  color: var(--text-primary);
  margin: 0 0 0.5rem 0;
}

.process-desc {
  font-size: 0.98rem;
  color: var(--text-secondary);
  max-width: 620px;
  margin: 0 auto 2.25rem auto;
  line-height: 1.6;
}

.steps-grid {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 1.75rem;
}

.step-item {
  display: flex;
  flex-direction: column;
  align-items: center;
  text-align: center;
  padding: 1.25rem 1rem;
  background: var(--bg-primary);
  border-radius: var(--radius-md);
  border: 1px solid var(--border-subtle);
}

.step-number {
  width: 44px;
  height: 44px;
  border-radius: 50%;
  background-color: var(--primary-light);
  color: var(--primary-dark);
  font-weight: 800;
  font-size: 1.2rem;
  display: flex;
  align-items: center;
  justify-content: center;
  margin-bottom: 1rem;
}

.step-content h4 {
  font-size: 1.05rem;
  color: var(--text-primary);
  margin: 0 0 0.5rem 0;
}

.step-content p {
  font-size: 0.88rem;
  line-height: 1.5;
  color: var(--text-secondary);
  margin: 0;
}

/* Form Section */
.form-section {
  padding-top: 1rem;
  padding-bottom: 4rem;
}

.form-card {
  padding: 2.75rem 2.5rem;
  background: var(--bg-surface);
  border: 1px solid var(--border-color);
  border-radius: var(--radius-lg);
  box-shadow: var(--shadow-sm);
}

.form-header {
  margin-bottom: 2rem;
}

.form-header h3 {
  font-size: 1.4rem;
  color: var(--text-primary);
  margin-bottom: 0.5rem;
}

.form-header p {
  font-size: 0.95rem;
  color: var(--text-secondary);
  margin: 0;
}

.honeypot-field {
  display: none !important;
  visibility: hidden;
}

.form-error-banner {
  padding: 0.85rem 1.25rem;
  background-color: #fee2e2;
  border: 1px solid #f87171;
  border-radius: var(--radius-sm);
  color: #991b1b;
  font-size: 0.92rem;
  font-weight: 600;
  margin-bottom: 1.5rem;
}

.form-row {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 1.5rem;
  margin-bottom: 1.25rem;
}

.form-group {
  display: flex;
  flex-direction: column;
  margin-bottom: 1.25rem;
}

.form-label {
  font-size: 0.9rem;
  font-weight: 600;
  color: var(--text-primary);
  margin-bottom: 0.4rem;
}

.required-star {
  color: #dc2626;
}

.form-input,
.form-select,
.form-textarea {
  width: 100%;
  padding: 0.75rem 1rem;
  font-size: 0.95rem;
  font-family: inherit;
  border: 1px solid var(--border-color);
  border-radius: var(--radius-sm);
  background-color: #ffffff;
  color: var(--text-primary);
  transition: border-color var(--transition-fast), box-shadow var(--transition-fast);
}

.form-input:focus,
.form-select:focus,
.form-textarea:focus {
  outline: none;
  border-color: var(--primary);
  box-shadow: 0 0 0 3px var(--primary-light);
}

.form-input:disabled,
.form-select:disabled,
.form-textarea:disabled {
  background-color: #f3f4f6;
  cursor: not-allowed;
  opacity: 0.75;
}

.field-hint {
  font-size: 0.78rem;
  color: var(--text-muted);
  margin-top: 0.35rem;
}

.form-actions {
  margin-top: 2rem;
}

.submit-btn {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: 0.6rem;
  min-width: 240px;
  font-weight: 700;
}

.loading-spinner {
  width: 16px;
  height: 16px;
  border: 2px solid rgba(255, 255, 255, 0.4);
  border-top-color: #ffffff;
  border-radius: 50%;
  animation: spin 0.8s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

.privacy-note {
  font-size: 0.82rem;
  color: var(--text-muted);
  line-height: 1.5;
  max-width: 520px;
  margin: 1rem auto 0 auto;
}

/* Success View */
.submission-success {
  padding: 2.5rem 1rem;
}

.success-icon-wrapper {
  width: 64px;
  height: 64px;
  border-radius: 50%;
  background-color: var(--primary-light);
  color: var(--primary-dark);
  font-size: 2rem;
  font-weight: bold;
  display: flex;
  align-items: center;
  justify-content: center;
  margin: 0 auto 1.5rem auto;
}

.success-title {
  font-size: 1.5rem;
  color: var(--text-primary);
  margin-bottom: 0.75rem;
}

.success-desc {
  font-size: 1.05rem;
  color: var(--text-secondary);
  line-height: 1.6;
  max-width: 540px;
  margin: 0 auto 1.5rem auto;
}

.success-info-box {
  background-color: var(--bg-primary);
  border: 1px solid var(--border-subtle);
  border-radius: var(--radius-md);
  padding: 1.25rem 1.5rem;
  max-width: 540px;
  margin: 0 auto 2rem auto;
  text-align: left;
}

.success-info-box p {
  margin: 0;
  font-size: 0.92rem;
  line-height: 1.5;
  color: var(--text-secondary);
}

.success-info-box strong {
  display: block;
  color: var(--text-primary);
  margin-bottom: 0.25rem;
}

.success-actions {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1rem;
  flex-wrap: wrap;
}

.open-source-note {
  margin-top: 2rem;
  font-size: 0.92rem;
  color: var(--text-muted);
}

.link-inline {
  color: var(--primary);
  font-weight: 600;
  text-decoration: underline;
  text-underline-offset: 3px;
}

/* Responsive */
@media (max-width: 768px) {
  .steps-grid {
    grid-template-columns: 1fr;
    gap: 1.25rem;
  }

  .form-row {
    grid-template-columns: 1fr;
    gap: 0;
  }

  .form-card {
    padding: 2rem 1.5rem;
  }
}
</style>
