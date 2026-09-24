import 'package:drift/drift.dart';

/// SQLite table definition for custom financial categories.
/// Table name in SQLite: "financial_categories".
@DataClassName('FinancialCategoryData')
class FinancialCategories extends Table {
  @override
  String get tableName => 'financial_categories';

  /// Unique identifier (UUID string)
  TextColumn get id => text()();

  /// Category name (e.g. 'Pet Care', 'Gym', 'Gifts')
  TextColumn get name => text()();

  /// Whether this is a user-created custom category
  BoolColumn get isCustom => boolean().withDefault(const Constant(true))();

  /// Timestamp when created
  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
