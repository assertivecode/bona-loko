import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/app/app.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/local/database_provider.dart';
import 'package:habit_builder/data/local/tables/users_table.dart';
import 'package:habit_builder/data/repositories/user_repository.dart';
import 'test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('HomeScreen Initial Onboarding Screen', () {
    testWidgets('renders components in exact order: language select, name input, description, start button',
        (WidgetTester tester) async {
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

      // 1. Language selector is present
      final languageFinder = find.byType(DropdownButtonFormField<AppLanguage>);
      expect(languageFinder, findsOneWidget);

      // 2. Name input is present
      final nameInputFinder = find.byType(TextField);
      expect(nameInputFinder, findsOneWidget);

      // 3. Assessment description is present
      final descriptionFinder = find.textContaining('Reflect on 12 essential areas of your life');
      expect(descriptionFinder, findsOneWidget);

      // 4. Start assessment button is at the bottom
      final startButtonFinder = find.byKey(const Key('start_assessment_button'));
      expect(startButtonFinder, findsOneWidget);

      // Verify vertical positioning order: Language < Name < Description < Button
      final langTop = tester.getTopLeft(languageFinder).dy;
      final nameTop = tester.getTopLeft(nameInputFinder).dy;
      final descTop = tester.getTopLeft(descriptionFinder).dy;
      final btnTop = tester.getTopLeft(startButtonFinder).dy;

      expect(langTop, lessThan(nameTop), reason: 'Language selector must be above name input');
      expect(nameTop, lessThan(descTop), reason: 'Name input must be above assessment description');
      expect(descTop, lessThan(btnTop), reason: 'Assessment description must be above start button');

      await testDb.close();
    });

    testWidgets('typing name and changing language saves to SQLite users table and updates UI',
        (WidgetTester tester) async {
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

      // Type name
      await tester.enterText(find.byType(TextField), 'Elena Vance');
      // Wait for debounce timer (300ms)
      await tester.pump(const Duration(milliseconds: 350));
      await tester.pumpAndSettle();

      // Verify row in SQLite users table
      final repo = UserRepository(testDb);
      var user = await repo.getUser();
      expect(user, isNotNull);
      expect(user!.name, 'Elena Vance');

      // Change language to Esperanto via dropdown
      await tester.tap(find.byType(DropdownButtonFormField<AppLanguage>));
      await tester.pumpAndSettle();

      // Tap the Esperanto item in dropdown menu
      final esperantoItem = find.text('Esperanto').last;
      await tester.tap(esperantoItem);
      await tester.pumpAndSettle();

      // Verify user updated in SQLite
      user = await repo.getUser();
      expect(user!.selectedLanguage, AppLanguage.esperanto);
      expect(user.selectedLanguage.id, 1);
      expect(user.name, 'Elena Vance');

      // Verify UI dynamically updated to Esperanto strings
      expect(find.text('Preferata Lingvo'), findsOneWidget);
      expect(find.text('Via Nomo'), findsOneWidget);
      expect(find.text('Komenci Taksadon'), findsOneWidget);
      expect(find.textContaining('Pripensu 12 esencajn viv-areojn'), findsOneWidget);

      await testDb.close();
    });
  });
}
