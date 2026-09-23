import 'package:drift/drift.dart';
import '../../../domain/models/life_area.dart';

/// TypeConverter to persist [LifeArea] enum as a 1-based integer in SQLite:
/// 1 = health_fitness, ..., 12 = contribution_legacy.
class LifeAreaConverter extends TypeConverter<LifeArea, int> {
  const LifeAreaConverter();

  @override
  LifeArea fromSql(int fromDb) => LifeArea.fromValue(fromDb);

  @override
  int toSql(LifeArea value) => value.value;
}

/// SQLite table definition for individual Life Area evaluations.
/// Table name in SQLite: "life_areas_evaluations".
@DataClassName('LifeAreaEvaluationData')
class LifeAreasEvaluations extends Table {
  @override
  String get tableName => 'life_areas_evaluations';

  /// Unique identifier (UUID string)
  TextColumn get id => text()();

  /// Canonical Life Area enum (stored as 1-based integer 1..12)
  IntColumn get lifeArea => integer().map(const LifeAreaConverter())();

  /// Satisfaction / state score (0.0 to 10.0 supporting half-decimals: 0, 0.5, 1, 1.5, ..., 10.0)
  RealColumn get score => real()();

  /// Current priority to focus / practice (1 to 5, where 5 is highest priority)
  IntColumn get currentPriority => integer()();

  /// Timestamp when the evaluation was recorded
  DateTimeColumn get evaluatedAt => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
