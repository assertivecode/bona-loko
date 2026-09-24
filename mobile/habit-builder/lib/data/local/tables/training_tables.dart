import 'package:drift/drift.dart';

/// Table storing configured workout groups (groups of routines).
/// Table name in SQLite: "workout_groups".
@DataClassName('WorkoutGroupData')
class WorkoutGroups extends Table {
  @override
  String get tableName => 'workout_groups';

  TextColumn get id => text()();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table storing configured workout routines inside a group.
/// Table name in SQLite: "workout_routines".
@DataClassName('WorkoutRoutineData')
class WorkoutRoutines extends Table {
  @override
  String get tableName => 'workout_routines';

  TextColumn get id => text()();
  TextColumn get groupId => text().references(WorkoutGroups, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get description => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table storing exercises configured inside a workout routine.
/// Table name in SQLite: "training_exercises".
@DataClassName('TrainingExerciseData')
class TrainingExercises extends Table {
  @override
  String get tableName => 'training_exercises';

  TextColumn get id => text()();
  TextColumn get routineId => text().references(WorkoutRoutines, #id, onDelete: KeyAction.cascade)();
  TextColumn get name => text()();
  TextColumn get activityType => text()();
  IntColumn get targetSets => integer().withDefault(const Constant(3))();
  IntColumn get targetDurationSeconds => integer().nullable()();
  IntColumn get targetRepetitions => integer().nullable()();
  RealColumn get targetWeightKg => real().nullable()();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

/// Table storing daily executed workout sessions.
/// Table name in SQLite: "daily_training_sessions".
@DataClassName('DailyTrainingSessionData')
class DailyTrainingSessions extends Table {
  @override
  String get tableName => 'daily_training_sessions';

  TextColumn get id => text()();
  TextColumn get routineId => text().nullable()();
  TextColumn get routineName => text()();
  TextColumn get groupName => text().nullable()();
  DateTimeColumn get date => dateTime()();
  DateTimeColumn get startedAt => dateTime()();
  DateTimeColumn get concludedAt => dateTime().nullable()();
  TextColumn get status => text().withDefault(const Constant('in_progress'))(); // 'in_progress' | 'completed'

  @override
  Set<Column> get primaryKey => {id};
}

/// Table storing the actual daily settings performed per exercise during a session.
/// Table name in SQLite: "daily_training_records".
@DataClassName('DailyTrainingRecordData')
class DailyTrainingRecords extends Table {
  @override
  String get tableName => 'daily_training_records';

  TextColumn get id => text()();
  TextColumn get sessionId => text().references(DailyTrainingSessions, #id, onDelete: KeyAction.cascade)();
  TextColumn get exerciseName => text()();
  TextColumn get activityType => text()();
  IntColumn get sets => integer().nullable().withDefault(const Constant(3))();
  IntColumn get durationSeconds => integer().nullable()();
  IntColumn get repetitions => integer().nullable()();
  RealColumn get weightKg => real().nullable()();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  IntColumn get orderIndex => integer().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}
