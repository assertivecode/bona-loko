# Feature Specification: 015 - Mobile Closed Testing Application Page & Resend Email Delivery

| Metadata | Details |
| :--- | :--- |
| **Feature ID** | `feat-015` |
| **Status** | `Implemented` |
| **Component Path** | `web-app/pages/closed-testing.vue`, `web-app/server/api/closed-testing.post.ts`, `web-app/components/AppHeader.vue`, `web-app/components/AppFooter.vue` |
| **Target Release** | Mobile App Store Readiness & Closed Testing Community Recruitment |
| **Related Specs** | [FOUNDATION.md](../../../FOUNDATION.md) (Rule 4: Incorruptibility & Privacy), [specs/features/014-sponsor-and-support/spec.md](../014-sponsor-and-support/spec.md) |

---

## 1. Problem Statement & Context

### 1.1 The Context & Need
1. **Google Play Store Closed Testing Requirement**: Google Play requires new personal developer accounts to run a closed test with at least 20 opted-in testers who test the app continuously for at least 14 days before applying for production access.
2. **Apple TestFlight Testing**: Distributing early builds to iOS testers requires gathering Apple ID email addresses for TestFlight invitations.
3. **Dedicated Community Application Gateway**: Visitors who discover Bona Loko on the web and resonate with its privacy-first, 7-values philosophy need a seamless, respectful, and transparent form to apply as early testers.
4. **Resend Email Integration**: Following the proven pattern established in `assertivecode.com`, closed testing applications must be securely received by the administrator (`assertivecode@gmail.com`) using the Resend REST API (`https://api.resend.com/emails`), without exposing server credentials to the browser client.

---

## 2. Inviolable Governance Principles

- **Zero Data Commercialization**: Tester contact information (name, store email, platform) is collected exclusively for distributing Google Play Closed Testing and Apple TestFlight invitations.
- **Privacy Guarantee**: No advertising trackers or data brokers will ever touch applicant information.
- **Non-Prescriptive Tone**: The testing invitation welcomes participants with humility, clarity, and gratitude, explaining the technical necessity without coercive marketing.

---

## 3. Localization & Route Architecture

### 3.1 Canonical Slugs
| Language | Route | Slug |
| :--- | :--- | :--- |
| **English (US)** | `/closed-testing` | `closed-testing` |
| **Portuguese (Brazil)** | `/pt-br/testadores` | `testadores` |
| **Esperanto** | `/eo/testantoj` | `testantoj` |

### 3.2 In-Component Translation Invariant
In accordance with `tech-nuxt-development`, the page `web-app/pages/closed-testing.vue` must contain its own in-file dictionary supporting `en-US`, `pt-BR`, and `eo`.

---

## 4. Server-Side Resend Dispatch Contract

### Endpoint: `POST /api/closed-testing`
- **Request Body**:
  ```json
  {
    "name": "Alex Morgan",
    "email": "alex@gmail.com",
    "platform": "android",
    "deviceModel": "Pixel 7 Pro",
    "notes": "Excited to test habit tracking and local database syncing.",
    "honeypot": ""
  }
  ```
- **Validation Rules**:
  - `honeypot`: If populated, silently return `{ success: true }` to thwart bots without triggering emails.
  - `name`: Required, non-empty trimmed string.
  - `email`: Required, valid email pattern.
  - `platform`: Required (`android`, `ios`, or `both`).
  - `notes`: Optional string.
  - `deviceModel`: Optional string.
- **Dispatch Mechanism**:
  - Uses Nuxt `useRuntimeConfig()` for `resendApiKey`, `resendFromEmail`, and `contactEmail`.
  - Dispatches email via `https://api.resend.com/emails` with `reply_to: applicantEmail`.
  - Fallback support for unverified domain sending (retrying with `Assertive Code <onboarding@resend.dev>`) and graceful logging in local dev environments when `RESEND_API_KEY` is not yet configured.

---

## 5. Acceptance Criteria (Gherkin Scenarios)

### Scenario 1: Visitor Submits Closed Testing Application Successfully
```gherkin
Given a visitor visits `/closed-testing` (or `/pt-br/testadores`, `/eo/testantoj`)
When the visitor fills in their name, store email, selects a platform ("Android" or "iOS"), and clicks submit
Then the form enters a loading state with a spinner
And a POST request is dispatched to `/api/closed-testing`
And upon success, the form transitions to an encouraging thank-you view detailing next steps
And an email arrives at `assertivecode@gmail.com` with the applicant's details and reply-to set to their email.
```

### Scenario 2: Bot Honeypot Traps Automated Spam
```gherkin
Given a spam bot submitting the form with hidden honeypot field populated
When the POST request hits `/api/closed-testing`
Then the server immediately returns `{ success: true }`
And zero emails are dispatched via the Resend API.
```

### Scenario 3: Validation and Error Feedback
```gherkin
Given a visitor submitting the form with an empty name or malformed email
When they submit the form
Then client-side and server-side validation reject the submission with a clear, localized error banner
And the form fields preserve the visitor's existing input without wiping their text.
```

### Scenario 4: Trilingual Routing and Locale Consistency
```gherkin
Given a visitor switching languages while on the Closed Testing page
When switching between English, Portuguese, and Esperanto
Then the browser routes to the respective localized URL (`/closed-testing`, `/pt-br/testadores`, `/eo/testantoj`)
And all headings, form labels, placeholders, option dropdowns, and button labels update seamlessly.
```

### Scenario 5: Navigation Inclusion Across Web Application
```gherkin
Given a user navigating the web application
When viewing the header navigation or the footer platform links
Then a localized link to Closed Testing is visible and functional
And clicking routes directly to the active locale's tester page.
```
