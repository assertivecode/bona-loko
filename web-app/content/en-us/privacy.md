---
id: privacy_policy
title: "Privacy Policy & Data Sovereignty"
slug: "privacy"
last_updated: "2026-09-24"
summary: "Understand how Bona Loko respects user sovereignty with zero direct data collection, and how infrastructure services like Cloudflare and Google process generic technical information."
---

# Privacy Policy & Data Sovereignty

> *"True personal transformation requires peace of mind and uncompromised independence. Bona Loko is architected from the ground up to respect human attention, private reflection, and personal sovereignty."*

**Effective Date:** September 24, 2026  
**Applicability:** Bona Loko Web Application ([bonaloko.com](https://bonaloko.com)) & Bona Loko Mobile Application.

---

## 1. Foundational Commitment: Zero Direct Data Collection

Bona Loko operates on a **zero-knowledge, local-first architecture**. Whether using the web platform or the mobile application:

- **We do not collect, request, or store your personal information.**
- **No account registration:** You do not need to provide a name, email address, password, phone number, or social login to access the platform.
- **No user database:** Bona Loko does not operate a centralized backend server or cloud database storing your personal profiles, scores, journal entries, or habits.

### Local-Only Data Storage
- **Web Application:** All life area assessments, priority gap evaluations, focus notes, and interface preferences remain stored locally on your device using HTML5 `localStorage` and browser cookies dedicated exclusively to language choice (`bona_loko_locale`).
- **Mobile Application:** All habit streaks, gratitude reflections, workout routines, and personal financial management entries are stored entirely in a local SQLite database (using the Drift engine) on your mobile device. They are never synchronized to external servers or transmitted to Bona Loko.

---

## 2. Third-Party Infrastructure & Analytics

While Bona Loko directly collects zero user data, visiting the web application necessarily involves communication with edge hosting and measurement infrastructure. We believe in full transparency regarding how these third-party providers operate.

### Summary: Generic Information vs. Personal Information

| Service | Primary Role | Information Type | Classification | Purpose |
| :--- | :--- | :--- | :--- | :--- |
| **Cloudflare** | Edge Hosting, CDN & DDoS Shield | Technical network headers, IP address, user-agent, TLS cipher, request URL, timestamp | **Generic Technical Information** *(Pseudonymous IP processed at network layer)* | Delivering web assets globally, mitigating malicious cyberattacks, preventing bots |
| **Google Analytics (GA4)** | Aggregated Web Telemetry | Page views, session duration, device type, browser, approximate region/city, referral source | **Generic Aggregated Metrics** *(No personal identifiers)* | Understanding which guides are helpful, monitoring performance and broken links |
| **Google Search** | Search Engine Discovery | Search queries and clicks on Google Search results pages | **External Generic Metrics** | Helping individuals find life balance guidance via search indexing |

---

## 3. Cloudflare Hosting & Edge Delivery

The web application is hosted on and distributed through **Cloudflare Pages & Workers** (Cloudflare, Inc.).

### What Information Is Processed:
When you request a page from our site, Cloudflare's global edge network receives:
- **IP Address:** Needed to route the web page packets to your device.
- **Technical Request Headers:** Operating system, browser user-agent, requested URL, language header, and screen hints.
- **Security Telemetry:** Detection of automated bots, scraping, and Distributed Denial of Service (DDoS) traffic patterns.

### Personal vs. Generic Distinction:
- **Generic Data:** Browser types, request durations, cache hit ratios, and operating systems are strictly generic technical metrics.
- **IP Addresses:** While IP addresses are classified as pseudonymous personal data under certain regulations (such as GDPR and LGPD), Cloudflare uses them solely for network routing, security filtering, and threat mitigation. Cloudflare does not sell this data, and Bona Loko has no access to link any IP address to an individual person's identity.

Cloudflare complies with international data transfer frameworks. For more details, consult [Cloudflare's Privacy Policy](https://www.cloudflare.com/privacypolicy/).

---

## 4. Google Analytics & Google Search

The web application utilizes **Google Analytics (GA4)** to measure overall platform engagement and improve didactic content.

### What Information Is Collected:
Google Analytics collects generic, aggregated interaction data:
- **Browsing Telemetry:** Pages visited, duration of visit, scroll milestones, and external outbound link clicks.
- **Device & Environment:** Device category (mobile, desktop, tablet), screen resolution, browser family, and operating system.
- **Geographic Aggregation:** Country and city-level estimation derived from masked IP addresses.

### Personal vs. Generic Distinction:
- **Strictly Generic & Anonymized:** GA4 automatically masks IP addresses by default and does not log individual IP addresses.
- **Zero Sensitive Data Transmitted:** Bona Loko never sends user input, priority ratings, reflections, or habit notes to Google Analytics.
- **No Cross-Device Advertising Profiling:** We do not activate Google Signals, advertising remarketing features, or personalized advertising identifiers.

### Google Search
Our web pages are indexed publicly on Google Search. Queries entered on Google's search engine are governed by [Google's Privacy Policy](https://policies.google.com/privacy). Bona Loko receives only high-level, aggregate statistics (e.g., total clicks and impressions per page) via Google Search Console.

---

## 5. Cookies & Local Storage Controls

Bona Loko uses minimal, necessary browser storage:

1. **Functional Cookie (`bona_loko_locale`):** Stores your selected language preference (`en-US`, `pt-BR`, or `eo`) to ensure consistent display.
2. **Local Storage (`localStorage`):** Retains your life balance self-assessment scores locally in your browser.
3. **Analytics Cookies (`_ga`, `_ga_*`):** Set by Google Analytics to distinguish unique browsing sessions over time.

### How to Exercise Control:
- **Clear Browser Storage:** You can clear cookies and local storage at any time via your browser settings. Doing so immediately resets all locally saved life area assessments.
- **Do Not Track (DNT) / GPC:** You can enable Global Privacy Control or Do Not Track in your browser.
- **Analytics Opt-Out:** You can install the official [Google Analytics Opt-out Browser Add-on](https://tools.google.com/dlpage/gaoptout) or use privacy-focused content blockers.

---

## 6. Mobile Application Privacy Specifics

The Bona Loko mobile application (Habit Builder) adheres to an even stricter boundary:
- **100% Offline Operation:** All data (habits, life priorities, gratitude notes, physical activity records, and financial entries) are stored in an encrypted/local SQLite database on your physical device.
- **No Third-Party SDKs or Ad Networks:** The mobile application contains no advertising SDKs, tracking libraries, or background location trackers.
- **Full Data Deletion:** Deleting a habit, a transaction, or uninstalling the mobile application permanently removes all corresponding data from your device immediately.

---

## 7. Children's Privacy (COPPA & GDPR-K Compliance)

Bona Loko does not knowingly solicit or collect data from children under the age of 13 (or under 16 in the European Union). Because our platform requires no registration and stores information locally on the user's device, no personal child profiles are ever created or retained on our infrastructure.

---

## 8. Updates to this Policy

As the platform evolves, this document may be updated to reflect changes in infrastructure or regulatory requirements. Any adjustments will be posted with an updated "Effective Date" at the top of this page.

---

## 9. Contact & Stewardship

Bona Loko is maintained as an open-source, moral-first personal development initiative. If you have questions about our technical privacy architecture, you are welcome to inspect our open-source codebase or reach out:

- **Source Code Repository:** [github.com/assertivecode/bona-loko](https://github.com/assertivecode/bona-loko)
- **Moral Constitution:** [FOUNDATION.md](https://github.com/assertivecode/bona-loko/blob/main/FOUNDATION.md)
