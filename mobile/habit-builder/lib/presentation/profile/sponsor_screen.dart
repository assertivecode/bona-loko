import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

/// Screen encouraging and guiding voluntary sponsorship via GitHub Sponsors.
/// Aligned strictly with Rule 4 of the Platform Foundation (Incorruptibility & Unconditional Giving).
class SponsorScreen extends StatelessWidget {
  const SponsorScreen({super.key});

  static const String sponsorUrl = 'https://github.com/sponsors/assertivecode';

  Future<void> _launchSponsorUrl(BuildContext context) async {
    final uri = Uri.parse(sponsorUrl);
    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      } else if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open sponsorship page.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    } catch (_) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Could not open sponsorship page.'),
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n?.supportBonaLokoTitle ?? 'Support Bona Loko',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 20.0),
          children: [
            // Hero Icon & Title
            Center(
              child: Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  color: const Color(0xFFFDE8E8),
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withOpacity(0.08),
                      blurRadius: 16,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.favorite_rounded,
                  color: Color(0xFFE02424),
                  size: 38,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                l10n?.supportBonaLokoTitle ?? 'Support Bona Loko',
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                l10n?.supportBonaLokoSubtitle ?? 'Open source, privacy-first, and uncorruptible',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),

            // Narrative Hero Card
            Card(
              elevation: 0,
              color: theme.colorScheme.surfaceVariant.withOpacity(0.35),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  l10n?.sponsorHeroDescription ??
                      'Bona Loko is an open-source personal development platform. We do not sell data, display ads, or accept corporate endorsements. Voluntary sponsorships on GitHub directly empower our software development and trilingual resources.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    height: 1.6,
                    color: theme.colorScheme.onSurface,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            const SizedBox(height: 28),

            // Impact Pillars Section Title
            Text(
              l10n?.sponsorPillarsTitle ?? 'Why Your Support Matters',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 14),

            // Pillar 1: Privacy
            _buildPillarTile(
              context,
              icon: Icons.lock_outline_rounded,
              iconColor: const Color(0xFF0E9F6E),
              iconBgColor: const Color(0xFFDEF7EC),
              title: l10n?.sponsorPillar1Title ?? '100% Ad-Free & Privacy First',
              desc: l10n?.sponsorPillar1Desc ??
                  'No behavior trackers or analytics brokers. Your personal reflections remain strictly yours.',
            ),
            const SizedBox(height: 12),

            // Pillar 2: Uncorruptibility
            _buildPillarTile(
              context,
              icon: Icons.shield_outlined,
              iconColor: const Color(0xFF3F83F8),
              iconBgColor: const Color(0xFFE1EFFE),
              title: l10n?.sponsorPillar2Title ?? 'Independent & Uncorruptible',
              desc: l10n?.sponsorPillar2Desc ??
                  'Guided by our Moral Constitution (Rule 4: Zero quid-pro-quo or commercial favoritism).',
            ),
            const SizedBox(height: 12),

            // Pillar 3: Trilingual
            _buildPillarTile(
              context,
              icon: Icons.translate_rounded,
              iconColor: const Color(0xFF9061F9),
              iconBgColor: const Color(0xFFEDEBFE),
              title: l10n?.sponsorPillar3Title ?? 'Trilingual & Open Source',
              desc: l10n?.sponsorPillar3Desc ??
                  'Transparent code, accessible everywhere in English, Portuguese, and Esperanto.',
            ),
            const SizedBox(height: 32),

            // Primary Action Button (GitHub Sponsors)
            ElevatedButton(
              key: const Key('sponsor_github_button'),
              onPressed: () => _launchSponsorUrl(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFDB2777),
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 18.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                elevation: 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.favorite_rounded, size: 20),
                  const SizedBox(width: 10),
                  Text(
                    l10n?.sponsorGithubButton ?? 'Sponsor on GitHub',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.2,
                    ),
                  ),
                  const SizedBox(width: 6),
                  const Icon(Icons.open_in_new_rounded, size: 16),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Rule 4 Incorruptibility Disclaimer Box
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceVariant.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12.0),
                border: Border.all(
                  color: theme.colorScheme.outlineVariant.withOpacity(0.4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        size: 16,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        l10n?.sponsorDisclaimerTitle ?? 'Rule 4: Unconditional Giving',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n?.sponsorDisclaimerDesc ??
                        'All sponsorships are treated as unconditional gifts for community flourishing. Contributions confer zero commercial perks or governance leverage.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      height: 1.5,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPillarTile(
    BuildContext context, {
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String desc,
  }) {
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: iconBgColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  desc,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.45,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
