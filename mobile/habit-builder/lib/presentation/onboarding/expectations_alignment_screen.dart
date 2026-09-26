import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/local/tables/users_table.dart';
import 'user_controller.dart';

/// Screen presented to the user during first-run onboarding immediately after language selection.
///
/// Aligns expectations regarding:
/// 1. Faith in small compounding changes over time (even sporadic steps represent progress).
/// 2. Measured, sustainable pace (not a high-pressure, rapid-output productivity tool).
/// 3. The importance of nurturing calm (with a localized external article link).
/// 4. Overview of the next steps ahead (assessment, prioritized habits, daily habits, reflections).
class ExpectationsAlignmentScreen extends ConsumerWidget {
  const ExpectationsAlignmentScreen({super.key});

  /// Resolves the canonical URL for the article on Nurturing Calm based on the active language.
  static String getCalmArticleUrl(AppLanguage language) {
    switch (language) {
      case AppLanguage.portuguese:
        return 'https://bonaloko.com/pt-br/pensamentos-e-reflexoes/a-importancia-de-cultivar-a-calma';
      case AppLanguage.esperanto:
        return 'https://bonaloko.com/eo/pensoj-kaj-reflektoj/la-graveco-de-flegi-trankvilon';
      case AppLanguage.english:
      default:
        return 'https://bonaloko.com/thoughts-and-reflections/the-importance-of-nurturing-calm';
    }
  }

