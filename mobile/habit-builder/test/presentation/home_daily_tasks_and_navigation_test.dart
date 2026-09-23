import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/app/app.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/local/database_provider.dart';
import 'package:habit_builder/data/local/tables/users_table.dart';
import 'package:habit_builder/data/repositories/life_area_evaluation_repository.dart';
import 'package:habit_builder/data/repositories/user_repository.dart';
import 'package:habit_builder/domain/models/life_area.dart';
import 'package:habit_builder/domain/models/life_area_evaluation.dart';
import 'package:habit_builder/presentation/evaluation/assessed_life_areas_screen.dart';
import 'package:habit_builder/presentation/gratitude/gratitude_screen.dart';
import 'package:habit_builder/presentation/physical_activity/physical_activities_screen.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('HomeScreen Daily Tasks and Navigation', () {
    testWidgets(
        'renders daily tasks, navigates to GratitudePracticeScreen, PhysicalActivitiesScreen and AssessedLifeAreasScreen',
        (WidgetTester tester) async {
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
      await userRepo.saveName('Elena');
      await userRepo.setOnboardingCompleted(true);

      for (final area in LifeArea.values) {
        await evalRepo.saveEvaluation(
          LifeAreaEvaluation(
            id: 'eval-${area.value}',
            lifeArea: area,
            score: 8.0,
            currentPriority: area == LifeArea.healthFitness ? 5 : 3,
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

      // 1. Verify Home Page displays greeting and daily tasks
      expect(find.byKey(const Key('home_user_greeting')), findsOneWidget);
      expect(find.text('Hello, Elena'), findsOneWidget);
      expect(find.byKey(const Key('daily_tasks_section_title')), findsOneWidget);
      expect(find.text('Daily Tasks'), findsOneWidget);
      expect(find.byKey(const Key('home_daily_task_gratitude')), findsOneWidget);
      expect(find.text('Practice Gratitude'), findsOneWidget);
      expect(find.byKey(const Key('home_daily_task_physical_activity')), findsOneWidget);
      expect(find.text('Daily Physical Activities'), findsOneWidget);
      expect(find.byKey(const Key('view_assessed_life_areas_button')), findsOneWidget);
      expect(find.text('Life Areas & Priorities'), findsOneWidget);

      // Invariant: 12 Life Areas and Top Focus Areas are NOT directly on HomeScreen
      expect(find.byKey(const Key('top_focus_title')), findsNothing);
      expect(find.byKey(const Key('all_areas_title')), findsNothing);

      // 2. Navigate to Gratitude Practice Screen
      await tester.tap(find.byKey(const Key('home_daily_task_gratitude')));
      await tester.pumpAndSettle();

      expect(find.byType(GratitudePracticeScreen), findsOneWidget);
      expect(find.byKey(const Key('gratitude_screen_title')), findsOneWidget);
      expect(find.byKey(const Key('gratitude_morning_card')), findsOneWidget);
      expect(find.byKey(const Key('gratitude_evening_card')), findsOneWidget);

      // Pop back to Home
      final NavigatorState navigator = tester.state(find.byType(Navigator));
      navigator.pop();
      await tester.pumpAndSettle();

      expect(find.byType(GratitudePracticeScreen), findsNothing);

      // 3. Navigate to Physical Activities Screen
      await tester.tap(find.byKey(const Key('home_daily_task_physical_activity')));
      await tester.pumpAndSettle();

      expect(find.byType(PhysicalActivitiesScreen), findsOneWidget);
      expect(find.byKey(const Key('physical_activities_screen_title')), findsOneWidget);
      expect(find.byKey(const Key('physical_activities_summary_card')), findsOneWidget);
      expect(find.byKey(const Key('add_physical_activity_button')), findsOneWidget);

      // Pop back to Home
      final NavigatorState nav2 = tester.state(find.byType(Navigator));
      nav2.pop();
      await tester.pumpAndSettle();

      expect(find.byType(PhysicalActivitiesScreen), findsNothing);

      // 4. Navigate to Assessed Life Areas Screen
      await tester.tap(find.byKey(const Key('view_assessed_life_areas_button')));
      await tester.pumpAndSettle();

      expect(find.byType(AssessedLifeAreasScreen), findsOneWidget);
      expect(find.byKey(const Key('assessed_life_areas_title')), findsOneWidget);
      expect(find.byKey(const Key('top_focus_title')), findsOneWidget);
      expect(find.byKey(const Key('all_areas_title')), findsOneWidget);

      await testDb.close();
    });
  });
}
