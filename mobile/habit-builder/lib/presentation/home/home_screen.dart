import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/gratitude_repository.dart';
import '../../data/repositories/training_repository.dart';
import '../../data/repositories/user_habits_repository.dart';
import '../../domain/models/gratitude_entry.dart';
import '../../domain/models/suggested_habit.dart';
import '../../domain/models/training.dart';
import '../evaluation/assessed_life_areas_screen.dart';
import '../financial/financial_management_screen.dart';
import '../gratitude/gratitude_screen.dart';
import '../habits/suggested_habits_screen.dart';
import '../onboarding/user_controller.dart';
import '../physical_activity/physical_activities_screen.dart';
import '../profile/profile_screen.dart';

/// The post-onboarding Home Page screen.
///
/// Features:
/// - Branded AppBar with logo and Profile/Settings action.
/// - Warm personal greeting banner.
/// - Prominent redirection card to Assessed Life Areas screen.
/// - Prominent redirection card to the dedicated Habits & Routines screen.
/// - Daily Routine section: ONLY lists the habits the user has actively picked/selected.
/// - Encouraging empty state if no habits have been selected yet.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final userState = ref.watch(userControllerProvider);
    final gratitudeCompletionAsync = ref.watch(todayGratitudeCompletionStreamProvider);
    final trainingSessionAsync = ref.watch(todayTrainingSessionStreamProvider);
    final selectedHabitIdsAsync = ref.watch(selectedHabitIdsStreamProvider);

    final gratitudeCompletion = gratitudeCompletionAsync.valueOrNull;
    final trainingSession = trainingSessionAsync.valueOrNull;
    final selectedHabitIds = selectedHabitIdsAsync.valueOrNull ?? [];

    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/images/horizontal-logo.png',
          height: 30,
          fit: BoxFit.contain,
          errorBuilder: (context, error, stackTrace) => Text(
            l10n?.appTitle ?? 'Bona Loko',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            key: const Key('settings_menu_button'),
            icon: const Icon(Icons.settings_outlined),
            tooltip: l10n?.profileTitle ?? 'Profile & Settings',
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const ProfileScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
          children: [
            // GREETING BANNER
            Container(
              key: const Key('home_greeting_card'),
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    theme.colorScheme.primaryContainer.withOpacity(0.7),
                    theme.colorScheme.secondaryContainer.withOpacity(0.4),
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
                  Text(
                    userState.name.isNotEmpty
                        ? (l10n?.userGreeting(userState.name) ??
                            'Hello, ${userState.name}')
                        : (l10n?.homeTitle ?? 'Welcome Home'),
                    key: const Key('home_user_greeting'),
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    l10n?.dailyTasksSubtitle ??
                        'Small, intentional actions to cultivate daily balance.',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // 1. DAILY TASKS / ROUTINE SECTION (DISPLAYED FIRST)
            Text(
              l10n?.dailyTasksTitle ?? 'Daily Tasks',
              key: const Key('daily_tasks_section_title'),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n?.dailyHabitsRoutineSubtitle ??
                  'Practices you have chosen to cultivate daily.',
              key: const Key('daily_tasks_section_subtitle'),
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),

            // ONLY LIST THE HABITS THE USER ALREADY PICKED/SELECTED
            if (selectedHabitIds.isEmpty) ...[
              // EMPTY STATE: INVITATION TO EXPLORE AND CHOOSE HABITS
              Container(
                key: const Key('empty_habits_container'),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(18.0),
                  border: Border.all(
                    color: theme.colorScheme.outlineVariant.withOpacity(0.5),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(14.0),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer.withOpacity(0.5),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.playlist_add_check_circle_outlined,
                        size: 36,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    const SizedBox(height: 14),
                    Text(
                      l10n?.noHabitsSelectedTitle ?? 'No Habits in Your Daily Routine',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      l10n?.noHabitsSelectedSubtitle ??
                          'Choose habits aligned with your life area priorities to build your daily routine.',
                      textAlign: TextAlign.center,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.35,
                      ),
                    ),
                    const SizedBox(height: 16),
                    FilledButton.icon(
                      key: const Key('empty_habits_explore_button'),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SuggestedHabitsScreen(),
                          ),
                        );
                      },
                      icon: const Icon(Icons.explore_outlined, size: 18),
                      label: Text(
                        l10n?.exploreSuggestedHabitsButton ?? 'Explore Suggested Habits',
                      ),
                    ),
                  ],
                ),
              ),
            ] else ...[
              // LIST SELECTED HABITS
              ...selectedHabitIds.map((habitId) {
                return _buildSelectedHabitItem(
                  context,
                  habitId,
                  theme,
                  l10n,
                  gratitudeCompletion,
                  trainingSession,
                );
              }),
              const SizedBox(height: 12),
              Center(
                child: TextButton.icon(
                  key: const Key('manage_habits_button'),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const SuggestedHabitsScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.tune_rounded, size: 18),
                  label: Text(
                    l10n?.manageRoutineButton ?? 'Manage Daily Routine',
                  ),
                ),
              ),
            ],
            const SizedBox(height: 24),

            // 2. SUGGESTED HABITS CARD (BELOW THE LIST OF THE USER'S HABITS)
            Material(
              color: Colors.transparent,
              child: InkWell(
                key: const Key('view_habits_screen_button'),
                borderRadius: BorderRadius.circular(16.0),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const SuggestedHabitsScreen(),
                    ),
                  );
                },
                child: Container(
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
                              l10n?.viewHabitsScreenButton ??
                                  'Suggested Habits & Routines',
                              key: const Key('view_habits_screen_title'),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n?.viewHabitsScreenSubtitle ??
                                  'Explore and select habits prioritized for your current life focus',
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
            ),
            const SizedBox(height: 12),

            // 3. LIFE AREA AND PRIORITIES CARD (LASTLY)
            Material(
              color: Colors.transparent,
              child: InkWell(
                key: const Key('view_assessed_life_areas_button'),
                borderRadius: BorderRadius.circular(16.0),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const AssessedLifeAreasScreen(),
                    ),
                  );
                },
                child: Container(
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
                          color: theme.colorScheme.secondaryContainer.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Icon(
                          Icons.pie_chart_outline_rounded,
                          size: 26,
                          color: theme.colorScheme.secondary,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              l10n?.viewAssessedLifeAreasButton ??
                                  'Life Areas & Priorities',
                              key: const Key('view_assessed_life_areas_title'),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              l10n?.viewAssessedLifeAreasSubtitle ??
                                  'Review focus areas, balance scores, and adjust priorities',
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
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildSelectedHabitItem(
    BuildContext context,
    String habitId,
    ThemeData theme,
    AppLocalizations? l10n,
    DailyGratitudeCompletion? gratitudeCompletion,
    DailyTrainingSession? trainingSession,
  ) {
    if (habitId == 'habit_nurture_of_gratitude') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: _buildGratitudeTaskCard(context, theme, l10n, gratitudeCompletion),
      );
    }

    if (habitId == 'habit_regular_exercise_workout') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: _buildPhysicalActivitiesTaskCard(context, theme, l10n, trainingSession),
      );
    }

    if (habitId == 'habit_mindful_daily_expense_tracking') {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12.0),
        child: _buildFinancialManagementCard(context, theme, l10n),
      );
    }

    // Generic selected habit card
    final habit = SuggestedHabit.canonicalHabits.firstWhere(
      (h) => h.id == habitId,
      orElse: () => SuggestedHabit(
        id: habitId,
        title: habitId,
        description: '',
        areaWeights: {},
      ),
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          key: Key('home_daily_task_$habitId'),
          borderRadius: BorderRadius.circular(16.0),
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const SuggestedHabitsScreen(),
              ),
            );
          },
          child: Container(
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
                  padding: const EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.primaryContainer.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(14.0),
                  ),
                  child: Icon(
                    habit.icon,
                    size: 26,
                    color: theme.colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              habit.localizedTitle(l10n),
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
                            decoration: BoxDecoration(
                              color: theme.colorScheme.secondaryContainer.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(6.0),
                            ),
                            child: Text(
                              l10n?.dailyPracticeBadge ?? 'Daily Practice',
                              style: theme.textTheme.labelSmall?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: theme.colorScheme.onSecondaryContainer,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        habit.localizedDescription(l10n),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
                  Icons.chevron_right_rounded,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGratitudeTaskCard(
    BuildContext context,
    ThemeData theme,
    AppLocalizations? l10n,
    DailyGratitudeCompletion? gratitudeCompletion,
  ) {
    final isFullyCompleted = gratitudeCompletion?.isFullyCompleted ?? false;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: const Key('home_daily_task_gratitude'),
        borderRadius: BorderRadius.circular(16.0),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const GratitudePracticeScreen(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: isFullyCompleted
                  ? Colors.green.withOpacity(0.5)
                  : theme.colorScheme.primary.withOpacity(0.3),
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
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: isFullyCompleted
                      ? Colors.green.withOpacity(0.15)
                      : theme.colorScheme.primaryContainer.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Icon(
                  isFullyCompleted
                      ? Icons.check_circle_rounded
                      : Icons.favorite_rounded,
                  size: 26,
                  color: isFullyCompleted
                      ? Colors.green
                      : theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.practiceGratitudeTaskTitle ?? 'Practice Gratitude',
                      key: const Key('practice_gratitude_task_title'),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isFullyCompleted
                          ? 'Morning & evening completed today'
                          : ((gratitudeCompletion?.morningCompleted ?? false)
                              ? 'Morning completed • Evening pending'
                              : ((gratitudeCompletion?.eveningCompleted ?? false)
                                  ? 'Evening completed • Morning pending'
                                  : (l10n?.practiceGratitudeTaskSubtitle ??
                                      'Morning grounding (1 min) & bedtime reflection (5 min)'))),
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
                Icons.chevron_right_rounded,
                color: theme.colorScheme.primary,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPhysicalActivitiesTaskCard(
    BuildContext context,
    ThemeData theme,
    AppLocalizations? l10n,
    DailyTrainingSession? trainingSession,
  ) {
    final isCompleted = trainingSession?.isCompleted ?? false;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: const Key('home_daily_task_physical_activity'),
        borderRadius: BorderRadius.circular(16.0),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const PhysicalActivitiesScreen(),
            ),
          );
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(
              color: isCompleted
                  ? Colors.green.withOpacity(0.5)
                  : theme.colorScheme.primary.withOpacity(0.3),
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
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: isCompleted
                      ? Colors.green.withOpacity(0.15)
                      : theme.colorScheme.primaryContainer.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Icon(
                  isCompleted
                      ? Icons.check_circle_rounded
                      : (trainingSession != null && !trainingSession.isCompleted
                          ? Icons.fitness_center_rounded
                          : Icons.directions_run_rounded),
                  size: 26,
                  color: isCompleted
                      ? Colors.green
                      : theme.colorScheme.primary,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n?.dailyPhysicalActivitiesTaskTitle ??
                          'Daily Physical Activities',
                      key: const Key('daily_physical_activities_task_title'),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      isCompleted
                          ? (l10n?.trainingCompletedToday ?? 'Workout completed today')
                          : (trainingSession != null && !trainingSession.isCompleted
                              ? (l10n?.trainingInProgress ?? 'Workout in progress')
                              : (l10n?.dailyPhysicalActivitiesTaskSubtitle ??
                                  'Walking, running, and customized daily movement targets.')),
                      key: const Key('daily_physical_activities_task_subtitle'),
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
                Icons.chevron_right_rounded,
                color: theme.colorScheme.primary,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFinancialManagementCard(
    BuildContext context,
    ThemeData theme,
    AppLocalizations? l10n,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        key: const Key('home_financial_management_button'),
        borderRadius: BorderRadius.circular(16.0),
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const FinancialManagementScreen(),
            ),
          );
        },
        child: Container(
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
                padding: const EdgeInsets.all(12.0),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primaryContainer.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(14.0),
                ),
                child: Icon(
                  Icons.account_balance_wallet_rounded,
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
                      l10n?.financialManagementCardTitle ??
                          'Financial Management',
                      key: const Key('home_financial_management_title'),
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n?.financialManagementCardSubtitle ??
                          'Track monthly incomes, expenses, and cultivate mindful stewardship',
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
                Icons.chevron_right_rounded,
                color: theme.colorScheme.primary,
                size: 24,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
