import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/app/app.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/local/database_provider.dart';
import 'package:habit_builder/data/local/tables/users_table.dart';
import 'package:habit_builder/presentation/onboarding/user_controller.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('Device Locale & Region Auto-Detection Integration Tests', () {
    testWidgets('First-run with Portuguese device locale automatically defaults to Portuguese',
        (WidgetTester tester) async {
      // Simulate Portuguese device locale (e.g. Brazil)
      tester.platformDispatcher.localeTestValue = const Locale('pt', 'BR');
      addTearDown(() {
        tester.platformDispatcher.clearLocaleTestValue();
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

      // Verify language dropdown has Portuguese pre-selected
      final dropdown = tester.widget<DropdownButtonFormField<AppLanguage>>(
        find.byKey(const Key('language_selector')),
      );
      expect(dropdown.initialValue, AppLanguage.portuguese);

      // Verify Portuguese localized text is rendered on WelcomeScreen
      expect(find.text('Idioma de Preferência'), findsOneWidget);
      expect(find.text('Continuar'), findsOneWidget);

      await testDb.close();
    });

    testWidgets('First-run with Lusophone country code (e.g. Angola) with English phone UI defaults to Portuguese',
        (WidgetTester tester) async {
      // Simulate English device language with Angola region code
      tester.platformDispatcher.localeTestValue = const Locale('en', 'AO');
      addTearDown(() {
        tester.platformDispatcher.clearLocaleTestValue();
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

      final dropdown = tester.widget<DropdownButtonFormField<AppLanguage>>(
        find.byKey(const Key('language_selector')),
      );
      expect(dropdown.initialValue, AppLanguage.portuguese);

      expect(find.text('Idioma de Preferência'), findsOneWidget);

      await testDb.close();
    });

    testWidgets('First-run with Esperanto locale defaults to Esperanto',
        (WidgetTester tester) async {
      tester.platformDispatcher.localeTestValue = const Locale('eo');
      addTearDown(() {
        tester.platformDispatcher.clearLocaleTestValue();
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

      final dropdown = tester.widget<DropdownButtonFormField<AppLanguage>>(
        find.byKey(const Key('language_selector')),
      );
      expect(dropdown.initialValue, AppLanguage.esperanto);

      expect(find.text('Preferata Lingvo'), findsOneWidget);
      expect(find.text('Daŭrigi'), findsOneWidget);

      await testDb.close();
    });

    testWidgets('User can manually change language away from auto-detected default',
        (WidgetTester tester) async {
      tester.platformDispatcher.localeTestValue = const Locale('pt', 'BR');
      addTearDown(() {
        tester.platformDispatcher.clearLocaleTestValue();
      });

      final testDb = AppDatabase(NativeDatabase.memory());

      late WidgetRef capturedRef;
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            appDatabaseProvider.overrideWithValue(testDb),
          ],
          child: Consumer(
            builder: (context, ref, child) {
              capturedRef = ref;
              return const BonaLokoApp();
            },
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Idioma de Preferência'), findsOneWidget);

      // Change language via controller to English
      await capturedRef.read(userControllerProvider.notifier).setLanguage(AppLanguage.english);
      await tester.pumpAndSettle();

      // UI switches to English
      expect(find.text('Preferred Language'), findsOneWidget);
      expect(find.text('Continue'), findsOneWidget);

      await testDb.close();
    });
  });
}
