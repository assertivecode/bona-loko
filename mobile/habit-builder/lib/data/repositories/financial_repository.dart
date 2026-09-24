import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/currency.dart';
import '../../domain/models/financial_transaction.dart';
import '../local/app_database.dart';
import '../local/database_provider.dart';

/// Repository for persisting, querying, and aggregating financial transactions (incomes and expenses)
/// as well as custom financial categories in SQLite.
class FinancialRepository {
  final AppDatabase _db;
  static const _uuid = Uuid();

  FinancialRepository(this._db);

  FinancialTransaction _toDomain(FinancialTransactionData row) {
    return FinancialTransaction(
      id: row.id,
      title: row.title,
      amount: row.amount,
      type: FinancialTransactionType.fromString(row.type),
      date: row.date,
      category: row.category,
      currencyCode: row.currencyCode,
      createdAt: row.createdAt,
    );
  }

  FinancialTransactionsCompanion _toCompanion(FinancialTransaction tx) {
    return FinancialTransactionsCompanion.insert(
      id: tx.id.isNotEmpty ? tx.id : _uuid.v4(),
      title: tx.title,
      amount: tx.amount,
      type: tx.type.name,
      date: tx.date,
      category: Value(tx.category),
      currencyCode: Value(tx.currencyCode),
      createdAt: tx.createdAt,
    );
  }

  /// Streams all transactions recorded in a specific month, optionally filtered by currency code, ordered by date descending.
  Stream<List<FinancialTransaction>> watchTransactionsForMonth(
    int year,
    int month, {
    String? currencyCode,
  }) async* {
    await _db.ensureTablesExist();
    final startOfMonth = DateTime(year, month, 1);
    final endOfMonth = month == 12 ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);

