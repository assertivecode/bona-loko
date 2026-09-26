import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/engine/priority_engine.dart';
import '../../domain/models/life_area.dart';
import '../../domain/models/life_area_evaluation.dart';
import '../habits/suggested_habits_screen.dart';
import '../onboarding/assessment_wizard_screen.dart';
import 'evaluation_controller.dart';
import 'life_area_evaluation_card.dart';
import 'life_area_ui_extensions.dart';

/// Dedicated screen presenting the user's Assessed Life Areas.
///
/// Features:
/// - AppBar with back button and localized title
/// - Energy conservation mindful reminder (if applicable)
/// - Top Focus Priority Areas (where priority == 5 or highest deficit)
/// - Full 12 Life Areas Overview sorted by priority descending and score ascending
/// - Quick re-evaluation modal bottom sheet for each area
/// - Button to retake the full 12-area assessment wizard
class AssessedLifeAreasScreen extends ConsumerWidget {
  const AssessedLifeAreasScreen({super.key});

  void _openReEvaluationSheet(
    BuildContext context,
    WidgetRef ref,
    LifeArea area,
    LifeAreaEvaluation? currentEvaluation,
  ) {
    double tempScore = currentEvaluation?.score ?? 5.0;
    int tempPriority = currentEvaluation?.currentPriority ?? 3;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
              ),
              padding: EdgeInsets.only(
                left: 16.0,
                right: 16.0,
                top: 20.0,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24.0,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.outlineVariant,
                        borderRadius: BorderRadius.circular(2.0),
                      ),
                    ),
                    const SizedBox(height: 16),
                    LifeAreaEvaluationCard(
                      lifeArea: area,
                      score: tempScore,
                      currentPriority: tempPriority,
                      onScoreChanged: (val) {
                        setModalState(() {
                          tempScore = val;
                        });
                      },
                      onPriorityChanged: (val) {
                        setModalState(() {
                          tempPriority = val;
                        });
                      },
                      actionWidget: FilledButton.icon(
                        key: Key('save_re_evaluation_${area.key}'),
                        onPressed: () async {
                          await ref
                              .read(assessmentControllerProvider.notifier)
                              .saveSingleArea(area, tempScore, tempPriority);
                          if (bottomSheetContext.mounted) {
                            Navigator.of(bottomSheetContext).pop();
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: Text(
                          AppLocalizations.of(context)?.saveEvaluation ?? 'Save Evaluation',
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final evaluationsAsync = ref.watch(latestEvaluationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n?.assessedLifeAreasScreenTitle ?? 'Assessed Life Areas',
          key: const Key('assessed_life_areas_title'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: evaluationsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Center(child: Text('Error: $err')),
          data: (evaluationsMap) {
            final evaluationsList = evaluationsMap.values.toList();
            final rankedAreas = PriorityEngine.rankByFocusUrgency(evaluationsList);
            final topPriorityAreas =
                rankedAreas.where((e) => e.currentPriority == 5).toList();
            final energyCheck =
                PriorityEngine.checkEnergyConservation(evaluationsList);

            // Sort all 12 areas: first by priority descending (5 first), then by score ascending (lowest score first)
            final sortedOverviewAreas = List.of(LifeArea.values)..sort((a, b) {
              final evalA = evaluationsMap[a];
              final evalB = evaluationsMap[b];
              final priorityA = evalA?.currentPriority ?? 0;
              final priorityB = evalB?.currentPriority ?? 0;

              final priorityComparison = priorityB.compareTo(priorityA);
              if (priorityComparison != 0) return priorityComparison;

              final scoreA = evalA?.score ?? 0.0;
              final scoreB = evalB?.score ?? 0.0;
              final scoreComparison = scoreA.compareTo(scoreB);
              if (scoreComparison != 0) return scoreComparison;

              return a.value.compareTo(b.value);
            });

            return RefreshIndicator(
              onRefresh: () async {
                ref.invalidate(latestEvaluationsProvider);
              },
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                children: [
                  // ENERGY CONSERVATION ADVISORY BANNER (IF APPLICABLE)
                  if (energyCheck.hasWarning) ...[
                    Container(
                      key: const Key('energy_advisory_card'),
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiaryContainer.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16.0),
                        border: Border.all(
                          color: theme.colorScheme.tertiary.withOpacity(0.4),
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.eco_outlined,
                            color: theme.colorScheme.tertiary,
                            size: 24,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Mindful Focus Pacing',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.onTertiaryContainer,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  energyCheck.advisoryMessage ?? '',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onTertiaryContainer,
                                    height: 1.35,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],

                  // TOP FOCUS AREAS SECTION
                  Text(
                    l10n?.topPrioritiesTitle ?? 'Top Focus Areas',
                    key: const Key('top_focus_title'),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    l10n?.topPrioritiesSubtitle ??
                        'Areas where intentional daily practice can create the most meaningful balance.',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const SizedBox(height: 12),

                  if (topPriorityAreas.isNotEmpty)
                    ...topPriorityAreas.map((evaluation) {
                      return _buildPriorityAreaCard(
                        context,
                        ref,
                        evaluation,
                        theme,
                        l10n,
                        isTopFocus: true,
                      );
                    })
                  else
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Text(
                        'No areas currently set to priority 5. You can adjust priorities anytime below.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ),

                  // ALL 12 LIFE AREAS OVERVIEW (SORTED BY PRIORITY DESCENDING, THEN SCORE ASCENDING)
                  const SizedBox(height: 28),
                  Text(
                    l10n?.allAreasTitle ?? '12 Life Areas Overview',
                    key: const Key('all_areas_title'),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  ...sortedOverviewAreas.map((area) {
                    final evaluation = evaluationsMap[area];
                    return _buildAreaListTile(
                      context,
                      ref,
                      area,
                      evaluation,
                      theme,
                      l10n,
                    );
                  }),

                  // SUGGESTED HABITS FOR YOUR PRIORITIES REDIRECTION CARD
                  _buildSuggestedHabitsNavigationCard(
                    context,
                    theme,
                    l10n,
                  ),

                  const SizedBox(height: 32),
                  OutlinedButton.icon(
                    key: const Key('retake_full_assessment_button'),
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => const AssessmentWizardScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.tune),
                    label: Text(
                      l10n?.retakeAssessment ?? 'Retake Full Assessment',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildPriorityAreaCard(
    BuildContext context,
    WidgetRef ref,
    LifeAreaEvaluation evaluation,
    ThemeData theme,
    AppLocalizations? l10n, {
    required bool isTopFocus,
  }) {
    final area = evaluation.lifeArea;
    final areaTitle = l10n != null ? area.localizedName(l10n) : area.key;

    return Container(
      key: Key('top_focus_card_${area.key}'),
      margin: const EdgeInsets.only(bottom: 12.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: theme.colorScheme.primary.withOpacity(0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.colorScheme.shadow.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color: theme.colorScheme.primaryContainer.withOpacity(0.5),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Icon(
              area.icon,
              size: 24,
              color: theme.colorScheme.primary,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  areaTitle,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Text(
                      '${l10n?.scorePrefix ?? 'Score'}: ${evaluation.score.toStringAsFixed(1)} / 10',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primary.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Text(
                        '${l10n?.priorityPrefix ?? 'Priority'} 5',
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            key: Key('edit_top_area_${area.key}'),
            icon: const Icon(Icons.edit_outlined),
            color: theme.colorScheme.primary,
            onPressed: () => _openReEvaluationSheet(context, ref, area, evaluation),
          ),
        ],
      ),
    );
  }

  Widget _buildAreaListTile(
    BuildContext context,
    WidgetRef ref,
    LifeArea area,
    LifeAreaEvaluation? evaluation,
    ThemeData theme,
    AppLocalizations? l10n,
  ) {
    final areaTitle = l10n != null ? area.localizedName(l10n) : area.key;
    final score = evaluation?.score ?? 0.0;
    final priority = evaluation?.currentPriority ?? 1;
    final scorePrefix = l10n?.scorePrefix ?? 'Score';
    final priorityPrefix = l10n?.priorityPrefix ?? 'Priority';

    return Container(
      key: Key('area_tile_${area.key}'),
      margin: const EdgeInsets.only(bottom: 8.0),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(14.0),
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withOpacity(0.4),
        ),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 4.0),
        leading: Icon(
          area.icon,
          color: theme.colorScheme.primary,
        ),
        title: Text(
          areaTitle,
          style: theme.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: evaluation != null
            ? Text(
                '$scorePrefix: ${score.toStringAsFixed(1)} / 10  •  $priorityPrefix: $priority/5',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              )
            : Text(
                l10n?.notEvaluated ?? 'Not evaluated',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.outline,
                ),
              ),
        trailing: IconButton(
          key: Key('reevaluate_button_${area.key}'),
          icon: const Icon(Icons.tune_outlined, size: 20),
          onPressed: () => _openReEvaluationSheet(context, ref, area, evaluation),
        ),
      ),
    );
  }

  Widget _buildSuggestedHabitsNavigationCard(
    BuildContext context,
    ThemeData theme,
    AppLocalizations? l10n,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: const Key('view_suggested_habits_button'),
        borderRadius: BorderRadius.circular(16.0),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SuggestedHabitsScreen(),
            ),
          );
        },
        child: Container(
          margin: const EdgeInsets.only(top: 28.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: theme.colorScheme.outlineVariant.withOpacity(0.6),
            ),
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Icon(
                  Icons.auto_awesome_rounded,
                  size: 26,
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.suggestedHabitsSectionTitle ??
                          'Suggested Habits for Your Priorities',
                      key: const Key('suggested_habits_title'),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n?.suggestedHabitsSectionSubtitle ??
                          'Actionable daily practices prioritized by your current life focus.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Icon(
                Icons.arrow_forward_rounded,
                color: theme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
