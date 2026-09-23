import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/gratitude_repository.dart';
import '../../data/repositories/training_repository.dart';
import '../evaluation/assessed_life_areas_screen.dart';
import '../financial/financial_management_screen.dart';
import '../gratitude/gratitude_screen.dart';
import '../onboarding/user_controller.dart';
import '../physical_activity/physical_activities_screen.dart';
import '../profile/profile_screen.dart';

/// The post-onboarding Home Page screen.
///
/// Features:
/// - Branded AppBar with logo and Profile/Settings action.
/// - Warm personal greeting.
/// - Daily Tasks section (featuring "Practice Gratitude" and "Daily Physical Activities").
/// - Prominent redirection card/button to the dedicated Assessed Life Areas screen.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context);
    final userState = ref.watch(userControllerProvider);
    final gratitudeCompletionAsync = ref.watch(todayGratitudeCompletionStreamProvider);
    final trainingSessionAsync = ref.watch(todayTrainingSessionStreamProvider);

    final gratitudeCompletion = gratitudeCompletionAsync.valueOrNull;
    final trainingSession = trainingSessionAsync.valueOrNull;

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
            const SizedBox(height: 20),

            // DEDICATED LIFE AREAS REDIRECTION BUTTON / CARD
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
                                  'Review focus dimensions, balance scores, and adjust priorities',
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
            const SizedBox(height: 28),

            // DAILY TASKS SECTION
            Text(
              l10n?.dailyTasksTitle ?? 'Daily Tasks',
              key: const Key('daily_tasks_section_title'),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n?.dailyTasksSubtitle ??
                  'Small, intentional actions to cultivate daily balance.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 14),

            // DAILY TASK: PRACTICE GRATITUDE
            Material(
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
                      color: (gratitudeCompletion?.isFullyCompleted ?? false)
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
                          color: (gratitudeCompletion?.isFullyCompleted ?? false)
                              ? Colors.green.withOpacity(0.15)
                              : theme.colorScheme.primaryContainer.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Icon(
                          (gratitudeCompletion?.isFullyCompleted ?? false)
                              ? Icons.check_circle_rounded
                              : Icons.favorite_rounded,
                          size: 26,
                          color: (gratitudeCompletion?.isFullyCompleted ?? false)
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
                              (gratitudeCompletion?.isFullyCompleted ?? false)
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
            ),
            const SizedBox(height: 12),

            // DAILY TASK: PHYSICAL ACTIVITIES
            Material(
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
                      color: (trainingSession?.isCompleted ?? false)
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
                          color: (trainingSession?.isCompleted ?? false)
                              ? Colors.green.withOpacity(0.15)
                              : theme.colorScheme.primaryContainer.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        child: Icon(
                          (trainingSession?.isCompleted ?? false)
                              ? Icons.check_circle_rounded
                              : (trainingSession != null && !trainingSession.isCompleted
                                  ? Icons.fitness_center_rounded
                                  : Icons.directions_run_rounded),
                          size: 26,
                          color: (trainingSession?.isCompleted ?? false)
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
                              (trainingSession?.isCompleted ?? false)
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
            ),
            const SizedBox(height: 12),

            // DEDICATED FINANCIAL MANAGEMENT REDIRECTION BUTTON / CARD
            Material(
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
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
