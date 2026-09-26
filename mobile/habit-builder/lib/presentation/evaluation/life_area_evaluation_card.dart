import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/local/tables/users_table.dart';
import '../../domain/models/life_area.dart';
import 'life_area_ui_extensions.dart';

/// Centralized, reusable widget for evaluating an individual [LifeArea].
///
/// Renders:
/// 1. Area header with icon and localized title
/// 2. Short grounding description explaining what is being evaluated in that specific life area
/// 3. Score slider (0.0 to 10.0 in 0.5 step increments)
/// 4. Scoring reference guide (benchmarks 3, 6, 10) with reflective disclaimer and link to web article
/// 5. Priority selector (1 to 5, where 5 represents the highest priority to focus/practice)
/// 6. Optional action widget / button (e.g. Next / Save)
class LifeAreaEvaluationCard extends StatelessWidget {
  final LifeArea lifeArea;
  final double score;
  final int currentPriority;
  final ValueChanged<double>? onScoreChanged;
  final ValueChanged<int>? onPriorityChanged;
  final Widget? actionWidget;
  final bool showHeader;
  final AppLanguage? language;

  const LifeAreaEvaluationCard({
    super.key,
    required this.lifeArea,
    required this.score,
    required this.currentPriority,
    this.onScoreChanged,
    this.onPriorityChanged,
    this.actionWidget,
    this.showHeader = true,
    this.language,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final activeLanguage = _resolveLanguage(context);

    final String areaTitle = l10n != null ? lifeArea.localizedName(l10n) : lifeArea.key;
    final String areaDesc = l10n != null ? lifeArea.localizedDescription(l10n) : '';

    return Card(
      key: Key('evaluation_card_${lifeArea.key}'),
      elevation: 0,
      color: theme.colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant.withOpacity(0.6),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (showHeader) ...[
              // AREA HEADER: ICON + TITLE + BADGE
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(14.0),
                    ),
                    child: Icon(
                      lifeArea.icon,
                      size: 28,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          areaTitle,
                          key: Key('evaluation_title_${lifeArea.key}'),
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            letterSpacing: -0.2,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          l10n?.areaOfTotal(lifeArea.value, 12) ??
                              'Area ${lifeArea.value} of 12',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],

            // SHORT DESCRIPTION TEXT EXPLAINING WHAT IS BEING EVALUATED
            Container(
              key: Key('evaluation_description_container_${lifeArea.key}'),
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),
                borderRadius: BorderRadius.circular(14.0),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.lightbulb_outline,
                    size: 20,
                    color: theme.colorScheme.primary,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      areaDesc,
                      key: Key('evaluation_description_${lifeArea.key}'),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        height: 1.4,
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // FIELD 1: SCORE (0.0 to 10.0 in 0.5 increments)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    l10n?.scoreLabel ?? 'Current State Score',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primary.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Text(
                    '${score.toStringAsFixed(1)} / 10',
                    key: Key('score_display_${lifeArea.key}'),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: theme.colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              l10n?.scoreDescription ??
                  'Reflect on your present condition and satisfaction in this area.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                IconButton(
                  key: Key('score_decrement_${lifeArea.key}'),
                  icon: const Icon(Icons.remove_circle_outline),
                  color: theme.colorScheme.primary,
                  onPressed: onScoreChanged != null && score > 0.0
                      ? () {
                          final newScore = (score - 0.5).clamp(0.0, 10.0);
                          onScoreChanged!(double.parse(newScore.toStringAsFixed(1)));
                        }
                      : null,
                ),
                Expanded(
                  child: Slider(
                    key: Key('score_slider_${lifeArea.key}'),
                    value: score,
                    min: 0.0,
                    max: 10.0,
                    divisions: 20, // 0.5 increments
                    label: score.toStringAsFixed(1),
                    onChanged: onScoreChanged != null
                    ? (val) {
                        final snapped = (val * 2).round() / 2.0;
                        onScoreChanged!(snapped);
                      }
                    : null,
                  ),
                ),
                IconButton(
                  key: Key('score_increment_${lifeArea.key}'),
                  icon: const Icon(Icons.add_circle_outline),
                  color: theme.colorScheme.primary,
                  onPressed: onScoreChanged != null && score < 10.0
                      ? () {
                          final newScore = (score + 0.5).clamp(0.0, 10.0);
                          onScoreChanged!(double.parse(newScore.toStringAsFixed(1)));
                        }
                      : null,
                ),
              ],
            ),
            const SizedBox(height: 20),

