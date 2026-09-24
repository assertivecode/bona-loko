import 'package:drift/drift.dart';

/// SQLite table definition for Assessment sessions.
class Assessments extends Table {
  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get completedAt => dateTime().nullable()();
  TextColumn get status => text()(); // 'draft' | 'completed'

  @override
  Set<Column> get primaryKey => {id};
}

/// SQLite table definition for individual Life Area scores within an assessment.
class AssessmentAreaScores extends Table {
  TextColumn get id => text()();
  TextColumn get assessmentId => text().references(Assessments, #id, onDelete: KeyAction.cascade)();
  TextColumn get areaKey => text()(); // e.g., 'health_fitness', 'focus_mastery'
  IntColumn get currentPriority => integer()(); // P in [1, 10]
  IntColumn get currentState => integer()(); // S in [1, 10]
  IntColumn get currentInvestment => integer()(); // I_curr in [1, 10]
  IntColumn get desiredInvestment => integer()(); // I_des in [1, 10]
  TextColumn get intent => text()(); // 'improve' | 'maintain' | 'deprioritize'
  IntColumn get investmentDelta => integer()(); // ΔI = I_des - I_curr
  RealColumn get priorityGapScore => real()(); // G = max(0, ΔI) * (P / 10)

  @override
  Set<Column> get primaryKey => {id};
}