  Future<void> _launchArticle(BuildContext context, AppLanguage language) async {
    final url = Uri.parse(getCalmArticleUrl(language));
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      // Graceful fallback for headless or restricted testing environments
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final userState = ref.watch(userControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/horizontal-logo.png',
          height: 30,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Text(
            l10n?.appTitle ?? 'Bona Loko',
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: CustomScrollView(
          key: const Key('expectations_scroll_view'),
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Title & Subtitle Header
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.balance_outlined,
                          size: 36,
                          color: theme.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      l10n?.expectationsScreenTitle ?? 'Aligning Expectations',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      l10n?.expectationsScreenSubtitle ??
                          'A thoughtful approach to life balance and daily habits',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 28),

                    // Section 1: Philosophy
                    _buildSectionHeader(
                      context,
                      title: l10n?.philosophySectionTitle ?? 'Our Core Philosophy',
                      icon: Icons.lightbulb_outline,
                    ),
                    const SizedBox(height: 12),

                    // Card 1: Faith in small changes
                    _buildExpectationCard(
                      context,
                      key: const Key('card_faith_in_small_changes'),
                      icon: Icons.auto_awesome_outlined,
                      title: l10n?.faithInSmallChangesTitle ?? 'Faith in Small Changes',
                      description: l10n?.faithInSmallChangesDesc ??
                          'This app is designed for people with faith that small, mindful changes compound into immense transformation over time. Even when you are not fully consistent, every step already taken represents genuine progress.',
                    ),
                    const SizedBox(height: 14),

                    // Card 2: Sustainable pace
                    _buildExpectationCard(
                      context,
                      key: const Key('card_sustainable_pace'),
                      icon: Icons.hourglass_bottom_outlined,
                      title: l10n?.sustainablePaceTitle ?? 'A Measured, Sustainable Pace',
                      description: l10n?.sustainablePaceDesc ??
                          'While we aim to increase focus and reduce unhealthy distractions, this is not a high-pressure productivity tool. Real, solid growth takes root when given the time it genuinely requires, without hurried expectations.',
                    ),
                    const SizedBox(height: 14),

                    // Card 3: Nurturing calm with link
                    _buildCalmRecommendationCard(
                      context,
                      userState.selectedLanguage,
                      l10n,
                      () => _launchArticle(context, userState.selectedLanguage),
                    ),
                    const SizedBox(height: 32),

                    // Section 2: Next Steps
                    _buildSectionHeader(
                      context,
                      title: l10n?.nextStepsSectionTitle ?? 'What to Expect Next',
                      icon: Icons.alt_route_outlined,
                    ),
                    const SizedBox(height: 12),

                    // Step 1: Assessment
                    _buildStepCard(
                      context,
                      key: const Key('step_card_assessment'),
                      stepNumber: '1',
                      title: l10n?.nextStep1Title ?? '1. Calm Life Areas Assessment',
                      description: l10n?.nextStep1Desc ??
                          'Take the necessary time to properly reflect and evaluate each of the 12 areas of your life at your present season.',
                    ),
                    const SizedBox(height: 12),

                    // Step 2: Habit suggestions
                    _buildStepCard(
                      context,
                      key: const Key('step_card_habits'),
                      stepNumber: '2',
                      title: l10n?.nextStep2Title ?? '2. Prioritized Habit Suggestions',
                      description: l10n?.nextStep2Desc ??
                          'The app will organize and recommend habits based on your personal priorities and identified priority gaps.',
                    ),
                    const SizedBox(height: 12),

                    // Step 3: Choose daily habits
                    _buildStepCard(
                      context,
                      key: const Key('step_card_daily_habits'),
                      stepNumber: '3',
                      title: l10n?.nextStep3Title ?? '3. Choose Daily Habits',
                      description: l10n?.nextStep3Desc ??
                          'Select habits to cultivate daily. If you already practice positive habits, select them too to keep a holistic overview of your rhythms.',
                    ),
                    const SizedBox(height: 12),

                    // Step 4: Reflections
                    _buildStepCard(
                      context,
                      key: const Key('step_card_reflections'),
                      stepNumber: '4',
                      title: l10n?.nextStep4Title ?? '4. Reflect at Your Own Pace',
                      description: l10n?.nextStep4Desc ??
                          'Pick reflections to think about whenever you have space, reaching your own conclusions with complete personal autonomy.',
                    ),
                    const SizedBox(height: 36),

                    // Bottom CTA: Start Assessment
                    FilledButton.icon(
                      key: const Key('start_assessment_button'),
                      onPressed: () {
                        ref.read(userControllerProvider.notifier).setProfileConfigured(true);
                        if (Navigator.of(context).canPop()) {
                          Navigator.of(context).pop();
                        }
                      },
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward),
                      label: Text(
                        l10n?.startAssessment ?? 'Start Assessment',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, {required String title, required IconData icon}) {
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(icon, size: 20, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  Widget _buildExpectationCard(
    BuildContext context, {
    Key? key,
    required IconData icon,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    return Container(
      key: key,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.5),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withOpacity(0.6),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(icon, size: 22, color: theme.colorScheme.primary),
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
                const SizedBox(height: 6),
                Text(
                  description,
                  style: theme.textTheme.bodyMedium?.copyWith(
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

  Widget _buildCalmRecommendationCard(
    BuildContext context,
    AppLanguage language,
    AppLocalizations? l10n,
    VoidCallback onReadArticle,
  ) {
    final theme = Theme.of(context);
    return Container(
      key: const Key('card_nurturing_calm'),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer.withOpacity(0.25),
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.25),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: const Icon(Icons.water_drop_outlined, size: 22, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.nurturingCalmTitle ?? 'The Importance of Nurturing Calm',
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n?.nurturingCalmDesc ??
                          'An unhurried mind sees long-term horizons clearly. We warmly recommend reading our article exploring why calm is the foundation of durable life balance.',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.45,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Align(
            alignment: Alignment.centerRight,
            child: OutlinedButton.icon(
              key: const Key('read_calm_article_button'),
              onPressed: onReadArticle,
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
              ),
              icon: const Icon(Icons.open_in_new, size: 16),
              label: Text(
                l10n?.readArticleAction ?? 'Read Article Online',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStepCard(
    BuildContext context, {
    Key? key,
    required String stepNumber,
    required String title,
    required String description,
  }) {
    final theme = Theme.of(context);
    return Container(
      key: key,
      padding: const EdgeInsets.all(14.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.4),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 14,
            backgroundColor: theme.colorScheme.secondaryContainer,
            child: Text(
              stepNumber,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSecondaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                    height: 1.4,
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
