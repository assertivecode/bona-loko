import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/financial_repository.dart';
import '../../domain/models/financial_transaction.dart';

/// StateProvider holding the currently selected month for financial management.
/// Defaults to the 1st day of the current calendar month.
final selectedFinancialMonthProvider = StateProvider<DateTime>((ref) {
  final now = DateTime.now();
  return DateTime(now.year, now.month, 1);
});

/// StateProvider holding the currently active currency filter for the month.
/// If null, the view defaults to the first available currency in the month or locale default.
final selectedFinancialCurrencyProvider = StateProvider<String?>((ref) => null);

/// Controller for financial transactions management and month navigation.
class FinancialController {
  final Ref _ref;

  FinancialController(this._ref);

  DateTime get selectedMonth => _ref.read(selectedFinancialMonthProvider);
  String? get selectedCurrency => _ref.read(selectedFinancialCurrencyProvider);

  void setMonth(DateTime month) {
    _ref.read(selectedFinancialMonthProvider.notifier).state =
        DateTime(month.year, month.month, 1);
    _ref.read(selectedFinancialCurrencyProvider.notifier).state = null;
  }

  void previousMonth() {
    final current = _ref.read(selectedFinancialMonthProvider);
    final prev = DateTime(current.year, current.month - 1, 1);
    _ref.read(selectedFinancialMonthProvider.notifier).state = prev;
    _ref.read(selectedFinancialCurrencyProvider.notifier).state = null;
  }

  void nextMonth() {
    final current = _ref.read(selectedFinancialMonthProvider);
    final next = DateTime(current.year, current.month + 1, 1);
    _ref.read(selectedFinancialMonthProvider.notifier).state = next;
    _ref.read(selectedFinancialCurrencyProvider.notifier).state = null;
  }

  void jumpToCurrentMonth() {
    final now = DateTime.now();
    _ref.read(selectedFinancialMonthProvider.notifier).state =
        DateTime(now.year, now.month, 1);
    _ref.read(selectedFinancialCurrencyProvider.notifier).state = null;
  }

  void setCurrency(String currencyCode) {
    _ref.read(selectedFinancialCurrencyProvider.notifier).state = currencyCode.toUpperCase();
  }

  Future<void> registerMonthCurrency(int year, int month, String currencyCode) async {
    final repo = _ref.read(financialRepositoryProvider);
    await repo.registerCurrencyForMonth(year, month, currencyCode);
    setCurrency(currencyCode);
  }

  Future<void> deleteMonthCurrencyTransactions(int year, int month, String currencyCode) async {
    final repo = _ref.read(financialRepositoryProvider);
    await repo.deleteMonthCurrencyTransactions(
      year: year,
      month: month,
      currencyCode: currencyCode,
    );
    _ref.read(selectedFinancialCurrencyProvider.notifier).state = null;
  }

  Future<void> addTransaction({
    required String title,
    required double amount,
    required FinancialTransactionType type,
    required DateTime date,
    String? category,
    String currencyCode = 'USD',
  }) async {
    final repo = _ref.read(financialRepositoryProvider);
    await repo.addTransaction(
      title: title,
      amount: amount,
      type: type,
      date: date,
      category: category,
      currencyCode: currencyCode,
    );
  }

  Future<void> deleteTransaction(String id) async {
    final repo = _ref.read(financialRepositoryProvider);
    await repo.deleteTransaction(id);
  }

  Future<void> updateTransaction(FinancialTransaction tx) async {
    final repo = _ref.read(financialRepositoryProvider);
    await repo.updateTransaction(tx);
  }

  Future<FinancialCategoryItem> addCustomCategory(String name) async {
    final repo = _ref.read(financialRepositoryProvider);
    return await repo.addCustomCategory(name);
  }
}

/// Provider for [FinancialController].
final financialControllerProvider = Provider<FinancialController>((ref) {
  return FinancialController(ref);
});