    yield* (_db.select(_db.financialTransactions)
          ..where((t) {
            final dateFilter = t.date.isBiggerOrEqualValue(startOfMonth) &
                t.date.isSmallerThanValue(endOfMonth);
            if (currencyCode != null && currencyCode.isNotEmpty) {
              return dateFilter & t.currencyCode.equals(currencyCode.toUpperCase());
            }
            return dateFilter;
          })
          ..orderBy([
            (t) => OrderingTerm.desc(t.date),
            (t) => OrderingTerm.desc(t.createdAt),
          ]))
        .watch()
        .map((rows) => rows.map(_toDomain).toList());
  }

  /// Streams an aggregated monthly financial summary for the given month and optional currency.
  Stream<MonthlyFinancialSummary> watchMonthlySummary(
    int year,
    int month, {
    String? currencyCode,
  }) {
    return watchTransactionsForMonth(year, month, currencyCode: currencyCode).map(
      (transactions) => MonthlyFinancialSummary.fromTransactions(
        year: year,
        month: month,
        transactions: transactions,
      ),
    );
  }

  /// Streams distinct registered currencies for a specific calendar month.
  /// Combines explicitly registered currencies from `monthly_currencies` with any
  /// distinct currency codes found in recorded `financial_transactions` for that month.
  Stream<List<String>> watchCurrenciesForMonth(
    int year,
    int month, {
    String defaultCurrency = 'USD',
  }) {
    final startOfMonth = DateTime(year, month, 1);
    final endOfMonth = month == 12 ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);

    final query = _db.customSelect(
      '''
      SELECT currency_code FROM monthly_currencies WHERE year = ? AND month = ?
      UNION
      SELECT currency_code FROM financial_transactions WHERE date >= ? AND date < ?
      ''',
      variables: [
        Variable.withInt(year),
        Variable.withInt(month),
        Variable.withDateTime(startOfMonth),
        Variable.withDateTime(endOfMonth),
      ],
      readsFrom: {_db.monthlyCurrencies, _db.financialTransactions},
    );

    return query.watch().map((rows) {
      final list = rows
          .map((r) => r.read<String>('currency_code').toUpperCase().trim())
          .where((c) => c.isNotEmpty)
          .toList();
      if (list.isEmpty) {
        return [defaultCurrency.toUpperCase()];
      }
      list.sort((a, b) {
        final rankA = Currency.fromCode(a)?.rank ?? 999;
        final rankB = Currency.fromCode(b)?.rank ?? 999;
        return rankA.compareTo(rankB);
      });
      return list;
    });
  }

  /// Registers a currency for a specific calendar month in `monthly_currencies`.
  Future<void> registerCurrencyForMonth(int year, int month, String currencyCode) async {
    await _db.ensureTablesExist();
    final normalized = currencyCode.trim().toUpperCase();
    await _db.into(_db.monthlyCurrencies).insert(
          MonthlyCurrenciesCompanion.insert(
            year: year,
            month: month,
            currencyCode: normalized,
            createdAt: DateTime.now(),
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  /// Adds a new financial transaction (income or expense).
  Future<FinancialTransaction> addTransaction({
    required String title,
    required double amount,
    required FinancialTransactionType type,
    required DateTime date,
    String? category,
    String currencyCode = 'USD',
  }) async {
    await _db.ensureTablesExist();
    final newId = _uuid.v4();
    final now = DateTime.now();
    final normalizedCurrency = currencyCode.trim().toUpperCase();
    final tx = FinancialTransaction(
      id: newId,
      title: title.trim(),
      amount: amount,
      type: type,
      date: date,
      category: category,
      currencyCode: normalizedCurrency,
      createdAt: now,
    );

    await _db.into(_db.financialTransactions).insert(_toCompanion(tx));
    await registerCurrencyForMonth(date.year, date.month, normalizedCurrency);
    return tx;
  }

  /// Deletes a financial transaction by its ID.
  Future<void> deleteTransaction(String id) async {
    await _db.ensureTablesExist();
    await (_db.delete(_db.financialTransactions)..where((t) => t.id.equals(id))).go();
  }

  /// Deletes all financial transactions for a specific month and currency,
  /// and removes the currency registration for that month from `monthly_currencies`.
  Future<void> deleteMonthCurrencyTransactions({
    required int year,
    required int month,
    required String currencyCode,
  }) async {
    await _db.ensureTablesExist();
    final normalized = currencyCode.trim().toUpperCase();
    final startOfMonth = DateTime(year, month, 1);
    final endOfMonth = month == 12 ? DateTime(year + 1, 1, 1) : DateTime(year, month + 1, 1);

    // 1. Delete all transactions matching date range and currency
    await (_db.delete(_db.financialTransactions)
          ..where((t) =>
              t.date.isBiggerOrEqualValue(startOfMonth) &
              t.date.isSmallerThanValue(endOfMonth) &
              t.currencyCode.equals(normalized)))
        .go();

    // 2. Delete entry from monthly_currencies
    await (_db.delete(_db.monthlyCurrencies)
          ..where((t) =>
              t.year.equals(year) &
              t.month.equals(month) &
              t.currencyCode.equals(normalized)))
        .go();
  }

  /// Updates an existing financial transaction.
  Future<void> updateTransaction(FinancialTransaction tx) async {
    await _db.ensureTablesExist();
    final normalizedCurrency = tx.currencyCode.trim().toUpperCase();
    await (_db.update(_db.financialTransactions)..where((t) => t.id.equals(tx.id))).write(
      FinancialTransactionsCompanion(
        title: Value(tx.title),
        amount: Value(tx.amount),
        type: Value(tx.type.name),
        date: Value(tx.date),
        category: Value(tx.category),
        currencyCode: Value(normalizedCurrency),
      ),
    );
    await registerCurrencyForMonth(tx.date.year, tx.date.month, normalizedCurrency);
  }

  /// Streams custom categories created by the user.
  Stream<List<FinancialCategoryItem>> watchCustomCategories() async* {
    await _db.ensureTablesExist();
    yield* (_db.select(_db.financialCategories)
          ..orderBy([(t) => OrderingTerm.asc(t.name)]))
        .watch()
        .map((rows) => rows
            .map((r) => FinancialCategoryItem(
                  id: r.id,
                  name: r.name,
                  isCustom: r.isCustom,
                ))
            .toList());
  }

  /// Adds a new custom category.
  Future<FinancialCategoryItem> addCustomCategory(String name) async {
    await _db.ensureTablesExist();
    final trimmed = name.trim();
    final id = _uuid.v4();
    final now = DateTime.now();
    await _db.into(_db.financialCategories).insert(
          FinancialCategoriesCompanion.insert(
            id: id,
            name: trimmed,
            isCustom: const Value(true),
            createdAt: now,
          ),
        );
    return FinancialCategoryItem(id: id, name: trimmed, isCustom: true);
  }

  /// Deletes a custom category by its ID.
  Future<void> deleteCustomCategory(String id) async {
    await _db.ensureTablesExist();
    await (_db.delete(_db.financialCategories)..where((t) => t.id.equals(id))).go();
  }
}

/// Query filter for monthly financial queries scoped by month and optional currency.
class MonthlyQueryFilter {
  final DateTime monthDate;
  final String? currencyCode;

  const MonthlyQueryFilter(this.monthDate, [this.currencyCode]);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MonthlyQueryFilter &&
          runtimeType == other.runtimeType &&
          monthDate.year == other.monthDate.year &&
          monthDate.month == other.monthDate.month &&
          currencyCode == other.currencyCode;

  @override
  int get hashCode => Object.hash(monthDate.year, monthDate.month, currencyCode);
}

/// Provider for [FinancialRepository].
final financialRepositoryProvider = Provider<FinancialRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return FinancialRepository(db);
});

