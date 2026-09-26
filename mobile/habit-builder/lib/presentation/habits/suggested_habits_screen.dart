import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/user_habits_repository.dart';
import '../../domain/engine/priority_engine.dart';
import '../../domain/models/suggested_habit.dart';
import '../evaluation/evaluation_controller.dart';
import '../evaluation/life_area_ui_extensions.dart';
import '../financial/financial_management_screen.dart';
import '../gratitude/gratitude_screen.dart';
import '../physical_activity/physical_activities_screen.dart';

/// Dedicated screen for displaying all suggested habits ordered by
/// weights according to the user's life area priorities.
///
/// Features:
/// - Dynamic ranking using [PriorityEngine.rankHabitsByPriority].
/// - Full localization for all 9 canonical habits across en, pt, and eo.
/// - Interactive habit selection / toggle to add or remove habits from the daily routine.
/// - Quick-launch actions for habits with specialized interactive modules (Gratitude, Physical Activity, Financial Management).
class SuggestedHabitsScreen extends ConsumerWidget {
  const SuggestedHabitsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);

    final evaluationsMapAsync = ref.watch(latestEvaluationsProvider);
    final selectedHabitIdsAsync = ref.watch(selectedHabitIdsStreamProvider);

    final evaluationsMap = evaluationsMapAsync.valueOrNull ?? {};
    final evaluations = evaluationsMap.values.toList();
    final selectedHabitIds = selectedHabitIdsAsync.valueOrNull ?? [];

    // Rank all canonical habits according to user's life area priorities
    final rankedHabits = PriorityEngine.rankHabitsByPriority(
      habits: SuggestedHabit.canonicalHabits,
      evaluations: evaluations,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n?.suggestedHabitsScreenTitle ?? 'Suggested Habits',
          key: const Key('suggested_habits_screen_title'),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: ListView(
          key: const Key('suggested_habits_list_view'),
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // HEADER BANNER
            Container(
              padding: const EdgeInsets.all(18.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primaryContainer.withOpacity(0.6),
                    theme.colorScheme.secondaryContainer.withOpacity(0.3),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: theme.colorScheme.outlineVariant.withOpacity(0.4),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.auto_awesome_rounded,
                          color: theme.colorScheme.primary,
                          size: 24,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n?.suggestedHabitsSectionTitle ??
                                  'Suggested Habits for Your Priorities',
                              key: const Key('suggested_habits_header_title'),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSurface,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              l10n?.suggestedHabitsSectionSubtitle ??
                                  'Actionable daily practices prioritized by your current life focus.',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Text(
                      '${selectedHabitIds.length} / ${rankedHabits.length} ${l10n?.habitInRoutine ?? 'in routine'}',
                      key: const Key('routine_habits_counter_chip'),
                      style: theme.textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // LIST OF ALL RANKED HABITS
            ...rankedHabits.map((habit) {
              final isSelected = selectedHabitIds.contains(habit.id);
              return _buildHabitCard(
                context,
                ref,
                habit,
                isSelected,
                theme,
                l10n,
              );
            }),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildHabitCard(
    BuildContext context,
    WidgetRef ref,
    SuggestedHabit habit,
    bool isSelected,
    ThemeData theme,
    AppLocalizations? l10n,
  ) {
    // Sort areas by weight descending (5 down to 1)
    final sortedAreaEntries = habit.areaWeights.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    final localizedTitle = habit.localizedTitle(l10n);
    final localizedDesc = habit.localizedDescription(l10n);

    return Card(
      key: Key('suggested_habit_${habit.id}'),
      margin: const EdgeInsets.only(bottom: 14.0),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
        side: BorderSide(
          color: isSelected
              ? theme.colorScheme.primary.withOpacity(0.6)
              : theme.colorScheme.outlineVariant.withOpacity(0.6),
          width: isSelected ? 1.5 : 1.0,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HABIT HEADER
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.colorScheme.primaryContainer
                        : theme.colorScheme.surfaceContainerHighest.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Icon(
                    habit.icon,
                    color: isSelected
                        ? theme.colorScheme.primary
                        : theme.colorScheme.onSurfaceVariant,
                    size: 26,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        localizedTitle,
                        key: Key('habit_title_${habit.id}'),
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        localizedDesc,
                        key: Key('habit_desc_${habit.id}'),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                          height: 1.35,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 14),

            // LIFE AREA SYNERGIES
            Text(
              l10n?.habitSynergyTitle ?? 'Life Area Synergy',
              style: theme.textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 6),
            Wrap(
              spacing: 6.0,
              runSpacing: 6.0,
              children: sortedAreaEntries.map((entry) {
                final area = entry.key;
                final weight = entry.value;
                final isCore = weight == 5;
                final areaTitle = l10n != null ? area.localizedName(l10n) : area.key;

                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                  decoration: BoxDecoration(
                    color: isCore
                        ? theme.colorScheme.primaryContainer.withOpacity(0.6)
                        : theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(8.0),
                    border: Border.all(
                      color: isCore
                          ? theme.colorScheme.primary.withOpacity(0.4)
                          : theme.colorScheme.outlineVariant.withOpacity(0.5),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        area.icon,
                        size: 13,
                        color: isCore
                            ? theme.colorScheme.primary
                            : theme.colorScheme.onSurfaceVariant,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        isCore ? '$areaTitle ★' : areaTitle,
                        style: theme.textTheme.labelSmall?.copyWith(
                          fontSize: 11,
                          fontWeight: isCore ? FontWeight.bold : FontWeight.normal,
                          color: isCore
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // ACTION CONTROLS ROW
            Row(
              children: [
                Expanded(
                  child: habit.isImplemented
                      ? (isSelected
                          ? FilledButton.tonalIcon(
                              key: Key('toggle_habit_${habit.id}'),
                              onPressed: () {
                                ref
                                    .read(userHabitsRepositoryProvider)
                                    .toggleHabitSelection(habit.id);
                              },
                              icon: const Icon(Icons.check_circle_rounded, size: 18),
                              label: Text(l10n?.habitInRoutine ?? 'In Routine'),
                              style: FilledButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            )
                          : OutlinedButton.icon(
                              key: Key('toggle_habit_${habit.id}'),
                              onPressed: () {
                                ref
                                    .read(userHabitsRepositoryProvider)
                                    .toggleHabitSelection(habit.id);
                              },
                              icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
                              label: Text(l10n?.addHabitToRoutine ?? 'Add to Routine'),
                              style: OutlinedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                              ),
                            ))
                      : Container(
                          key: Key('habit_coming_soon_${habit.id}'),
                          padding: const EdgeInsets.symmetric(horizontal: 14.0, vertical: 10.0),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12.0),
                            border: Border.all(
                              color: theme.colorScheme.outlineVariant.withOpacity(0.4),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.hourglass_top_rounded,
                                size: 16,
                                color: theme.colorScheme.onSurfaceVariant.withOpacity(0.7),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                l10n?.habitComingSoon ?? 'Coming Soon',
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                ),
                if (_hasInteractiveFeature(habit.id)) ...[
                  const SizedBox(width: 8),
                  IconButton.filledTonal(
                    key: Key('open_habit_feature_${habit.id}'),
                    tooltip: l10n?.openHabitFeature ?? 'Open Practice',
                    icon: const Icon(Icons.arrow_forward_rounded, size: 20),
                    onPressed: () => _openInteractiveFeature(context, habit.id),
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  bool _hasInteractiveFeature(String habitId) {
    return habitId == 'habit_nurture_of_gratitude' ||
        habitId == 'habit_regular_exercise_workout' ||
        habitId == 'habit_mindful_daily_expense_tracking';
  }

  void _openInteractiveFeature(BuildContext context, String habitId) {
    if (habitId == 'habit_nurture_of_gratitude') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const GratitudePracticeScreen()),
      );
    } else if (habitId == 'habit_regular_exercise_workout') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const PhysicalActivitiesScreen()),
      );
    } else if (habitId == 'habit_mindful_daily_expense_tracking') {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const FinancialManagementScreen()),
      );
    }
  }
}
