import 'package:drift/drift.dart';

/// SQLite table definition for Physical Activities.
/// Table name in SQLite: "physical_activities".
@DataClassName('PhysicalActivityData')
class PhysicalActivities extends Table {
  @override
  String get tableName => 'physical_activities';

  /// Unique identifier (UUID string)
  TextColumn get id => text()();

  /// Canonical activity type key ('walking', 'running', 'cycling', etc.)
  TextColumn get activityType => text()();

  /// Optional custom title or display name
  TextColumn get customName => text().nullable()();

  /// Target metric type ('duration' | 'repetitions')
  TextColumn get metricType => text()();

  /// Target value (e.g. 30 for 30 minutes, 50 for 50 reps)
  IntColumn get targetValue => integer()();

  /// Creation timestamp
  DateTimeColumn get createdAt => dateTime()();

  /// Whether this activity is active in the daily routine
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}

/// SQLite table definition for Daily Activity Completions.
/// Table name in SQLite: "daily_activities_completions".
@DataClassName('DailyActivityCompletionData')
class DailyActivitiesCompletions extends Table {
  @override
  String get tableName => 'daily_activities_completions';

  /// Unique identifier (UUID string)
  TextColumn get id => text()();

  /// Activity ID referencing physical_activities(id)
  TextColumn get activityId => text().references(PhysicalActivities, #id, onDelete: KeyAction.cascade)();

  /// Calendar date of the completion (normalized to midnight)
  DateTimeColumn get date => dateTime()();

  /// Whether the activity was completed on this date
  BoolColumn get completed => boolean().withDefault(const Constant(false))();

  /// Timestamp when marked as completed
  DateTimeColumn get completedAt => dateTime().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}
