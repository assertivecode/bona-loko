import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/domain/models/financial_transaction.dart';

void main() {
  group('FinancialTransaction & MonthlyFinancialSummary Domain Tests', () {
    test('creates FinancialTransaction with default and custom values', () {
      final now = DateTime(2026, 9, 23, 10, 30);
      final tx = FinancialTransaction(
        id: 'tx-1',
        title: 'Monthly Salary',
        amount: 4500.0,
        type: FinancialTransactionType.income,
        date: now,
        category: FinancialCategory.salary,
        currencyCode: 'USD',
        createdAt: now,
      );

      expect(tx.id, 'tx-1');
      expect(tx.title, 'Monthly Salary');
      expect(tx.amount, 4500.0);
      expect(tx.type.isIncome, isTrue);
      expect(tx.type.isExpense, isFalse);
      expect(tx.category, 'salary');
      expect(tx.currencyCode, 'USD');
    });

    test('FinancialTransactionType.fromString handles variations', () {
      expect(FinancialTransactionType.fromString('income'), FinancialTransactionType.income);
      expect(FinancialTransactionType.fromString('INCOME'), FinancialTransactionType.income);
      expect(FinancialTransactionType.fromString('expense'), FinancialTransactionType.expense);
      expect(FinancialTransactionType.fromString('outcome'), FinancialTransactionType.expense);
      expect(FinancialTransactionType.fromString('anything_else'), FinancialTransactionType.expense);
    });

    test('calculates MonthlyFinancialSummary correctly for current month and ignores other months', () {
      final septDate1 = DateTime(2026, 9, 1);
      final septDate2 = DateTime(2026, 9, 15);
      final septDate3 = DateTime(2026, 9, 20);
      final augDate = DateTime(2026, 8, 25);
      final octDate = DateTime(2026, 10, 5);

      final transactions = [
        FinancialTransaction(
          id: '1',
          title: 'Salary',
          amount: 3000.0,
          type: FinancialTransactionType.income,
          date: septDate1,
          createdAt: septDate1,
        ),
        FinancialTransaction(
          id: '2',
          title: 'Freelance Design',
          amount: 500.0,
          type: FinancialTransactionType.income,
          date: septDate2,
          createdAt: septDate2,
        ),
        FinancialTransaction(
          id: '3',
          title: 'Rent',
          amount: 1000.0,
          type: FinancialTransactionType.expense,
          date: septDate2,
          createdAt: septDate2,
        ),
        FinancialTransaction(
          id: '4',
          title: 'Groceries',
          amount: 250.0,
          type: FinancialTransactionType.expense,
          date: septDate3,
          createdAt: septDate3,
        ),
        // Transactions from other months that should be excluded
        FinancialTransaction(
          id: '5',
          title: 'August Salary',
          amount: 3000.0,
          type: FinancialTransactionType.income,
          date: augDate,
          createdAt: augDate,
        ),
        FinancialTransaction(
          id: '6',
          title: 'October Expense',
          amount: 400.0,
          type: FinancialTransactionType.expense,
          date: octDate,
          createdAt: octDate,
        ),
      ];

      final summarySept = MonthlyFinancialSummary.fromTransactions(
        year: 2026,
        month: 9,
        transactions: transactions,
      );

      expect(summarySept.year, 2026);
      expect(summarySept.month, 9);
      expect(summarySept.totalIncome, 3500.0);
      expect(summarySept.totalExpense, 1250.0);
      expect(summarySept.netBalance, 2250.0);

      // August check
      final summaryAug = MonthlyFinancialSummary.fromTransactions(
        year: 2026,
        month: 8,
        transactions: transactions,
      );
      expect(summaryAug.totalIncome, 3000.0);
      expect(summaryAug.totalExpense, 0.0);
      expect(summaryAug.netBalance, 3000.0);
    });

    test('FinancialCategory.getIcon returns expected icons', () {
      expect(
        FinancialCategory.getIcon(FinancialCategory.salary, FinancialTransactionType.income),
        isNotNull,
      );
      expect(
        FinancialCategory.getIcon(FinancialCategory.housing, FinancialTransactionType.expense),
        isNotNull,
      );
      expect(
        FinancialCategory.getIcon(null, FinancialTransactionType.income),
        isNotNull,
      );
    });
  });
}
