import 'package:drift/drift.dart';

/// SQLite table definition for registered currencies per calendar month.
/// Table name in SQLite: "monthly_currencies".
@DataClassName('MonthlyCurrencyData')
class MonthlyCurrencies extends Table {
  @override
  String get tableName => 'monthly_currencies';

  /// Calendar year (e.g. 2026)
  IntColumn get year => integer()();

  /// Calendar month (1 to 12)
  IntColumn get month => integer()();

  /// Currency ISO code (e.g. 'USD', 'BRL', 'EUR')
  TextColumn get currencyCode => text()();

  /// Timestamp when registered
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {year, month, currencyCode};
}
