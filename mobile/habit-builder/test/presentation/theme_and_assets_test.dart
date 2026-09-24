import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/app/app.dart';
import 'package:habit_builder/app/theme.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/local/database_provider.dart';
import 'package:habit_builder/data/local/tables/users_table.dart';
import 'package:habit_builder/data/repositories/life_area_evaluation_repository.dart';
import 'package:habit_builder/data/repositories/user_repository.dart';
import 'package:habit_builder/domain/models/life_area.dart';
import 'package:habit_builder/domain/models/life_area_evaluation.dart';
import 'package:drift/native.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });
  group('Web App Theme & Brand Assets Synchronization', () {
    test('AppTheme lightTheme and darkTheme match web design tokens', () {
      final lightTheme = AppTheme.lightTheme;
      final darkTheme = AppTheme.darkTheme;

      // Web primary brand: Warm Orange ("Bona")
      expect(lightTheme.colorScheme.primary, const Color(0xFFE86A1B));
      // Web secondary brand: Teal-Green ("Loko")
      expect(lightTheme.colorScheme.secondary, const Color(0xFF269B87));
      // Web tertiary: Deep Slate Blue
      expect(lightTheme.colorScheme.tertiary, const Color(0xFF1A5F89));
      // Web organic canvas background
      expect(lightTheme.scaffoldBackgroundColor, const Color(0xFFFCFBF7));

      // Dark mode high contrast colors
      expect(darkTheme.colorScheme.primary, const Color(0xFFFF8E47));
      expect(darkTheme.colorScheme.secondary, const Color(0xFF42D6BD));
    });

    testWidgets('WelcomeScreen renders horizontal logo in AppBar and square logo in hero badge',
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

      // Find Image widgets on WelcomeScreen
      final imageWidgets = tester.widgetList<Image>(find.byType(Image)).toList();
      expect(imageWidgets.length, greaterThanOrEqualTo(2));

      // Verify horizontal-logo.png and logo.png asset providers
      final assetNames = imageWidgets
          .map((img) => img.image)
          .whereType<AssetImage>()
          .map((asset) => asset.assetName)
          .toList();

      expect(assetNames, contains('assets/images/horizontal-logo.png'));
      expect(assetNames, contains('assets/images/logo.png'));

      await testDb.close();
    });

    testWidgets('HomeScreen renders horizontal logo in AppBar',
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

      await userRepo.saveLanguage(AppLanguage.portuguese);
      await userRepo.saveName('Clara');
      await userRepo.setOnboardingCompleted(true);

      for (final area in LifeArea.values) {
        await evalRepo.saveEvaluation(
          LifeAreaEvaluation(
            id: 'eval-${area.value}',
            lifeArea: area,
            score: 8.0,
            currentPriority: 3,
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

      // Verify horizontal-logo.png in HomeScreen AppBar
      final imageWidgets = tester.widgetList<Image>(find.byType(Image)).toList();
      final assetNames = imageWidgets
          .map((img) => img.image)
          .whereType<AssetImage>()
          .map((asset) => asset.assetName)
          .toList();

      expect(assetNames, contains('assets/images/horizontal-logo.png'));

      // Verify settings menu button exists and refresh icon button was removed
      expect(find.byKey(const Key('settings_menu_button')), findsOneWidget);
      expect(find.byIcon(Icons.settings_outlined), findsOneWidget);
      expect(find.byIcon(Icons.refresh_outlined), findsNothing);

      await testDb.close();
    });

    testWidgets('12 areas overview sorts by priority descending (5 first) then score ascending (lowest first)',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 3800);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      final userRepo = UserRepository(testDb);
      final evalRepo = LifeAreaEvaluationRepository(testDb);

      await userRepo.saveLanguage(AppLanguage.portuguese);
      await userRepo.saveName('Lucas');
      await userRepo.setOnboardingCompleted(true);

      // Area A: Priority 5, Score 8.0
      await evalRepo.saveEvaluation(LifeAreaEvaluation(
        id: 'eval-1',
        lifeArea: LifeArea.healthFitness,
        score: 8.0,
        currentPriority: 5,
        evaluatedAt: DateTime.now(),
      ));

      // Area B: Priority 5, Score 4.0 (Lower score: should appear BEFORE Area A)
      await evalRepo.saveEvaluation(LifeAreaEvaluation(
        id: 'eval-2',
        lifeArea: LifeArea.emotionalWellbeing,
        score: 4.0,
        currentPriority: 5,
        evaluatedAt: DateTime.now(),
      ));

      // Area C: Priority 3, Score 2.0 (Lower priority: should appear after all Priority 5s)
      await evalRepo.saveEvaluation(LifeAreaEvaluation(
        id: 'eval-3',
        lifeArea: LifeArea.personalGrowth,
        score: 2.0,
        currentPriority: 3,
        evaluatedAt: DateTime.now(),
      ));

      // Populate remaining areas with priority 1
      for (final area in LifeArea.values) {
        if (area != LifeArea.healthFitness &&
            area != LifeArea.emotionalWellbeing &&
            area != LifeArea.personalGrowth) {
          await evalRepo.saveEvaluation(LifeAreaEvaluation(
            id: 'eval-${area.value}',
            lifeArea: area,
            score: 7.0,
            currentPriority: 1,
            evaluatedAt: DateTime.now(),
          ));
        }
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

      // Navigate to AssessedLifeAreasScreen
      await tester.tap(find.byKey(const Key('view_assessed_life_areas_button')));
      await tester.pumpAndSettle();

      // Find tiles inside overview
      final emotionalWellbeingFinder = find.byKey(Key('area_tile_${LifeArea.emotionalWellbeing.key}'));
      final healthFitnessFinder = find.byKey(Key('area_tile_${LifeArea.healthFitness.key}'));
      final personalGrowthFinder = find.byKey(Key('area_tile_${LifeArea.personalGrowth.key}'));

      expect(emotionalWellbeingFinder, findsOneWidget);
      expect(healthFitnessFinder, findsOneWidget);
      expect(personalGrowthFinder, findsOneWidget);

      final emotionalWellbeingY = tester.getTopLeft(emotionalWellbeingFinder).dy;
      final healthFitnessY = tester.getTopLeft(healthFitnessFinder).dy;
      final personalGrowthY = tester.getTopLeft(personalGrowthFinder).dy;

      // Both are priority 5, but emotionalWellbeing has score 4.0 < 8.0 -> should be rendered higher on screen
      expect(emotionalWellbeingY, lessThan(healthFitnessY));
      // personalGrowth has priority 3 -> should be rendered below both priority 5s
      expect(healthFitnessY, lessThan(personalGrowthY));

      await testDb.close();
    });

    testWidgets('Tapping hamburger menu navigates to ProfileScreen and updates language/name',
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

      await userRepo.saveLanguage(AppLanguage.portuguese);
      await userRepo.saveName('Lucas');
      await userRepo.setOnboardingCompleted(true);

      for (final area in LifeArea.values) {
        await evalRepo.saveEvaluation(LifeAreaEvaluation(
          id: 'eval-${area.value}',
          lifeArea: area,
          score: 7.0,
          currentPriority: 3,
          evaluatedAt: DateTime.now(),
        ));
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

      // Tap settings engine button
      await tester.tap(find.byKey(const Key('settings_menu_button')));
      await tester.pumpAndSettle();

      // Verify on ProfileScreen
      expect(find.text('Perfil e Configurações'), findsOneWidget);
      expect(find.byKey(const Key('profile_language_selector')), findsOneWidget);
      expect(find.byKey(const Key('profile_name_input_field')), findsOneWidget);

      // Edit name
      await tester.enterText(find.byKey(const Key('profile_name_input_field')), 'Lucas Silva');
      await tester.pumpAndSettle();

      // Tap save
      await tester.tap(find.byKey(const Key('save_profile_button')));
      await tester.pumpAndSettle();

      // Returns to HomeScreen with updated greeting
      expect(find.text('Olá, Lucas Silva'), findsOneWidget);

      await testDb.close();
    });
  });
}
