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
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('Onboarding Step Auto-Detection & Portuguese Localization', () {
    testWidgets('translates top sentences in Portuguese: Passo 1 de 12 and X% Concluído',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      final userRepo = UserRepository(testDb);

      // Pre-configure user with Portuguese language and name
      await userRepo.saveLanguage(AppLanguage.portuguese);
      await userRepo.saveName('Mateus');

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Because language and name are already configured, app automatically redirects to Wizard
      expect(find.byKey(const Key('wizard_step_indicator')), findsOneWidget);
      expect(find.text('Passo 1 de 12'), findsOneWidget);
      expect(find.text('8% Concluído'), findsOneWidget);

      // Area 1 in Portuguese: Saúde e Condicionamento Físico
      expect(find.text('Saúde e Condicionamento Físico'), findsOneWidget);
      expect(find.text('Área 1 de 12'), findsOneWidget);

      await testDb.close();
    });

    testWidgets(
        'if Saúde e Condicionamento Físico was already evaluated, redirects to next screen (Bem-Estar Mental e Emocional)',
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

      // 1. Language and name already configured
      await userRepo.saveLanguage(AppLanguage.portuguese);
      await userRepo.saveName('Larissa');

      // 2. Saúde e Condicionamento Físico already evaluated in SQLite
      await evalRepo.saveEvaluation(
        LifeAreaEvaluation(
          id: 'eval-health',
          lifeArea: LifeArea.healthFitness,
          score: 8.0,
          currentPriority: 4,
          evaluatedAt: DateTime.now(),
        ),
      );

      // Launch app
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Automatically redirects to step 2 of 12
      expect(find.text('Passo 2 de 12'), findsOneWidget);
      expect(find.text('16% Concluído'), findsOneWidget);
      expect(find.text('Bem-Estar Mental e Emocional'), findsOneWidget);
      expect(find.text('Área 2 de 12'), findsOneWidget);

      await testDb.close();
    });

    testWidgets(
        'if areas 1 and 2 are evaluated, automatically redirects to area 3 (Crescimento Pessoal e Aprendizado)',
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
      await userRepo.saveName('Tiago');

      // Area 1 evaluated
      await evalRepo.saveEvaluation(
        LifeAreaEvaluation(
          id: 'eval-1',
          lifeArea: LifeArea.healthFitness,
          score: 7.0,
          currentPriority: 3,
          evaluatedAt: DateTime.now(),
        ),
      );

      // Area 2 evaluated
      await evalRepo.saveEvaluation(
        LifeAreaEvaluation(
          id: 'eval-2',
          lifeArea: LifeArea.emotionalWellbeing,
          score: 6.5,
          currentPriority: 4,
          evaluatedAt: DateTime.now(),
        ),
      );

      // Launch app
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Automatically redirects to step 3 of 12
      expect(find.text('Passo 3 de 12'), findsOneWidget);
      expect(find.text('25% Concluído'), findsOneWidget);
      expect(find.text('Crescimento Pessoal e Aprendizado'), findsOneWidget);
      expect(find.text('Área 3 de 12'), findsOneWidget);

      await testDb.close();
    });

    testWidgets(
        'translates priority level title and concept meaning in Portuguese for 3 - Moderado',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      final userRepo = UserRepository(testDb);

      await userRepo.saveLanguage(AppLanguage.portuguese);
      await userRepo.saveName('Ana');

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      // In step 1 (Saúde e Condicionamento Físico), default priority is 3
      // Verify translated title and concept meaning
      expect(find.text('Prioridade de Foco / Prática'), findsOneWidget);
      expect(find.text('3 - Moderado'), findsOneWidget);
      expect(
        find.text('Esforço ativo para manter a nota atual'),
        findsOneWidget,
      );

      // Tap on priority 5 button and verify 5 - Alta Prioridade translation and concept
      await tester.tap(find.byKey(const Key('priority_button_health_fitness_5')));
      await tester.pumpAndSettle();

      expect(find.text('5 - Alta Prioridade'), findsOneWidget);
      expect(
        find.text('Esforço ativo focado em obter uma melhoria significativa na nota atual'),
        findsOneWidget,
      );

      // Tap on priority 1 button and verify 1 - Baixo / Linha de Base
      await tester.tap(find.byKey(const Key('priority_button_health_fitness_1')));
      await tester.pumpAndSettle();

      expect(find.text('1 - Baixo / Linha de Base'), findsOneWidget);
      expect(
        find.text('Esforço mínimo absoluto'),
        findsOneWidget,
      );

      // Tap on priority 2 button and verify 2 - Manutenção Suave
      await tester.tap(find.byKey(const Key('priority_button_health_fitness_2')));
      await tester.pumpAndSettle();

      expect(find.text('2 - Manutenção Suave'), findsOneWidget);
      expect(
        find.text('Esforço suficiente para não diminuir muito a nota atual'),
        findsOneWidget,
      );

      // Tap on priority 4 button and verify 4 - Dedicado
      await tester.tap(find.byKey(const Key('priority_button_health_fitness_4')));
      await tester.pumpAndSettle();

      expect(find.text('4 - Dedicado'), findsOneWidget);
      expect(
        find.text('Esforço ativo focado em obter uma pequena melhoria na nota atual'),
        findsOneWidget,
      );

      await testDb.close();
    });

    testWidgets(
        'translates user greeting "Olá, {user_name}", "Nota", and "Prioridade" on HomeScreen in Portuguese',
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
      final habitsRepo = UserHabitsRepository(testDb);

      // Configure user with Portuguese and completed onboarding
      await userRepo.saveLanguage(AppLanguage.portuguese);
      await userRepo.saveName('Mateus');
      await userRepo.setOnboardingCompleted(true);
      await habitsRepo.selectHabit('habit_nurture_of_gratitude');

      // Insert evaluations for all 12 areas
      for (final area in LifeArea.values) {
        await evalRepo.saveEvaluation(
          LifeAreaEvaluation(
            id: 'eval-${area.value}',
            lifeArea: area,
            score: 7.5,
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

      // 1. Verify translated user greeting and daily tasks on HomeScreen
      expect(find.byKey(const Key('home_user_greeting')), findsOneWidget);
      expect(find.text('Olá, Mateus'), findsOneWidget);
      expect(find.text('Tarefas Diárias'), findsOneWidget);
      expect(find.text('Praticar Gratidão'), findsOneWidget);

      // Navigate to AssessedLifeAreasScreen to verify translated Nota and Prioridade
      await tester.tap(find.byKey(const Key('view_assessed_life_areas_button')));
      await tester.pumpAndSettle();

      // 2. Verify top priority area badge and score are translated
      expect(find.text('Nota: 7.5 / 10'), findsWidgets);
      expect(find.text('Prioridade 5'), findsOneWidget);

      // 3. Verify 12 areas list item subtitle translates Nota and Prioridade
      expect(find.textContaining('Nota: 7.5 / 10  •  Prioridade: 5/5'), findsOneWidget);

      await testDb.close();
    });
  });
}
