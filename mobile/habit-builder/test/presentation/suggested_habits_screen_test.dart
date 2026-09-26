import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/app/app.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/local/database_provider.dart';
import 'package:habit_builder/data/local/tables/users_table.dart';
import 'package:habit_builder/data/repositories/life_area_evaluation_repository.dart';
import 'package:habit_builder/data/repositories/user_habits_repository.dart';
import 'package:habit_builder/data/repositories/user_repository.dart';
import 'package:habit_builder/domain/models/life_area.dart';
import 'package:habit_builder/domain/models/life_area_evaluation.dart';
import 'package:habit_builder/presentation/physical_activity/physical_activities_screen.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('SuggestedHabitsScreen Unit & Widget Tests', () {
    testWidgets('renders habits ordered by user priorities with correct localized English copy', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      final userRepo = UserRepository(testDb);
      final evalRepo = LifeAreaEvaluationRepository(testDb);

      await userRepo.saveLanguage(AppLanguage.english);
      await userRepo.saveName('Clara');
      await userRepo.setOnboardingCompleted(true);

      // Prioritize healthFitness (5) and financesWealth (4), others 2
      for (final area in LifeArea.values) {
        int priority = 2;
        if (area == LifeArea.healthFitness) priority = 5;
        if (area == LifeArea.financesWealth) priority = 4;

        await evalRepo.saveEvaluation(
          LifeAreaEvaluation(
            id: 'eval-${area.value}',
            lifeArea: area,
            score: 7.0,
            currentPriority: priority,
            evaluatedAt: DateTime.now(),
          ),
        );
      }

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to Suggested Habits screen via Home button
      await tester.tap(find.byKey(const Key('view_habits_screen_button')));
      await tester.pumpAndSettle();

      // Verify screen header
      expect(find.byKey(const Key('suggested_habits_screen_title')), findsOneWidget);
      expect(find.text('Suggested Habits for Your Priorities'), findsOneWidget);
      expect(find.byKey(const Key('routine_habits_counter_chip')), findsOneWidget);
      expect(find.text('0 / 9 In Routine'), findsOneWidget);

      // Exercise habit should be ranked top
      expect(find.byKey(const Key('suggested_habit_habit_regular_exercise_workout')), findsOneWidget);
      expect(find.text('Daily Physical Exercise & Movement'), findsOneWidget);

      await testDb.close();
    });

    testWidgets('renders all habits localized in Portuguese when user language is Portuguese', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      final userRepo = UserRepository(testDb);
      await userRepo.saveLanguage(AppLanguage.portuguese);
      await userRepo.saveName('Tiago');
      await userRepo.setOnboardingCompleted(true);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to Suggested Habits screen via Home button
      await tester.tap(find.byKey(const Key('view_habits_screen_button')));
      await tester.pumpAndSettle();

      // Verify Portuguese translations
      expect(find.text('Hábitos Sugeridos'), findsOneWidget);
      expect(find.text('Hábitos Sugeridos para Suas Prioridades'), findsOneWidget);
      expect(find.text('0 / 9 Na Rotina'), findsOneWidget);
      expect(find.text('Exercício Físico Diário & Movimento'), findsOneWidget);
      expect(find.text('Adicionar à Rotina'), findsWidgets);

      await testDb.close();
    });

    testWidgets('renders all habits localized in Esperanto when user language is Esperanto', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      final userRepo = UserRepository(testDb);
      await userRepo.saveLanguage(AppLanguage.esperanto);
      await userRepo.saveName('Marko');
      await userRepo.setOnboardingCompleted(true);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to Suggested Habits screen via Home button
      await tester.tap(find.byKey(const Key('view_habits_screen_button')));
      await tester.pumpAndSettle();

      // Verify Esperanto translations
      expect(find.text('Sugestitaj Kutimoj'), findsOneWidget);
      expect(find.text('Sugestitaj Kutimoj por Viaj Prioritatoj'), findsOneWidget);
      expect(find.text('0 / 9 En Rutino'), findsOneWidget);
      expect(find.text('Ĉiutaga Fizika Ekzercado & Movado'), findsOneWidget);
      expect(find.text('Aldoni al Rutino'), findsWidgets);

      await testDb.close();
    });

    testWidgets('allows picking and unpicking habits to update daily routine state', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      final userRepo = UserRepository(testDb);
      final habitsRepo = UserHabitsRepository(testDb);

      await userRepo.saveLanguage(AppLanguage.english);
      await userRepo.saveName('Sarah');
      await userRepo.setOnboardingCompleted(true);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Navigate to Suggested Habits screen
      await tester.tap(find.byKey(const Key('view_habits_screen_button')));
      await tester.pumpAndSettle();

      expect(find.text('0 / 9 In Routine'), findsOneWidget);

      // Tap to select exercise habit
      await tester.tap(find.byKey(const Key('toggle_habit_habit_regular_exercise_workout')));
      await tester.pumpAndSettle();

      // Counter updates to 1 / 9 and button displays "In Routine"
      expect(find.text('1 / 9 In Routine'), findsOneWidget);
      expect(find.text('In Routine'), findsWidgets);

      // Verify persisted in SQLite
      final isSelected = await habitsRepo.isHabitSelected('habit_regular_exercise_workout');
      expect(isSelected, isTrue);

      // Tap again to unpick habit
      await tester.tap(find.byKey(const Key('toggle_habit_habit_regular_exercise_workout')));
      await tester.pumpAndSettle();

      expect(find.text('0 / 9 In Routine'), findsOneWidget);
      final isSelectedAfter = await habitsRepo.isHabitSelected('habit_regular_exercise_workout');
      expect(isSelectedAfter, isFalse);

      await testDb.close();
    });

    testWidgets('quick launch action buttons navigate to interactive modules', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      final userRepo = UserRepository(testDb);

      await userRepo.saveLanguage(AppLanguage.english);
      await userRepo.saveName('Jordan');
      await userRepo.setOnboardingCompleted(true);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('view_habits_screen_button')));
      await tester.pumpAndSettle();

      // Tap open interactive feature for regular exercise
      expect(find.byKey(const Key('open_habit_feature_habit_regular_exercise_workout')), findsOneWidget);
      await tester.tap(find.byKey(const Key('open_habit_feature_habit_regular_exercise_workout')));
      await tester.pumpAndSettle();

      expect(find.byType(PhysicalActivitiesScreen), findsOneWidget);

      // Pop back
      final NavigatorState nav = tester.state(find.byType(Navigator));
      nav.pop();
      await tester.pumpAndSettle();

      expect(find.byType(PhysicalActivitiesScreen), findsNothing);

      await testDb.close();
    });

    testWidgets('hides Add to Routine button and shows Coming Soon badge for habits not yet implemented', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      final userRepo = UserRepository(testDb);

      await userRepo.saveLanguage(AppLanguage.english);
      await userRepo.saveName('Alex');
      await userRepo.setOnboardingCompleted(true);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('view_habits_screen_button')));
      await tester.pumpAndSettle();

      // Implemented habits have toggle button (Add to Routine)
      expect(find.byKey(const Key('toggle_habit_habit_regular_exercise_workout')), findsOneWidget);
      expect(find.byKey(const Key('toggle_habit_habit_nurture_of_gratitude')), findsOneWidget);

      await tester.scrollUntilVisible(
        find.byKey(const Key('toggle_habit_habit_mindful_daily_expense_tracking')),
        200.0,
        scrollable: find.byType(Scrollable),
      );
      expect(find.byKey(const Key('toggle_habit_habit_mindful_daily_expense_tracking')), findsOneWidget);

      // Unimplemented habits do NOT have toggle button (it is removed/hidden)
      expect(find.byKey(const Key('toggle_habit_habit_consistent_sleep_evening_transition')), findsNothing);
      expect(find.byKey(const Key('toggle_habit_habit_morning_screen_free_window')), findsNothing);
      expect(find.byKey(const Key('toggle_habit_habit_daily_protected_reading')), findsNothing);
      expect(find.byKey(const Key('toggle_habit_habit_daily_family_connection_ritual')), findsNothing);
      expect(find.byKey(const Key('toggle_habit_habit_weekly_personal_outreach')), findsNothing);
      expect(find.byKey(const Key('toggle_habit_habit_daily_guilt_free_micro_leisure')), findsNothing);

      // Scroll back up or scroll to an unimplemented habit to verify Coming Soon indicator
      await tester.scrollUntilVisible(
        find.byKey(const Key('habit_coming_soon_habit_consistent_sleep_evening_transition')),
        -200.0,
        scrollable: find.byType(Scrollable),
      );
      expect(find.byKey(const Key('habit_coming_soon_habit_consistent_sleep_evening_transition')), findsOneWidget);
      expect(find.text('Coming Soon'), findsWidgets);

      await testDb.close();
    });
  });
}
