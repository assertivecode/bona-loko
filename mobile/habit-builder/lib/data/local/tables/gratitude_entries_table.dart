import 'package:drift/drift.dart';

/// SQLite table definition for Gratitude Entries.
/// Table name in SQLite: "gratitude_entries".
@DataClassName('GratitudeEntryData')
class GratitudeEntries extends Table {
  @override
  String get tableName => 'gratitude_entries';

  /// Unique identifier (UUID string)
  TextColumn get id => text()();

  /// The text content of the gratitude reason / reflection
  TextColumn get content => text()();

  /// Timestamp when the entry was recorded
  DateTimeColumn get createdAt => dateTime()();

  /// The period/context of the reflection ('morning', 'evening', 'anytime')
  TextColumn get period => text().nullable()();

  /// User preference ordering index
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// SQLite table definition for Daily Gratitude Completions (morning 1 min & night 5 min).
/// Table name in SQLite: "daily_gratitude_completions".
@DataClassName('DailyGratitudeCompletionData')
class DailyGratitudeCompletions extends Table {
  @override
  String get tableName => 'daily_gratitude_completions';

  /// Unique identifier (UUID string)
  TextColumn get id => text()();

  /// Calendar date of the completion (normalized to midnight)
  DateTimeColumn get date => dateTime()();

  /// Whether morning grounding (1 min) was completed
  BoolColumn get morningCompleted => boolean().withDefault(const Constant(false))();

  /// Timestamp when morning grounding was completed
  DateTimeColumn get morningCompletedAt => dateTime().nullable()();

  /// Whether evening reflection (5 min) was completed
  BoolColumn get eveningCompleted => boolean().withDefault(const Constant(false))();

  /// Timestamp when evening reflection was completed
  DateTimeColumn get eveningCompletedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
