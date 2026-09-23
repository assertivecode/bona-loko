import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/local/database_provider.dart';
import 'package:habit_builder/presentation/physical_activity/physical_activities_screen.dart';
import '../test_helper.dart';

Widget _buildTestWidget(AppDatabase testDb, {Locale locale = const Locale('en')}) {
  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWithValue(testDb),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      locale: locale,
      home: const PhysicalActivitiesScreen(),
    ),
  );
}

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('PhysicalActivitiesScreen: 3-Tier Hierarchy & Localization', () {
    testWidgets(
        'creates groups, adds routines, configures exercises with sets, starts session, concludes, and deletes session',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());

      await tester.pumpWidget(_buildTestWidget(testDb));
      await tester.pumpAndSettle();

      // 1. Initial screen structure: 3-tier sections
      expect(find.byKey(const Key('physical_activities_screen_title')), findsOneWidget);
      expect(find.widgetWithText(AppBar, 'Daily Physical Activities'), findsOneWidget);
      expect(find.byKey(const Key('physical_activities_summary_card')), findsOneWidget);
      expect(find.byKey(const Key('workout_groups_title')), findsOneWidget);
      expect(find.byKey(const Key('workout_routines_title')), findsOneWidget);
      expect(find.byKey(const Key('add_group_button')), findsOneWidget);
      expect(find.byKey(const Key('add_routine_button')), findsOneWidget);
      // Floating button is removed per requirements
      expect(find.byKey(const Key('add_physical_activity_fab')), findsNothing);
      expect(find.byKey(const Key('add_physical_activity_button')), findsOneWidget);

      // Default Group and Routine exist initially
      expect(find.text('Default Group'), findsOneWidget);
      expect(find.text('Sample Workout'), findsWidgets);
      expect(find.text('Squats'), findsOneWidget);

      // 2. Create a new Group "Hipertrofia ABC"
      await tester.tap(find.byKey(const Key('add_group_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('group_name_input')), findsOneWidget);
      await tester.enterText(find.byKey(const Key('group_name_input')), 'Hipertrofia ABC');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('save_group_button')));
      await tester.pumpAndSettle();

      expect(find.text('Hipertrofia ABC'), findsOneWidget);

      // 3. Add a new Routine "Treino A - Peito" inside "Hipertrofia ABC"
      await tester.tap(find.byKey(const Key('add_routine_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('routine_name_input')), findsOneWidget);
      await tester.enterText(find.byKey(const Key('routine_name_input')), 'Treino A - Peito');
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('save_routine_button')));
      await tester.pumpAndSettle();

      expect(find.text('Treino A - Peito'), findsWidgets);

      // 4. Add Walking (Duration: 30 minutes, Sets: 1) to the routine via add_physical_activity_button
      await tester.tap(find.byKey(const Key('add_physical_activity_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('activity_dialog_title')), findsOneWidget);
      expect(find.byKey(const Key('activity_chip_walking')), findsOneWidget);

      await tester.tap(find.byKey(const Key('activity_chip_walking')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('sets_chip_1')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('preset_target_30')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('save_physical_activity_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('physical_activities_empty_card')), findsNothing);
      expect(find.text('Walking'), findsOneWidget);
      expect(find.text('1 sets × 30 min'), findsOneWidget);
      expect(find.byKey(const Key('start_training_button')), findsOneWidget);

      // 5. Add Push-ups (Repetitions: 25 reps, Sets: 3)
      await tester.tap(find.byKey(const Key('add_physical_activity_button')));
      await tester.pumpAndSettle();

      expect(find.text('Target Metric'), findsOneWidget);
      await tester.tap(find.byKey(const Key('activity_chip_pushups')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('metric_chip_repetitions')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('sets_chip_3')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('preset_target_25')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('save_physical_activity_button')));
      await tester.pumpAndSettle();

      expect(find.text('Push-ups'), findsOneWidget);
      expect(find.text('3 sets × 25 reps'), findsOneWidget);

      // 6. Start Daily Workout Session
      await tester.tap(find.byKey(const Key('start_training_button')));
      await tester.pumpAndSettle();

      // Verify Session Execution View is active
      expect(find.text('Workout in Progress'), findsOneWidget);
      expect(find.byKey(const Key('today_session_card')), findsOneWidget);
      expect(find.text('0 of 2 completed'), findsOneWidget);
      expect(find.byKey(const Key('conclude_training_button')), findsOneWidget);
      expect(find.byKey(const Key('delete_today_session_button')), findsOneWidget);

      // 7. Toggle completion on Walking
      final firstUnchecked = find.byIcon(Icons.radio_button_unchecked_rounded).first;
      await tester.tap(firstUnchecked);
      await tester.pumpAndSettle();

      expect(find.text('1 of 2 completed'), findsOneWidget);

      // 8. Conclude Workout Session
      await tester.tap(find.byKey(const Key('conclude_training_button')));
      await tester.pumpAndSettle();

      expect(find.text('Workout Completed Today'), findsOneWidget);
      expect(find.byKey(const Key('resume_training_button')), findsOneWidget);

      // 9. Delete today's training session
      await tester.tap(find.byKey(const Key('delete_today_session_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('confirm_delete_session_button')), findsOneWidget);
      await tester.tap(find.byKey(const Key('confirm_delete_session_button')));
      await tester.pumpAndSettle();

      // Session card is cleared after deletion
      expect(find.byKey(const Key('today_session_card')), findsNothing);

      await testDb.close();
    });

    testWidgets(
        'displays localized exercise names, custom placeholder, metric label, and progress in Portuguese (pt-BR)',
        (WidgetTester tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());

      await tester.pumpWidget(_buildTestWidget(testDb, locale: const Locale('pt', 'BR')));
      await tester.pumpAndSettle();

      // Verify default exercise "Squats" is displayed as "Agachamentos"
      expect(find.text('Agachamentos'), findsOneWidget);

      // Open Add Exercise dialog in Portuguese
      await tester.tap(find.byKey(const Key('add_physical_activity_button')));
      await tester.pumpAndSettle();

      // Check exercise chips in Portuguese
      expect(find.text('Caminhada'), findsOneWidget);
      expect(find.text('Corrida'), findsOneWidget);
      expect(find.text('Ciclismo'), findsOneWidget);
      expect(find.text('Natação'), findsOneWidget);
      expect(find.text('Flexões'), findsOneWidget);
      expect(find.text('Personalizado'), findsOneWidget);
      expect(find.text('Métrica Alvo'), findsOneWidget);

      // Verify updated athletic icons for Squats and Push-ups
      expect(find.byIcon(Icons.sports_martial_arts_rounded), findsWidgets);
      expect(find.byIcon(Icons.sports_gymnastics_rounded), findsWidgets);

      // Tap Personalizado and verify custom placeholder
      await tester.tap(find.byKey(const Key('activity_chip_custom')));
      await tester.pumpAndSettle();

      expect(find.text('ex: Barra fixa, Prancha, Avanço'), findsOneWidget);

      // Select Caminhada
      await tester.tap(find.byKey(const Key('activity_chip_walking')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('save_physical_activity_button')));
      await tester.pumpAndSettle();

      // Start workout in Portuguese
      await tester.tap(find.byKey(const Key('start_training_button')));
      await tester.pumpAndSettle();

      // Verify session counter and exercises in Portuguese
      expect(find.text('0 de 2 concluídos'), findsOneWidget);
      expect(find.text('Caminhada'), findsWidgets);
      expect(find.text('Agachamentos'), findsWidgets);

      // Check delete session dialog in Portuguese
      await tester.tap(find.byKey(const Key('delete_today_session_button')));
      await tester.pumpAndSettle();

      expect(find.text('Excluir Sessão de Treino'), findsOneWidget);
      expect(
        find.text('Tem certeza que deseja excluir a sessão de treino de hoje? O progresso de hoje será apagado.'),
        findsOneWidget,
      );

      await tester.tap(find.byKey(const Key('confirm_delete_session_button')));
      await tester.pumpAndSettle();

      expect(find.byKey(const Key('today_session_card')), findsNothing);

      await testDb.close();
    });
  });
}
