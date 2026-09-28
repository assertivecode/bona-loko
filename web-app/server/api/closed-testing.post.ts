import { defineEventHandler, readBody, createError } from 'h3'

export default defineEventHandler(async (event) => {
  const config = useRuntimeConfig()
  const body = await readBody(event)

  const { name, email, platform, deviceModel, notes, honeypot } = body || {}

  // 1. Bot honeypot trap: silently return success if bots fill the hidden field
  if (honeypot) {
    return { success: true }
  }

  // 2. Validate required inputs
  if (!name || typeof name !== 'string' || name.trim().length === 0) {
    throw createError({
      statusCode: 400,
      statusMessage: 'Name is required'
    })
  }

  if (!email || typeof email !== 'string' || !/^[^\s@]+@[^\s@]+\.[^\s@]+$/.test(email.trim())) {
    throw createError({
      statusCode: 400,
      statusMessage: 'A valid email address (Google Play or Apple ID) is required'
    })
  }

  const validPlatforms = ['android', 'ios', 'both']
  const normalizedPlatform = typeof platform === 'string' ? platform.trim().toLowerCase() : 'android'
  const selectedPlatform = validPlatforms.includes(normalizedPlatform) ? normalizedPlatform : 'android'

  const platformLabels: Record<string, string> = {
    android: 'Android (Google Play Closed Testing)',
    ios: 'iOS (Apple TestFlight)',
    both: 'Both (Android & iOS)'
  }

  const platformDisplay = platformLabels[selectedPlatform] || 'Android'
  const userName = name.trim()
  const userEmail = email.trim()
  const userDevice = typeof deviceModel === 'string' ? deviceModel.trim() : ''
  const userNotes = typeof notes === 'string' ? notes.trim() : ''
  const destinationEmail = (config.contactEmail as string) || 'assertivecode@gmail.com'

  const emailSubject = `[Bona Loko Tester Application] ${platformDisplay.split(' ')[0]} - ${userName}`
  const timestamp = new Date().toUTCString()

  const emailBodyText = `New Mobile App Closed Testing Application received via bonaloko.com

Applicant: ${userName}
Email (Store Account): ${userEmail}
Testing Platform: ${platformDisplay}
Device Model: ${userDevice || 'Not specified'}
Received: ${timestamp}

Applicant Notes / Focus Areas:
----------------------------------------
${userNotes || 'No additional notes provided.'}
----------------------------------------

Next Steps for Administrator:
1. For Android: Add ${userEmail} to the Google Play Console Closed Testing email list.
2. For iOS: Add ${userEmail} to the Apple App Store Connect / TestFlight internal/external group.
3. Reply directly to this email if any setup instructions or greeting need to be sent to ${userName}.
`

  const emailBodyHtml = `
    <div style="font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif; max-width: 620px; margin: 0 auto; padding: 28px; background-color: #ffffff; border: 1px solid #e2e8f0; border-radius: 8px;">
      <div style="border-bottom: 2px solid #059669; padding-bottom: 16px; margin-bottom: 20px;">
        <h2 style="color: #064e3b; margin: 0; font-size: 20px;">📱 New Closed Testing Application</h2>
        <span style="font-size: 13px; color: #059669; font-weight: 600;">Bona Loko — Habit & Life Balance</span>
      </div>
      
      <table style="width: 100%; border-collapse: collapse; margin-bottom: 24px; font-size: 14px;">
        <tr>
          <td style="padding: 8px 0; color: #64748b; width: 150px;"><strong>Applicant Name:</strong></td>
          <td style="padding: 8px 0; color: #0f172a; font-weight: 600;">${userName}</td>
        </tr>
        <tr>
          <td style="padding: 8px 0; color: #64748b;"><strong>Store Email:</strong></td>
          <td style="padding: 8px 0; color: #0f172a; font-weight: 600;">
            <a href="mailto:${userEmail}" style="color: #059669; text-decoration: none;">${userEmail}</a>
          </td>
        </tr>
        <tr>
          <td style="padding: 8px 0; color: #64748b;"><strong>Target Platform:</strong></td>
          <td style="padding: 8px 0; color: #0f172a; font-weight: 500;">
            <span style="display: inline-block; padding: 2px 10px; background-color: #ecfdf5; color: #065f46; border-radius: 12px; font-weight: 600; font-size: 12px;">
              ${platformDisplay}
            </span>
          </td>
        </tr>
        <tr>
          <td style="padding: 8px 0; color: #64748b;"><strong>Device Info:</strong></td>
          <td style="padding: 8px 0; color: #0f172a; font-weight: 500;">${userDevice || '<em>Not specified</em>'}</td>
        </tr>
        <tr>
          <td style="padding: 8px 0; color: #64748b;"><strong>Received:</strong></td>
          <td style="padding: 8px 0; color: #64748b;">${timestamp}</td>
        </tr>
      </table>

      <div style="background-color: #f8fafc; border: 1px solid #e2e8f0; border-left: 4px solid #059669; padding: 16px; border-radius: 4px; margin-bottom: 24px;">
        <h4 style="margin-top: 0; margin-bottom: 8px; color: #334155; font-size: 12px; text-transform: uppercase; letter-spacing: 0.05em;">Applicant Notes & Motivation:</h4>
        <p style="margin: 0; color: #1e293b; font-size: 14px; line-height: 1.6; white-space: pre-wrap;">${userNotes || 'No additional notes provided.'}</p>
      </div>

      <div style="background-color: #f0fdf4; border: 1px dashed #86efac; padding: 14px; border-radius: 6px; margin-bottom: 20px; font-size: 13px; color: #166534;">
        <strong>Action Required:</strong>
        <ul style="margin: 6px 0 0 0; padding-left: 20px;">
          <li>Add <code>${userEmail}</code> to the Google Play Console Closed Testing track or Apple TestFlight.</li>
          <li>Hit <strong>Reply</strong> to respond directly to ${userName} if further instructions are needed.</li>
        </ul>
      </div>

      <div style="border-top: 1px solid #e2e8f0; padding-top: 16px; font-size: 12px; color: #94a3b8;">
        Submitted via the Closed Testing application page on <a href="https://bonaloko.assertivecode.com" style="color: #059669;">bonaloko.com</a>.
      </div>
    </div>
  `

  let sent = false
  let deliveryMethod = 'none'

  // Method 1: Resend REST API (if RESEND_API_KEY is configured in runtimeConfig)
  if (config.resendApiKey) {
    try {
      const preferredSender = (config.resendFromEmail as string) || 'Assertive Code <onboarding@resend.dev>'

      const sendViaResend = async (fromAddress: string) => {
        return await fetch('https://api.resend.com/emails', {
          method: 'POST',
          headers: {
            'Authorization': `Bearer ${config.resendApiKey}`,
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            from: fromAddress,
            to: [destinationEmail],
            reply_to: userEmail,
            subject: emailSubject,
            text: emailBodyText,
            html: emailBodyHtml
          })
        })
      }

      let res = await sendViaResend(preferredSender)

      // If domain is unverified (403), gracefully retry with verified sandbox sender
      if (!res.ok && res.status === 403 && !preferredSender.includes('onboarding@resend.dev')) {
        console.warn(`[Resend] Domain unverified for "${preferredSender}". Retrying with onboarding@resend.dev...`)
        res = await sendViaResend('Assertive Code <onboarding@resend.dev>')
      }

      if (res.ok) {
        sent = true
        deliveryMethod = 'resend'
      } else {
        const errData = await res.text()
        console.warn('[Resend API Error]:', errData)
      }
    } catch (err) {
      console.error('[Resend Exception]:', err)
    }
  } else {
    // Development fallback simulation: log payload to console when running without API key
    console.info(`[Closed Testing Local Simulation] (Set RESEND_API_KEY to send real emails):`)
    console.info(`To: ${destinationEmail}, From: ${userName} <${userEmail}>, Platform: ${platformDisplay}`)
    sent = true
    deliveryMethod = 'simulation'
  }

  if (!sent) {
    console.error(`[Closed Testing Delivery Failed] Could not deliver application from ${userName} (${userEmail})`)
    throw createError({
      statusCode: 502,
      statusMessage: 'Failed to dispatch application. Please contact us via GitHub or try again in a few moments.'
    })
  }

  console.info(`[Closed Testing Dispatched] via ${deliveryMethod} for ${userName} (${userEmail})`)

  return {
    success: true,
    message: 'Your application has been received with gratitude. We will send you an invitation as soon as the closed testing batch opens.'
  }
})
