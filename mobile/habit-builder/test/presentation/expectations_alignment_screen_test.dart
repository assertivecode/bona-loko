import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/app/app.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/local/database_provider.dart';
import 'package:habit_builder/data/local/tables/users_table.dart';
import 'package:habit_builder/data/repositories/user_repository.dart';
import 'package:habit_builder/presentation/onboarding/expectations_alignment_screen.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('ExpectationsAlignmentScreen Unit & Widget Tests', () {
    test('getCalmArticleUrl generates correct URL for each language', () {
      expect(
        ExpectationsAlignmentScreen.getCalmArticleUrl(AppLanguage.english),
        'https://bonaloko.com/thoughts-and-reflections/the-importance-of-nurturing-calm',
      );
      expect(
        ExpectationsAlignmentScreen.getCalmArticleUrl(AppLanguage.portuguese),
        'https://bonaloko.com/pt-br/pensamentos-e-reflexoes/a-importancia-de-cultivar-a-calma',
      );
      expect(
        ExpectationsAlignmentScreen.getCalmArticleUrl(AppLanguage.esperanto),
        'https://bonaloko.com/eo/pensoj-kaj-reflektoj/la-graveco-de-flegi-trankvilon',
      );
    });

    testWidgets('renders all expectation and next step cards in English', (WidgetTester tester) async {
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

      // Welcome screen is shown first
      expect(find.byKey(const Key('continue_button')), findsOneWidget);
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pumpAndSettle();

      // Expectations screen is displayed
      expect(find.byKey(const Key('expectations_scroll_view')), findsOneWidget);
      expect(find.text('Aligning Expectations'), findsOneWidget);

      // Verify Philosophy Cards
      expect(find.byKey(const Key('card_faith_in_small_changes')), findsOneWidget);
      expect(find.text('Faith in Small Changes'), findsOneWidget);
      expect(find.textContaining('faith that small, mindful changes compound'), findsOneWidget);

      expect(find.byKey(const Key('card_sustainable_pace')), findsOneWidget);
      expect(find.text('A Measured, Sustainable Pace'), findsOneWidget);
      expect(find.textContaining('not a high-pressure productivity tool'), findsOneWidget);

      expect(find.byKey(const Key('card_nurturing_calm')), findsOneWidget);
      expect(find.text('The Importance of Nurturing Calm'), findsOneWidget);
      expect(find.byKey(const Key('read_calm_article_button')), findsOneWidget);

      // Verify Next Step Cards
      expect(find.byKey(const Key('step_card_assessment')), findsOneWidget);
      expect(find.text('1. Calm Life Areas Assessment'), findsOneWidget);

      expect(find.byKey(const Key('step_card_habits')), findsOneWidget);
      expect(find.text('2. Prioritized Habit Suggestions'), findsOneWidget);

      expect(find.byKey(const Key('step_card_daily_habits')), findsOneWidget);
      expect(find.text('3. Choose Daily Habits'), findsOneWidget);

      expect(find.byKey(const Key('step_card_reflections')), findsOneWidget);
      expect(find.text('4. Reflect at Your Own Pace'), findsOneWidget);

      // Verify Start Assessment button
      expect(find.byKey(const Key('start_assessment_button')), findsOneWidget);

      await testDb.close();
    });

    testWidgets('renders all texts localized in Portuguese when language is Portuguese', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      final userRepo = UserRepository(testDb);
      await userRepo.saveLanguage(AppLanguage.portuguese);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap continue on Welcome Screen
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pumpAndSettle();

      // Verify Portuguese translations
      expect(find.text('Alinhando Expectativas'), findsOneWidget);
      expect(find.text('Nossa Filosofia Fundamental'), findsOneWidget);
      expect(find.text('Fé em Pequenas Mudanças'), findsOneWidget);
      expect(find.text('Um Ritmo Medido e Sustentável'), findsOneWidget);
      expect(find.text('A Importância de Cultivar a Calma'), findsOneWidget);
      expect(find.text('Ler Artigo Online'), findsOneWidget);
      expect(find.text('O Que Esperar a Seguir'), findsOneWidget);
      expect(find.text('1. Avaliação Serena das Áreas da Vida'), findsOneWidget);
      expect(find.text('2. Sugestões de Hábitos Priorizadas'), findsOneWidget);
      expect(find.text('3. Escolha de Hábitos Diários'), findsOneWidget);
      expect(find.text('4. Reflita no Seu Próprio Ritmo'), findsOneWidget);
      expect(find.text('Iniciar Avaliação'), findsOneWidget);

      await testDb.close();
    });

    testWidgets('renders all texts localized in Esperanto when language is Esperanto', (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      final userRepo = UserRepository(testDb);
      await userRepo.saveLanguage(AppLanguage.esperanto);

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: const BonaLokoApp(),
        ),
      );
      await tester.pumpAndSettle();

      // Tap continue on Welcome Screen
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pumpAndSettle();

      // Verify Esperanto translations
      expect(find.text('Kongruigo de Atendoj'), findsOneWidget);
      expect(find.text('Nia Kerna Filozofio'), findsOneWidget);
      expect(find.text('Fido al Malgrandaj Ŝanĝoj'), findsOneWidget);
      expect(find.text('Mezurita, Daŭripova Takto'), findsOneWidget);
      expect(find.text('La Graveco de Flegi Trankvilon'), findsOneWidget);
      expect(find.text('Legi Artikolon Interrete'), findsOneWidget);
      expect(find.text('Kion Atendi Poste'), findsOneWidget);
      expect(find.text('1. Trankvila Taksado de Viv-Areoj'), findsOneWidget);
      expect(find.text('2. Prioritigitaj Sugestoj de Kutimoj'), findsOneWidget);
      expect(find.text('3. Elekto de Ĉiutagaj Kutimoj'), findsOneWidget);
      expect(find.text('4. Pripensu Laŭ Via Propra Takto'), findsOneWidget);
      expect(find.text('Komenci Taksadon'), findsOneWidget);

      await testDb.close();
    });

    testWidgets('tapping Start Assessment advances to 12-area assessment wizard', (WidgetTester tester) async {
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

      // Tap continue on Welcome Screen
      await tester.tap(find.byKey(const Key('continue_button')));
      await tester.pumpAndSettle();

      // Tap Start Assessment on Expectations Screen
      await tester.drag(find.byKey(const Key('expectations_scroll_view')), const Offset(0, -800));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const Key('start_assessment_button')));
      await tester.pumpAndSettle();

      // Assessment wizard is now displayed
      expect(find.byKey(const Key('wizard_step_indicator')), findsOneWidget);
      expect(find.text('Step 1 of 12'), findsOneWidget);
      expect(find.text('Health & Physical Fitness'), findsOneWidget);

      await testDb.close();
    });
  });
}
