import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/app/app.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/local/database_provider.dart';
import 'package:habit_builder/data/local/tables/users_table.dart';
import 'package:habit_builder/data/repositories/user_repository.dart';
import 'package:habit_builder/presentation/financial/financial_management_screen.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('HomeScreen Financial Management Redirection Tests', () {
    testWidgets('renders Financial Management card on HomeScreen and navigates on tap', (tester) async {
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

      // Find the Financial Management card on HomeScreen
      final financialButton = find.byKey(const Key('home_financial_management_button'));
      expect(financialButton, findsOneWidget);
      expect(find.byKey(const Key('home_financial_management_title')), findsOneWidget);

      // Scroll into view if needed
      await tester.ensureVisible(financialButton);
      await tester.pumpAndSettle();

      // Tap card
      await tester.tap(financialButton);
      await tester.pumpAndSettle();

      // Verify that FinancialManagementScreen is rendered
      expect(find.byType(FinancialManagementScreen), findsOneWidget);
      expect(find.byKey(const Key('monthly_incomes_summary_card')), findsOneWidget);
      expect(find.byKey(const Key('monthly_expenses_summary_card')), findsOneWidget);

      await testDb.close();
    });
  });
}
