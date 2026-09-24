import 'package:drift/drift.dart';

/// SQLite table definition for Financial Transactions (Incomes and Outcomes/Expenses).
/// Table name in SQLite: "financial_transactions".
@DataClassName('FinancialTransactionData')
class FinancialTransactions extends Table {
  @override
  String get tableName => 'financial_transactions';

  /// Unique identifier (UUID string)
  TextColumn get id => text()();

  /// Title or short description (e.g., 'Monthly Salary', 'Supermarket')
  TextColumn get title => text()();

  /// Monetary amount (non-negative)
  RealColumn get amount => real()();

  /// Transaction type ('income' or 'expense')
  TextColumn get type => text()();

  /// Calendar date of the transaction
  DateTimeColumn get date => dateTime()();

  /// Category tag (e.g., 'salary', 'food', 'housing', etc.)
  TextColumn get category => text().nullable()();

  /// Currency code (e.g., 'USD', 'BRL', 'EUR')
  TextColumn get currencyCode => text().withDefault(const Constant('USD'))();

  /// Timestamp when recorded
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
