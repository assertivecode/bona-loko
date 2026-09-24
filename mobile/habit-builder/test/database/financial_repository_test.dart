import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/repositories/financial_repository.dart';
import 'package:habit_builder/domain/models/financial_transaction.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('FinancialRepository Database & CQRS Tests', () {
    late AppDatabase database;
    late FinancialRepository repository;

    setUp(() async {
      database = AppDatabase(NativeDatabase.memory());
      await database.ensureTablesExist();
      repository = FinancialRepository(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('adds incomes and expenses and streams monthly transactions sorted by date desc', () async {
      final sept10 = DateTime(2026, 9, 10, 14, 0);
      final sept15 = DateTime(2026, 9, 15, 18, 30);
      final aug20 = DateTime(2026, 8, 20, 10, 0);

      await repository.addTransaction(
        title: 'Initial Freelance',
        amount: 800.0,
        type: FinancialTransactionType.income,
        date: sept10,
        category: FinancialCategory.freelance,
      );

      await repository.addTransaction(
        title: 'Supermarket Groceries',
        amount: 250.0,
        type: FinancialTransactionType.expense,
        date: sept15,
        category: FinancialCategory.food,
      );

      // August transaction (different month)
      await repository.addTransaction(
        title: 'Old August Expense',
        amount: 120.0,
        type: FinancialTransactionType.expense,
        date: aug20,
        category: FinancialCategory.other,
      );

      final septTransactions = await repository.watchTransactionsForMonth(2026, 9).first;
      expect(septTransactions.length, 2);
      // Latest date first: Sept 15 then Sept 10
      expect(septTransactions[0].title, 'Supermarket Groceries');
      expect(septTransactions[0].amount, 250.0);
      expect(septTransactions[0].type.isExpense, isTrue);

      expect(septTransactions[1].title, 'Initial Freelance');
      expect(septTransactions[1].amount, 800.0);
      expect(septTransactions[1].type.isIncome, isTrue);
    });

    test('calculates monthly summary with sums of incomes, expenses, and net balance', () async {
      final now = DateTime(2026, 9, 12);

      await repository.addTransaction(
        title: 'Salary Deposit',
        amount: 3200.0,
        type: FinancialTransactionType.income,
        date: now,
      );

      await repository.addTransaction(
        title: 'Investment Dividend',
        amount: 300.0,
        type: FinancialTransactionType.income,
        date: now,
      );

      await repository.addTransaction(
        title: 'Apartment Rent',
        amount: 1100.0,
        type: FinancialTransactionType.expense,
        date: now,
      );

      await repository.addTransaction(
        title: 'Electric Bill',
        amount: 90.0,
        type: FinancialTransactionType.expense,
        date: now,
      );

      final summary = await repository.watchMonthlySummary(2026, 9).first;
      expect(summary.year, 2026);
      expect(summary.month, 9);
      expect(summary.totalIncome, 3500.0);
      expect(summary.totalExpense, 1190.0);
      expect(summary.netBalance, 2310.0);
    });

    test('deleting a transaction updates monthly transactions and summary', () async {
      final tx = await repository.addTransaction(
        title: 'To be deleted',
        amount: 150.0,
        type: FinancialTransactionType.expense,
        date: DateTime(2026, 9, 5),
      );

      var list = await repository.watchTransactionsForMonth(2026, 9).first;
      expect(list.length, 1);

      await repository.deleteTransaction(tx.id);

      list = await repository.watchTransactionsForMonth(2026, 9).first;
      expect(list.isEmpty, isTrue);

      final summary = await repository.watchMonthlySummary(2026, 9).first;
      expect(summary.totalExpense, 0.0);
    });

    test('creates, streams, and deletes custom financial categories', () async {
      final initialCategories = await repository.watchCustomCategories().first;
      expect(initialCategories.isEmpty, isTrue);

      final cat1 = await repository.addCustomCategory('Pet Care');
      expect(cat1.name, 'Pet Care');
      expect(cat1.isCustom, isTrue);

      final cat2 = await repository.addCustomCategory('Gym Membership');
      expect(cat2.name, 'Gym Membership');

      final list = await repository.watchCustomCategories().first;
      expect(list.length, 2);
      expect(list.map((c) => c.name), containsAll(['Pet Care', 'Gym Membership']));

      await repository.deleteCustomCategory(cat1.id);
      final remaining = await repository.watchCustomCategories().first;
      expect(remaining.length, 1);
      expect(remaining.first.name, 'Gym Membership');
    });

    test('manages monthly currencies and filters transactions and summaries by currency', () async {
      // 1. Initial currencies for month should return default currency 'BRL'
      final initialCurrencies = await repository.watchCurrenciesForMonth(2026, 9, defaultCurrency: 'BRL').first;
      expect(initialCurrencies, ['BRL']);

      // 2. Register 'USD' and 'EUR' for 2026-09
      await repository.registerCurrencyForMonth(2026, 9, 'USD');
      await repository.registerCurrencyForMonth(2026, 9, 'EUR');

      final updatedCurrencies = await repository.watchCurrenciesForMonth(2026, 9).first;
      expect(updatedCurrencies, containsAll(['USD', 'EUR']));

      // 3. Add transactions in different currencies
      await repository.addTransaction(
        title: 'BRL Salary',
        amount: 5000.0,
        type: FinancialTransactionType.income,
        date: DateTime(2026, 9, 5),
        currencyCode: 'BRL',
      );

      final currenciesWithBrl = await repository.watchCurrenciesForMonth(2026, 9).first;
      expect(currenciesWithBrl, containsAll(['BRL', 'USD', 'EUR']));

      await repository.addTransaction(
        title: 'USD Remote Consulting',
        amount: 1200.0,
        type: FinancialTransactionType.income,
        date: DateTime(2026, 9, 6),
        currencyCode: 'USD',
      );

      await repository.addTransaction(
        title: 'USD SaaS Subscription',
        amount: 50.0,
        type: FinancialTransactionType.expense,
        date: DateTime(2026, 9, 7),
        currencyCode: 'USD',
      );

      // 4. Verify transactions filtered by currency
      final brlTxs = await repository.watchTransactionsForMonth(2026, 9, currencyCode: 'BRL').first;
      expect(brlTxs.length, 1);
      expect(brlTxs.first.title, 'BRL Salary');

      final usdTxs = await repository.watchTransactionsForMonth(2026, 9, currencyCode: 'USD').first;
      expect(usdTxs.length, 2);
      expect(usdTxs.map((t) => t.title), containsAll(['USD Remote Consulting', 'USD SaaS Subscription']));

      // 5. Verify summaries filtered by currency
      final brlSummary = await repository.watchMonthlySummary(2026, 9, currencyCode: 'BRL').first;
      expect(brlSummary.totalIncome, 5000.0);
      expect(brlSummary.totalExpense, 0.0);
      expect(brlSummary.netBalance, 5000.0);

      final usdSummary = await repository.watchMonthlySummary(2026, 9, currencyCode: 'USD').first;
      expect(usdSummary.totalIncome, 1200.0);
      expect(usdSummary.totalExpense, 50.0);
      expect(usdSummary.netBalance, 1150.0);

      // 6. Delete all USD transactions and unregister USD for 2026-09
      await repository.deleteMonthCurrencyTransactions(year: 2026, month: 9, currencyCode: 'USD');

      final remainingCurrencies = await repository.watchCurrenciesForMonth(2026, 9).first;
      expect(remainingCurrencies, isNot(contains('USD')));
      expect(remainingCurrencies, contains('BRL'));

      final remainingUsdTxs = await repository.watchTransactionsForMonth(2026, 9, currencyCode: 'USD').first;
      expect(remainingUsdTxs, isEmpty);

      final remainingBrlTxs = await repository.watchTransactionsForMonth(2026, 9, currencyCode: 'BRL').first;
      expect(remainingBrlTxs.length, 1);
    });
  });
}
