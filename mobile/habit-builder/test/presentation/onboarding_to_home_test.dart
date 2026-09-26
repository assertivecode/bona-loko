import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/app/app.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/local/database_provider.dart';
import 'package:habit_builder/data/repositories/life_area_evaluation_repository.dart';
import 'package:habit_builder/data/repositories/user_repository.dart';
import 'package:habit_builder/domain/models/life_area.dart';
import 'package:habit_builder/presentation/evaluation/evaluation_controller.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('Onboarding to Home Page Integration Flow', () {
    testWidgets('completing 12-area assessment saves to life_areas_evaluations and displays Home Page screen',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      // 1. Initial State: App shows Welcome screen because onboarding is incomplete
      expect(find.byKey(const Key('continue_button')), findsOneWidget);
      expect(find.byKey(const Key('language_selector')), findsOneWidget);
      expect(find.byKey(const Key('name_input_field')), findsOneWidget);

      // Enter user name
      await tester.enterText(find.byKey(const Key('name_input_field')), 'Maya Lin');
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();

      // Tap "Continue" to navigate to Expectations Alignment screen
      await tester.ensureVisible(find.byKey(const Key('continue_button')));
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pumpAndSettle();

      // Expectations screen is displayed
      expect(find.byKey(const Key('expectations_scroll_view')), findsOneWidget);

      // Tap "Start Assessment" on Expectations screen
      await tester.drag(find.byKey(const Key('expectations_scroll_view')), const Offset(0, -800));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('start_assessment_button')));
      await tester.pumpAndSettle();

      // 2. Wizard opens on step 1 of 12 (health_fitness)
      expect(find.byKey(const Key('wizard_step_indicator')), findsOneWidget);
      expect(find.text('Step 1 of 12'), findsOneWidget);
      expect(find.text('Health & Physical Fitness'), findsOneWidget);

      // Set health_fitness priority to 5 (top focus) and score to 8.5
      await tester.ensureVisible(find.byKey(const Key('priority_button_health_fitness_5')));
      await tester.tap(find.byKey(const Key('priority_button_health_fitness_5')));
      await tester.pumpAndSettle();

      // Fast-forward through wizard to step 12
      final container = ProviderScope.containerOf(tester.element(find.byType(BonaLokoApp)));
      final wizardNotifier = container.read(assessmentControllerProvider.notifier);

      for (int i = 0; i < 11; i++) {
        wizardNotifier.nextStep();
      }
      await tester.pumpAndSettle();

      // We should now be on Step 12 of 12 (contribution_legacy)
      expect(find.text('Step 12 of 12'), findsOneWidget);
      expect(find.text('Contribution & Legacy'), findsOneWidget);
      expect(find.byKey(const Key('wizard_complete_button')), findsOneWidget);

      // Tap Complete Assessment
      await tester.tap(find.byKey(const Key('wizard_complete_button')));
      await tester.pumpAndSettle();

      // 3. Verify SQLite persistence in life_areas_evaluations table
      final evalRepo = LifeAreaEvaluationRepository(testDb);
      final latestEvals = await evalRepo.getLatestEvaluations();
      expect(latestEvals.length, 12);
      expect(latestEvals[LifeArea.healthFitness]!.currentPriority, 5);

      // 4. Verify onboardingCompleted flag in users table
      final userRepo = UserRepository(testDb);
      final user = await userRepo.getUser();
      expect(user!.onboardingCompleted, isTrue);
      expect(user.name, 'Maya Lin');

      // 5. Verify Home Page is now displayed with empty routine state and navigation buttons
      expect(find.byKey(const Key('home_user_greeting')), findsOneWidget);
      expect(find.text('Hello, Maya Lin'), findsOneWidget);
      expect(find.byKey(const Key('view_assessed_life_areas_button')), findsOneWidget);
      expect(find.byKey(const Key('view_habits_screen_button')), findsOneWidget);
      expect(find.byKey(const Key('empty_habits_container')), findsOneWidget);
      expect(find.byKey(const Key('home_daily_task_gratitude')), findsNothing);

      // 6. Navigate to Suggested Habits screen to pick a habit
      await tester.tap(find.byKey(const Key('view_habits_screen_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('suggested_habits_screen_title')), findsOneWidget);
      // Exercise is ranked top because health_fitness was prioritized at 5
      expect(find.byKey(const Key('suggested_habit_habit_regular_exercise_workout')), findsOneWidget);

      // Tap toggle to add exercise workout to routine
      await tester.tap(find.byKey(const Key('toggle_habit_habit_regular_exercise_workout')));
      await tester.pumpAndSettle();

      // Return to Home
      final NavigatorState nav = tester.state(find.byType(Navigator));
      nav.pop();
      await tester.pumpAndSettle();

      // 7. Verify physical activity task card is NOW displayed on Home page!
      expect(find.byKey(const Key('home_daily_task_physical_activity')), findsOneWidget);
      expect(find.byKey(const Key('empty_habits_container')), findsNothing);

      // 8. Tap view_assessed_life_areas_button to navigate to dedicated AssessedLifeAreasScreen
      await tester.tap(find.byKey(const Key('view_assessed_life_areas_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('assessed_life_areas_title')), findsOneWidget);
      expect(find.byKey(const Key('top_focus_title')), findsOneWidget);
      expect(find.byKey(const Key('all_areas_title')), findsOneWidget);

      // Verify health_fitness is listed under top focus areas
      expect(find.byKey(const Key('top_focus_card_health_fitness')), findsOneWidget);

      // 7. Test on-demand individual life area re-evaluation from AssessedLifeAreasScreen
      expect(find.byKey(const Key('reevaluate_button_personal_growth')), findsOneWidget);
      await tester.ensureVisible(find.byKey(const Key('reevaluate_button_personal_growth')));
      await tester.tap(find.byKey(const Key('reevaluate_button_personal_growth')));
      await tester.pumpAndSettle();

      // Re-evaluation bottom sheet opens using centralized LifeAreaEvaluationCard
      expect(find.text('Personal Growth & Learning'), findsWidgets);
      expect(find.byKey(const Key('save_re_evaluation_personal_growth')), findsOneWidget);

      // Update personal growth priority to 5
      await tester.ensureVisible(find.byKey(const Key('priority_button_personal_growth_5')));
      await tester.tap(find.byKey(const Key('priority_button_personal_growth_5')));
      await tester.pumpAndSettle();

      // Tap Save
      await tester.ensureVisible(find.byKey(const Key('save_re_evaluation_personal_growth')));
      await tester.tap(find.byKey(const Key('save_re_evaluation_personal_growth')));
      await tester.pumpAndSettle();

      // Verify updated in SQLite
      final personalGrowthEval = await evalRepo.getEvaluationForArea(LifeArea.personalGrowth);
      expect(personalGrowthEval!.currentPriority, 5);

      await testDb.close();
    });
  });
}