/// Family StreamProvider for registered currencies in a month.
final monthlyCurrenciesStreamProvider =
    StreamProvider.family<List<String>, DateTime>((ref, monthDate) {
  final repo = ref.watch(financialRepositoryProvider);
  return repo.watchCurrenciesForMonth(monthDate.year, monthDate.month);
});

/// Family StreamProvider for transactions across all currencies for a given month.
final monthlyTransactionsStreamProvider =
    StreamProvider.family<List<FinancialTransaction>, DateTime>((ref, monthDate) {
  final repo = ref.watch(financialRepositoryProvider);
  return repo.watchTransactionsForMonth(
    monthDate.year,
    monthDate.month,
  );
});

/// Family StreamProvider for monthly summary across all currencies for a given month.
final monthlySummaryStreamProvider =
    StreamProvider.family<MonthlyFinancialSummary, DateTime>((ref, monthDate) {
  final repo = ref.watch(financialRepositoryProvider);
  return repo.watchMonthlySummary(
    monthDate.year,
    monthDate.month,
  );
});

/// Family StreamProvider for transactions filtered by month and specific currency.
final monthlyFilteredTransactionsStreamProvider =
    StreamProvider.family<List<FinancialTransaction>, MonthlyQueryFilter>((ref, filter) {
  final repo = ref.watch(financialRepositoryProvider);
  return repo.watchTransactionsForMonth(
    filter.monthDate.year,
    filter.monthDate.month,
    currencyCode: filter.currencyCode,
  );
});

/// Family StreamProvider for monthly summary filtered by month and specific currency.
final monthlyFilteredSummaryStreamProvider =
    StreamProvider.family<MonthlyFinancialSummary, MonthlyQueryFilter>((ref, filter) {
  final repo = ref.watch(financialRepositoryProvider);
  return repo.watchMonthlySummary(
    filter.monthDate.year,
    filter.monthDate.month,
    currencyCode: filter.currencyCode,
  );
});

/// StreamProvider for custom categories.
final customCategoriesStreamProvider =
    StreamProvider<List<FinancialCategoryItem>>((ref) {
  final repo = ref.watch(financialRepositoryProvider);
  return repo.watchCustomCategories();
});