            // FIELD 2: CURRENT PRIORITY (1 to 5, where 5 is higher priority to focus/practice)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    l10n?.priorityLabel ?? 'Priority to Focus / Practice',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _getPriorityLevelLabel(currentPriority, l10n),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: _getPriorityColor(currentPriority, theme),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              l10n?.priorityDescription ??
                  'How critical is it to allocate energy and build daily habits here? (1 = Low, 5 = Highest Focus)',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 12),
            Row(
              key: Key('priority_selector_${lifeArea.key}'),
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(5, (index) {
                final int priorityValue = index + 1;
                final bool isSelected = currentPriority == priorityValue;

                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 3.0),
                    child: InkWell(
                      key: Key('priority_button_${lifeArea.key}_$priorityValue'),
                      onTap: onPriorityChanged != null
                          ? () => onPriorityChanged!(priorityValue)
                          : null,
                      borderRadius: BorderRadius.circular(10.0),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? theme.colorScheme.primary
                              : theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: isSelected
                                ? theme.colorScheme.primary
                                : theme.colorScheme.outlineVariant.withOpacity(0.5),
                            width: isSelected ? 2.0 : 1.0,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '$priorityValue',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: isSelected
                                ? theme.colorScheme.onPrimary
                                : theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
            ),
            const SizedBox(height: 8),
            Container(
              key: Key('priority_concept_banner_${lifeArea.key}'),
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 16,
                    color: _getPriorityColor(currentPriority, theme),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      _getPriorityMeaningLabel(currentPriority, l10n),
                      key: Key('priority_meaning_${lifeArea.key}'),
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),

            // SCORING REFERENCE GUIDE (BENCHMARKS 3, 6, 10 + ARTICLE LINK)
            Container(
              key: Key('scoring_reference_guide_${lifeArea.key}'),
              padding: const EdgeInsets.all(14.0),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerLow,
                borderRadius: BorderRadius.circular(14.0),
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
                        Icons.auto_stories_outlined,
                        size: 18,
                        color: theme.colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          l10n?.scoreReferenceTitle ?? 'Scoring Reference Guide',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n?.scoreReferenceDisclaimer ??
                        'These examples are illustrative personal references, not absolute metrics. Compare your score only to your own journey and values.',
                    key: Key('score_reference_disclaimer_${lifeArea.key}'),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontStyle: FontStyle.italic,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildScoreReferenceRow(
                    context,
                    score: '3',
                    text: l10n != null ? lifeArea.scoreReference3(l10n) : '',
                    key: Key('score_reference_3_${lifeArea.key}'),
                  ),
                  const SizedBox(height: 8),
                  _buildScoreReferenceRow(
                    context,
                    score: '6',
                    text: l10n != null ? lifeArea.scoreReference6(l10n) : '',
                    key: Key('score_reference_6_${lifeArea.key}'),
                  ),
                  const SizedBox(height: 8),
                  _buildScoreReferenceRow(
                    context,
                    score: '10',
                    text: l10n != null ? lifeArea.scoreReference10(l10n) : '',
                    key: Key('score_reference_10_${lifeArea.key}'),
                  ),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton.icon(
                      key: Key('read_life_area_article_button_${lifeArea.key}'),
                      onPressed: () => _launchArticle(context, activeLanguage),
                      icon: const Icon(Icons.open_in_new, size: 15),
                      label: Text(
                        l10n?.readLifeAreaArticleAction ?? 'Read Life Area Guide',
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (actionWidget != null) ...[
              const SizedBox(height: 24),
              actionWidget!,
            ],
          ],
        ),
      ),
    );
  }

  String _getPriorityLevelLabel(int priority, AppLocalizations? l10n) {
    switch (priority) {
      case 5:
        return l10n?.priorityLevel5Title ?? '5 - High Priority';
      case 4:
        return l10n?.priorityLevel4Title ?? '4 - Dedicated';
      case 3:
        return l10n?.priorityLevel3Title ?? '3 - Moderate';
      case 2:
        return l10n?.priorityLevel2Title ?? '2 - Gentle Maintenance';
      case 1:
      default:
        return l10n?.priorityLevel1Title ?? '1 - Low / Baseline';
    }
  }

  String _getPriorityMeaningLabel(int priority, AppLocalizations? l10n) {
    switch (priority) {
      case 5:
        return l10n?.priorityLevel5Desc ??
            'Active effort focusing in having a significant improvement in the current score';
      case 4:
        return l10n?.priorityLevel4Desc ??
            'Active effort focusing in having a small improvement in the current score';
      case 3:
        return l10n?.priorityLevel3Desc ??
            'Active effort to maintain the current score';
      case 2:
        return l10n?.priorityLevel2Desc ??
            'Enough effort to not decrease much the current score';
      case 1:
      default:
        return l10n?.priorityLevel1Desc ??
            'Bare minimum effort';
    }
  }

  Color _getPriorityColor(int priority, ThemeData theme) {
    if (priority >= 4) {
      return theme.colorScheme.primary;
    } else if (priority == 3) {
      return theme.colorScheme.secondary;
    } else {
      return theme.colorScheme.onSurfaceVariant;
    }
  }

  AppLanguage _resolveLanguage(BuildContext context) {
    if (language != null) return language!;
    try {
      final code = Localizations.localeOf(context).languageCode.toLowerCase();
      if (code.startsWith('pt')) return AppLanguage.portuguese;
      if (code.startsWith('eo')) return AppLanguage.esperanto;
    } catch (_) {}
    return AppLanguage.english;
  }

  Future<void> _launchArticle(BuildContext context, AppLanguage lang) async {
    final url = Uri.parse(lifeArea.getArticleUrl(lang));
    try {
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      // Graceful fallback for test or headless environments
    }
  }

  Widget _buildScoreReferenceRow(
    BuildContext context, {
    required String score,
    required String text,
    Key? key,
  }) {
    final theme = Theme.of(context);
    return Container(
      key: key,
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.35),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 7.0, vertical: 3.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withOpacity(0.6),
              borderRadius: BorderRadius.circular(6.0),
            ),
            child: Text(
              score,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurface,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
