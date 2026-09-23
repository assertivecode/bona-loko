import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/local/database_provider.dart';
import 'package:habit_builder/data/repositories/financial_repository.dart';
import 'package:habit_builder/app/app.dart';
import 'package:habit_builder/core/utils/date_localization_helper.dart';
import 'package:habit_builder/domain/models/financial_transaction.dart';
import 'package:habit_builder/presentation/financial/financial_management_screen.dart';
import '../test_helper.dart';

Widget _buildTestWidget(AppDatabase testDb, [Locale locale = const Locale('en')]) {
  return ProviderScope(
    overrides: [
      appDatabaseProvider.overrideWithValue(testDb),
    ],
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: const [
        ...AppLocalizations.localizationsDelegates,
        EsperantoMaterialLocalizationsDelegate(),
        EsperantoCupertinoLocalizationsDelegate(),
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: const FinancialManagementScreen(),
    ),
  );
}

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('FinancialManagementScreen Widget & Integration Tests', () {
    testWidgets('displays two summary cards at top with current month sums', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      await testDb.ensureTablesExist();
      final repository = FinancialRepository(testDb);

      final now = DateTime.now();

      // Current month incomes: $3,000 + $500 = $3,500.00
      await repository.addTransaction(
        title: 'Monthly Salary',
        amount: 3000.0,
        type: FinancialTransactionType.income,
        date: DateTime(now.year, now.month, 2),
        currencyCode: 'USD',
      );
      await repository.addTransaction(
        title: 'Design Project',
        amount: 500.0,
        type: FinancialTransactionType.income,
        date: DateTime(now.year, now.month, 5),
        currencyCode: 'USD',
      );

      // Current month expenses: $1,000 + $200 = $1,200.00
      await repository.addTransaction(
        title: 'Apartment Rent',
        amount: 1000.0,
        type: FinancialTransactionType.expense,
        date: DateTime(now.year, now.month, 3),
        currencyCode: 'USD',
      );
      await repository.addTransaction(
        title: 'Groceries',
        amount: 200.0,
        type: FinancialTransactionType.expense,
        date: DateTime(now.year, now.month, 4),
        currencyCode: 'USD',
      );

      await tester.pumpWidget(_buildTestWidget(testDb));
      await tester.pumpAndSettle();

      // Verify screen title and top summary cards exist
      expect(find.byKey(const Key('financial_screen_title')), findsOneWidget);
      expect(find.byKey(const Key('monthly_incomes_summary_card')), findsOneWidget);
      expect(find.byKey(const Key('monthly_expenses_summary_card')), findsOneWidget);

      // Verify incomes sum displays $3,500.00
      final incomeTextFinder = find.byKey(const Key('monthly_incomes_sum_text'));
      expect(incomeTextFinder, findsOneWidget);
      expect(tester.widget<Text>(incomeTextFinder).data, contains('3,500.00'));

      // Verify expenses sum displays $1,200.00
      final expenseTextFinder = find.byKey(const Key('monthly_expenses_sum_text'));
      expect(expenseTextFinder, findsOneWidget);
      expect(tester.widget<Text>(expenseTextFinder).data, contains('1,200.00'));

      // Verify net balance shows +$2,300.00
      final netBalanceFinder = find.byKey(const Key('monthly_net_balance_text'));
      expect(netBalanceFinder, findsOneWidget);
      expect(tester.widget<Text>(netBalanceFinder).data, contains('2,300.00'));

      await testDb.close();
    });

    testWidgets('registers a new income and immediately updates top income sum', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      await testDb.ensureTablesExist();

      await tester.pumpWidget(_buildTestWidget(testDb));
      await tester.pumpAndSettle();

      // Initially zero
      final incomeTextFinder = find.byKey(const Key('monthly_incomes_sum_text'));
      expect(tester.widget<Text>(incomeTextFinder).data, contains('0.00'));

      // Tap FAB to open modal
      await tester.tap(find.byKey(const Key('add_transaction_fab')));
      await tester.pumpAndSettle();

      // Select Income
      await tester.tap(find.byKey(const Key('select_type_income')));
      await tester.pumpAndSettle();

      // Enter amount and title
      await tester.enterText(find.byKey(const Key('transaction_amount_field')), '750.00');
      await tester.enterText(find.byKey(const Key('transaction_title_field')), 'Consulting');

      // Submit
      await tester.tap(find.byKey(const Key('save_transaction_button')));
      await tester.pumpAndSettle();

      // Incomes sum now reflects 750.00
      expect(tester.widget<Text>(incomeTextFinder).data, contains('750.00'));
      expect(find.text('Consulting'), findsOneWidget);

      await testDb.close();
    });

    testWidgets('navigating to previous month switches summary context', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      await testDb.ensureTablesExist();
      final repository = FinancialRepository(testDb);

      final now = DateTime.now();

      await repository.addTransaction(
        title: 'Current Month Salary',
        amount: 4000.0,
        type: FinancialTransactionType.income,
        date: DateTime(now.year, now.month, 2),
      );

      await tester.pumpWidget(_buildTestWidget(testDb));
      await tester.pumpAndSettle();

      expect(tester.widget<Text>(find.byKey(const Key('monthly_incomes_sum_text'))).data, contains('4,000.00'));

      // Tap previous month (<)
      await tester.tap(find.byKey(const Key('prev_month_button')));
      await tester.pumpAndSettle();

      // In previous month, sum is $0.00 and empty state is shown
      expect(tester.widget<Text>(find.byKey(const Key('monthly_incomes_sum_text'))).data, contains('0.00'));
      expect(find.byKey(const Key('empty_transactions_card')), findsOneWidget);

      await testDb.close();
    });

    testWidgets('renders categories in multiline Wrap layout and allows creating custom category', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      await testDb.ensureTablesExist();

      await tester.pumpWidget(_buildTestWidget(testDb));
      await tester.pumpAndSettle();

      // Open Add Transaction Modal
      await tester.tap(find.byKey(const Key('add_transaction_fab')));
      await tester.pumpAndSettle();

      // Verify categories are rendered in a Wrap widget (responsive multiline breakdown)
      expect(find.byType(Wrap), findsWidgets);
      expect(find.byKey(const Key('add_custom_category_chip')), findsOneWidget);

      // Tap + Category chip to create custom category
      await tester.tap(find.byKey(const Key('add_custom_category_chip')));
      await tester.pumpAndSettle();

      // Enter custom category name
      expect(find.byKey(const Key('custom_category_name_input')), findsOneWidget);
      await tester.enterText(find.byKey(const Key('custom_category_name_input')), 'Pet Care');

      // Confirm addition
      await tester.tap(find.byKey(const Key('confirm_add_category_button')));
      await tester.pumpAndSettle();

      // Verify custom category is displayed and selected
      expect(find.text('Pet Care'), findsOneWidget);

      await testDb.close();
    });

    testWidgets('allows editing an existing transaction without currency dropdown inside modal', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      await testDb.ensureTablesExist();
      final repository = FinancialRepository(testDb);

      final now = DateTime.now();

      await repository.addTransaction(
        title: 'Original Expense',
        amount: 150.0,
        type: FinancialTransactionType.expense,
        date: DateTime(now.year, now.month, 10),
        currencyCode: 'USD',
      );

      await tester.pumpWidget(_buildTestWidget(testDb));
      await tester.pumpAndSettle();

      // Verify original transaction is listed
      expect(find.text('Original Expense'), findsOneWidget);
      expect(tester.widget<Text>(find.byKey(const Key('monthly_expenses_sum_text'))).data, contains('150.00'));

      // Tap edit button on the transaction
      final editBtnFinder = find.byTooltip('Edit');
      expect(editBtnFinder, findsOneWidget);
      await tester.tap(editBtnFinder);
      await tester.pumpAndSettle();

      // Verify modal is in edit mode with pre-populated values
      expect(find.byKey(const Key('add_transaction_modal_title')), findsOneWidget);
      expect(tester.widget<Text>(find.byKey(const Key('add_transaction_modal_title'))).data, equals('Edit Transaction'));

      // Verify Currency dropdown is NOT inside the modal (managed at screen level per month)
      expect(find.byKey(const Key('transaction_currency_dropdown')), findsNothing);

      // Verify amount field exists
      final amountFinder = find.byKey(const Key('transaction_amount_field'));
      expect(amountFinder, findsOneWidget);

      // Edit amount and title
      await tester.enterText(amountFinder, '275.50');
      await tester.enterText(find.byKey(const Key('transaction_title_field')), 'Updated Expense');

      // Submit changes
      await tester.tap(find.byKey(const Key('save_transaction_button')));
      await tester.pumpAndSettle();

      // Verify transaction list updated
      expect(find.text('Original Expense'), findsNothing);
      expect(find.text('Updated Expense'), findsOneWidget);

      // Verify expenses sum updated to 275.50
      expect(tester.widget<Text>(find.byKey(const Key('monthly_expenses_sum_text'))).data, contains('275.50'));

      await testDb.close();
    });

    testWidgets('displays localized month name accurately across English, Portuguese, and Esperanto', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      await testDb.ensureTablesExist();

      final now = DateTime.now();

      // 1. English Locale
      await tester.pumpWidget(_buildTestWidget(testDb, const Locale('en')));
      await tester.pumpAndSettle();
      final expectedEn = DateLocalizationHelper.formatMonthYear(now, 'en');
      final monthLabelEn = find.byKey(const Key('selected_month_label'));
      expect(tester.widget<Text>(monthLabelEn).data, expectedEn);

      // 2. Portuguese Locale
      await tester.pumpWidget(_buildTestWidget(testDb, const Locale('pt', 'BR')));
      await tester.pumpAndSettle();
      final expectedPt = DateLocalizationHelper.formatMonthYear(now, 'pt');
      final monthLabelPt = find.byKey(const Key('selected_month_label'));
      expect(tester.widget<Text>(monthLabelPt).data, expectedPt);

      // 3. Esperanto Locale
      await tester.pumpWidget(_buildTestWidget(testDb, const Locale('eo')));
      await tester.pumpAndSettle();
      final expectedEo = DateLocalizationHelper.formatMonthYear(now, 'eo');
      final monthLabelEo = find.byKey(const Key('selected_month_label'));
      expect(tester.widget<Text>(monthLabelEo).data, expectedEo);

      await testDb.close();
    });

    testWidgets('registers a currency for the month via dialog and adds currency ChoiceChip', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      await testDb.ensureTablesExist();

      await tester.pumpWidget(_buildTestWidget(testDb));
      await tester.pumpAndSettle();

      // Initially register button exists
      expect(find.byKey(const Key('register_currency_button')), findsOneWidget);
      expect(find.byKey(const Key('currency_chip_EUR')), findsNothing);

      // Tap + Currency button to open dialog
      await tester.tap(find.byKey(const Key('register_currency_button')));
      await tester.pumpAndSettle();

      // Select EUR
      final eurTile = find.byKey(const Key('select_currency_EUR'));
      expect(eurTile, findsOneWidget);
      await tester.tap(eurTile);
      await tester.pumpAndSettle();

      // Choice chip for EUR is now displayed
      expect(find.byKey(const Key('currency_chip_EUR')), findsOneWidget);

      await testDb.close();
    });

    testWidgets('segregates summaries and transactions by active currency', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      await testDb.ensureTablesExist();
      final repository = FinancialRepository(testDb);

      final now = DateTime.now();

      // USD Income: $1,200.00
      await repository.addTransaction(
        title: 'USD Consulting',
        amount: 1200.0,
        type: FinancialTransactionType.income,
        date: DateTime(now.year, now.month, 5),
        currencyCode: 'USD',
      );

      // BRL Income: R$ 5,000.00
      await repository.addTransaction(
        title: 'BRL Local Job',
        amount: 5000.0,
        type: FinancialTransactionType.income,
        date: DateTime(now.year, now.month, 6),
        currencyCode: 'BRL',
      );

      await tester.pumpWidget(_buildTestWidget(testDb));
      await tester.pumpAndSettle();

      // Verify both currency chips are present
      expect(find.byKey(const Key('currency_chip_USD')), findsOneWidget);
      expect(find.byKey(const Key('currency_chip_BRL')), findsOneWidget);

      // Check current active currency
      // If BRL is active (preferred default for pt/br or first in set):
      if (find.text('BRL Local Job').evaluate().isNotEmpty) {
        expect(tester.widget<Text>(find.byKey(const Key('monthly_incomes_sum_text'))).data, contains('5,000.00'));
        expect(find.text('USD Consulting'), findsNothing);

        // Switch to USD
        await tester.tap(find.byKey(const Key('currency_chip_USD')));
        await tester.pumpAndSettle();

        // Now USD is active
        expect(tester.widget<Text>(find.byKey(const Key('monthly_incomes_sum_text'))).data, contains('1,200.00'));
        expect(find.text('USD Consulting'), findsOneWidget);
        expect(find.text('BRL Local Job'), findsNothing);
      } else {
        expect(tester.widget<Text>(find.byKey(const Key('monthly_incomes_sum_text'))).data, contains('1,200.00'));
        expect(find.text('USD Consulting'), findsOneWidget);
        expect(find.text('BRL Local Job'), findsNothing);

        // Switch to BRL
        await tester.tap(find.byKey(const Key('currency_chip_BRL')));
        await tester.pumpAndSettle();

        // Now BRL is active
        expect(tester.widget<Text>(find.byKey(const Key('monthly_incomes_sum_text'))).data, contains('5,000.00'));
        expect(find.text('BRL Local Job'), findsOneWidget);
        expect(find.text('USD Consulting'), findsNothing);
      }

      await testDb.close();
    });

    testWidgets('renders currencies in order: US Dollar, Euro, Brazilian Real, then others', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      await testDb.ensureTablesExist();
      final repository = FinancialRepository(testDb);

      final now = DateTime.now();

      // Register BRL, USD, EUR in reverse order
      await repository.addTransaction(
        title: 'BRL Tx',
        amount: 100.0,
        type: FinancialTransactionType.income,
        date: DateTime(now.year, now.month, 1),
        currencyCode: 'BRL',
      );
      await repository.addTransaction(
        title: 'EUR Tx',
        amount: 100.0,
        type: FinancialTransactionType.income,
        date: DateTime(now.year, now.month, 2),
        currencyCode: 'EUR',
      );
      await repository.addTransaction(
        title: 'USD Tx',
        amount: 100.0,
        type: FinancialTransactionType.income,
        date: DateTime(now.year, now.month, 3),
        currencyCode: 'USD',
      );

      await tester.pumpWidget(_buildTestWidget(testDb));
      await tester.pumpAndSettle();

      final usdPos = tester.getTopLeft(find.byKey(const Key('currency_chip_USD')));
      final eurPos = tester.getTopLeft(find.byKey(const Key('currency_chip_EUR')));
      final brlPos = tester.getTopLeft(find.byKey(const Key('currency_chip_BRL')));

      // US Dollar (<) Euro (<) Brazilian Real
      expect(usdPos.dx, lessThan(eurPos.dx));
      expect(eurPos.dx, lessThan(brlPos.dx));

      await testDb.close();
    });

    testWidgets('removes a currency month transactions with confirmation dialog', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      final testDb = AppDatabase(NativeDatabase.memory());
      await testDb.ensureTablesExist();
      final repository = FinancialRepository(testDb);

      final now = DateTime.now();

      await repository.addTransaction(
        title: 'EUR Temporary Income',
        amount: 800.0,
        type: FinancialTransactionType.income,
        date: DateTime(now.year, now.month, 4),
        currencyCode: 'EUR',
      );

      await tester.pumpWidget(_buildTestWidget(testDb));
      await tester.pumpAndSettle();

      // Ensure EUR is selected/active
      if (find.byKey(const Key('currency_chip_EUR')).evaluate().isNotEmpty) {
        await tester.tap(find.byKey(const Key('currency_chip_EUR')));
        await tester.pumpAndSettle();
      }

      expect(find.text('EUR Temporary Income'), findsOneWidget);
      expect(tester.widget<Text>(find.byKey(const Key('monthly_incomes_sum_text'))).data, contains('800.00'));

      // Verify only the small button at the top right is present, not the big chip
      expect(find.byKey(const Key('delete_active_currency_button')), findsOneWidget);
      expect(find.byKey(const Key('delete_active_currency_chip')), findsNothing);
      await tester.tap(find.byKey(const Key('delete_active_currency_button')));
      await tester.pumpAndSettle();

      // Confirmation dialog is shown
      expect(find.byKey(const Key('confirm_delete_currency_button')), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);

      // Tap cancel first to verify it doesn't delete
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('EUR Temporary Income'), findsOneWidget);

      // Tap delete currency again and confirm
      await tester.tap(find.byKey(const Key('delete_active_currency_button')));
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(const Key('confirm_delete_currency_button')));
      await tester.pumpAndSettle();

      // EUR transaction is deleted from the ledger
      expect(find.text('EUR Temporary Income'), findsNothing);
      expect(find.byKey(const Key('currency_chip_EUR')), findsNothing);

      await testDb.close();
    });
  });
}
