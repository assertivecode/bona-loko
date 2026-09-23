import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/training.dart';
import '../local/app_database.dart';
import '../local/database_provider.dart';

/// Repository handling workout groups, routines inside groups, exercise configuration with sets,
/// daily session execution, and daily training records.
class TrainingRepository {
  final AppDatabase _db;
  static const _uuid = Uuid();

  TrainingRepository(this._db);

  DateTime _normalizeDate(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  TrainingExercise _exerciseToDomain(TrainingExerciseData row) {
    return TrainingExercise(
      id: row.id,
      routineId: row.routineId,
      name: row.name,
      activityType: row.activityType,
      targetSets: row.targetSets,
      targetDurationSeconds: row.targetDurationSeconds,
      targetRepetitions: row.targetRepetitions,
      targetWeightKg: row.targetWeightKg,
      orderIndex: row.orderIndex,
    );
  }

  DailyTrainingRecord _recordToDomain(DailyTrainingRecordData row) {
    return DailyTrainingRecord(
      id: row.id,
      sessionId: row.sessionId,
      exerciseName: row.exerciseName,
      activityType: row.activityType,
      sets: row.sets ?? 3,
      durationSeconds: row.durationSeconds,
      repetitions: row.repetitions,
      weightKg: row.weightKg,
      isCompleted: row.isCompleted,
      orderIndex: row.orderIndex,
    );
  }

  // ==========================================
  // Groups, Routines, and Exercises Methods
  // ==========================================

  /// Reactively streams all active workout groups with their routines and exercises.
  Stream<List<WorkoutGroup>> watchWorkoutGroups() {
    return _db
        .customSelect(
          'SELECT 1',
          readsFrom: {_db.workoutGroups, _db.workoutRoutines, _db.trainingExercises},
        )
        .watch()
        .asyncMap((_) async {
      return getWorkoutGroups();
    });
  }

  /// Fetches the full hierarchy of active workout groups, their routines, and exercises.
  Future<List<WorkoutGroup>> getWorkoutGroups() async {
    final groupRows = await (_db.select(_db.workoutGroups)
          ..where((t) => t.isActive.equals(true))
          ..orderBy([(t) => OrderingTerm.asc(t.orderIndex), (t) => OrderingTerm.asc(t.createdAt)]))
        .get();

    if (groupRows.isEmpty) return [];

    final routineRows = await (_db.select(_db.workoutRoutines)
          ..orderBy([(t) => OrderingTerm.asc(t.orderIndex), (t) => OrderingTerm.asc(t.createdAt)]))
        .get();

    final exerciseRows = await (_db.select(_db.trainingExercises)
          ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
        .get();

    final exercisesByRoutine = <String, List<TrainingExercise>>{};
    for (final exRow in exerciseRows) {
      final domainEx = _exerciseToDomain(exRow);
      exercisesByRoutine.putIfAbsent(exRow.routineId, () => []).add(domainEx);
    }

    final routinesByGroup = <String, List<WorkoutRoutine>>{};
    for (final rRow in routineRows) {
      final routineExercises = exercisesByRoutine[rRow.id] ?? [];
      final domainRoutine = WorkoutRoutine(
        id: rRow.id,
        groupId: rRow.groupId,
        name: rRow.name,
        description: rRow.description,
        createdAt: rRow.createdAt,
        orderIndex: rRow.orderIndex,
        exercises: routineExercises,
      );
      routinesByGroup.putIfAbsent(rRow.groupId, () => []).add(domainRoutine);
    }

    return groupRows.map((gRow) {
      final groupRoutines = routinesByGroup[gRow.id] ?? [];
      return WorkoutGroup(
        id: gRow.id,
        name: gRow.name,
        description: gRow.description,
        createdAt: gRow.createdAt,
        isActive: gRow.isActive,
        orderIndex: gRow.orderIndex,
        routines: groupRoutines,
      );
    }).toList();
  }

  /// Ensures a default Workout Group and initial Workout Routine exist with sample exercises.
  Future<WorkoutGroup> getOrCreateDefaultGroupAndRoutine({
    String defaultGroupName = 'Default Group',
    String defaultRoutineName = 'Sample Workout',
  }) async {
    final groups = await getWorkoutGroups();
    if (groups.isNotEmpty) {
      return groups.first;
    }

    final groupId = _uuid.v4();
    final now = DateTime.now();

    await _db.into(_db.workoutGroups).insert(
          WorkoutGroupsCompanion.insert(
            id: groupId,
            name: defaultGroupName,
            createdAt: now,
            isActive: const Value(true),
            orderIndex: const Value(0),
          ),
        );

    final routineId = _uuid.v4();
    await _db.into(_db.workoutRoutines).insert(
          WorkoutRoutinesCompanion.insert(
            id: routineId,
            groupId: groupId,
            name: defaultRoutineName,
            createdAt: now,
            orderIndex: const Value(0),
          ),
        );

    // Initial default exercise with sets: "Squats" - 3 sets of 25 repetitions
    final exerciseId = _uuid.v4();
    await _db.into(_db.trainingExercises).insert(
          TrainingExercisesCompanion.insert(
            id: exerciseId,
            routineId: routineId,
            name: 'Squats',
            activityType: 'repetition',
            targetSets: const Value(3),
            targetRepetitions: const Value(25),
            orderIndex: const Value(0),
          ),
        );

    final refreshedGroups = await getWorkoutGroups();
    return refreshedGroups.first;
  }

  /// Creates a new Workout Group.
  Future<WorkoutGroup> createGroup(String name, {String? description}) async {
    final current = await (_db.select(_db.workoutGroups)).get();
    final nextIndex = current.isEmpty
        ? 0
        : current.map((g) => g.orderIndex).reduce((a, b) => a > b ? a : b) + 1;

    final groupId = _uuid.v4();
    final now = DateTime.now();
    await _db.into(_db.workoutGroups).insert(
          WorkoutGroupsCompanion.insert(
            id: groupId,
            name: name.trim(),
            description: Value(description?.trim()),
            createdAt: now,
            isActive: const Value(true),
            orderIndex: Value(nextIndex),
          ),
        );

    return WorkoutGroup(
      id: groupId,
      name: name.trim(),
      description: description?.trim(),
      createdAt: now,
      isActive: true,
      orderIndex: nextIndex,
      routines: const [],
    );
  }

  /// Updates the name of a Workout Group.
  Future<void> updateGroupName(String groupId, String name) async {
    await (_db.update(_db.workoutGroups)..where((t) => t.id.equals(groupId))).write(
      WorkoutGroupsCompanion(name: Value(name.trim())),
    );
  }

  /// Deletes a Workout Group and its routines/exercises (via cascade delete).
  Future<void> deleteGroup(String groupId) async {
    await (_db.delete(_db.workoutGroups)..where((t) => t.id.equals(groupId))).go();
  }

  /// Creates a new Workout Routine inside a Group.
  Future<WorkoutRoutine> createRoutine({
    required String groupId,
    required String name,
    String? description,
  }) async {
    final current =
        await (_db.select(_db.workoutRoutines)..where((t) => t.groupId.equals(groupId))).get();
    final nextIndex = current.isEmpty
        ? 0
        : current.map((r) => r.orderIndex).reduce((a, b) => a > b ? a : b) + 1;

    final routineId = _uuid.v4();
    final now = DateTime.now();
    await _db.into(_db.workoutRoutines).insert(
          WorkoutRoutinesCompanion.insert(
            id: routineId,
            groupId: groupId,
            name: name.trim(),
            description: Value(description?.trim()),
            createdAt: now,
            orderIndex: Value(nextIndex),
          ),
        );

    return WorkoutRoutine(
      id: routineId,
      groupId: groupId,
      name: name.trim(),
      description: description?.trim(),
      createdAt: now,
      orderIndex: nextIndex,
      exercises: const [],
    );
  }

  /// Updates the name of a Workout Routine.
  Future<void> updateRoutineName(String routineId, String name) async {
    await (_db.update(_db.workoutRoutines)..where((t) => t.id.equals(routineId))).write(
      WorkoutRoutinesCompanion(name: Value(name.trim())),
    );
  }

  /// Deletes a Workout Routine and its exercises (via cascade delete).
  Future<void> deleteRoutine(String routineId) async {
    await (_db.delete(_db.workoutRoutines)..where((t) => t.id.equals(routineId))).go();
  }

  /// Reorders Workout Routines within a Group.
  Future<void> reorderRoutines(String groupId, List<String> orderedIds) async {
    await _db.transaction(() async {
      for (var i = 0; i < orderedIds.length; i++) {
        await (_db.update(_db.workoutRoutines)..where((t) => t.id.equals(orderedIds[i])))
            .write(WorkoutRoutinesCompanion(orderIndex: Value(i)));
      }
    });
  }

  /// Adds a new exercise into a Workout Routine.
  Future<TrainingExercise> addExercise({
    required String routineId,
    required String name,
    required String activityType, // 'duration' | 'repetition'
    int targetSets = 3,
    int? targetDurationSeconds,
    int? targetRepetitions,
    double? targetWeightKg,
  }) async {
    final current =
        await (_db.select(_db.trainingExercises)..where((t) => t.routineId.equals(routineId))).get();

    final nextIndex = current.isEmpty
        ? 0
        : current.map((e) => e.orderIndex).reduce((a, b) => a > b ? a : b) + 1;

    final exerciseId = _uuid.v4();
    await _db.into(_db.trainingExercises).insert(
          TrainingExercisesCompanion.insert(
            id: exerciseId,
            routineId: routineId,
            name: name.trim(),
            activityType: activityType,
            targetSets: Value(targetSets),
            targetDurationSeconds: Value(targetDurationSeconds),
            targetRepetitions: Value(targetRepetitions),
            targetWeightKg: Value(targetWeightKg),
            orderIndex: Value(nextIndex),
          ),
        );

    return TrainingExercise(
      id: exerciseId,
      routineId: routineId,
      name: name.trim(),
      activityType: activityType,
      targetSets: targetSets,
      targetDurationSeconds: targetDurationSeconds,
      targetRepetitions: targetRepetitions,
      targetWeightKg: targetWeightKg,
      orderIndex: nextIndex,
    );
  }

  /// Updates an exercise inside a routine.
  Future<void> updateExercise({
    required String exerciseId,
    String? name,
    String? activityType,
    int? targetSets,
    int? targetDurationSeconds,
    int? targetRepetitions,
    double? targetWeightKg,
  }) async {
    await (_db.update(_db.trainingExercises)..where((tbl) => tbl.id.equals(exerciseId))).write(
      TrainingExercisesCompanion(
        name: name != null ? Value(name.trim()) : const Value.absent(),
        activityType: activityType != null ? Value(activityType) : const Value.absent(),
        targetSets: targetSets != null ? Value(targetSets) : const Value.absent(),
        targetDurationSeconds:
            targetDurationSeconds != null ? Value(targetDurationSeconds) : const Value.absent(),
        targetRepetitions:
            targetRepetitions != null ? Value(targetRepetitions) : const Value.absent(),
        targetWeightKg: targetWeightKg != null ? Value(targetWeightKg) : const Value.absent(),
      ),
    );
  }

  /// Deletes an exercise from a routine.
  Future<void> deleteExercise(String exerciseId) async {
    await (_db.delete(_db.trainingExercises)..where((tbl) => tbl.id.equals(exerciseId))).go();
  }

  /// Reorders exercises within a workout routine.
  Future<void> reorderExercises(String routineId, List<String> orderedIds) async {
    await _db.transaction(() async {
      for (var i = 0; i < orderedIds.length; i++) {
        await (_db.update(_db.trainingExercises)..where((tbl) => tbl.id.equals(orderedIds[i])))
            .write(TrainingExercisesCompanion(orderIndex: Value(i)));
      }
    });
  }

  // ==========================================
  // Daily Training Session & Record Methods
  // ==========================================

  /// Reactively streams the latest daily session for today.
  Stream<DailyTrainingSession?> watchTodaySession() {
    final today = _normalizeDate(DateTime.now());
    return _db
        .select(_db.dailyTrainingSessions)
        .join([
          leftOuterJoin(
            _db.dailyTrainingRecords,
            _db.dailyTrainingRecords.sessionId.equalsExp(_db.dailyTrainingSessions.id),
          ),
        ])
        .watch()
        .map((rows) {
          final todayRows = rows.where((r) {
            final s = r.readTable(_db.dailyTrainingSessions);
            return s.date.year == today.year &&
                s.date.month == today.month &&
                s.date.day == today.day;
          }).toList();

          if (todayRows.isEmpty) return null;

          todayRows.sort((a, b) => b.readTable(_db.dailyTrainingSessions).startedAt.compareTo(
                a.readTable(_db.dailyTrainingSessions).startedAt,
              ));

          final sessionData = todayRows.first.readTable(_db.dailyTrainingSessions);
          final records = <DailyTrainingRecord>[];

          for (final r in todayRows) {
            final s = r.readTable(_db.dailyTrainingSessions);
            if (s.id == sessionData.id) {
              final recData = r.readTableOrNull(_db.dailyTrainingRecords);
              if (recData != null) {
                records.add(_recordToDomain(recData));
              }
            }
          }
          records.sort((a, b) => a.orderIndex.compareTo(b.orderIndex));

          return DailyTrainingSession(
            id: sessionData.id,
            routineId: sessionData.routineId,
            routineName: sessionData.routineName,
            groupName: sessionData.groupName,
            date: sessionData.date,
            startedAt: sessionData.startedAt,
            concludedAt: sessionData.concludedAt,
            status: sessionData.status,
            records: records,
          );
        });
  }

  /// Starts a training session for today based on the chosen Workout Routine.
  Future<DailyTrainingSession> startTraining(WorkoutRoutine routine, {String? groupName}) async {
    final sessionId = _uuid.v4();
    final now = DateTime.now();
    final today = _normalizeDate(now);

    await _db.transaction(() async {
      await _db.into(_db.dailyTrainingSessions).insert(
            DailyTrainingSessionsCompanion.insert(
              id: sessionId,
              routineId: Value(routine.id),
              routineName: routine.name,
              groupName: Value(groupName),
              date: today,
              startedAt: now,
              status: const Value('in_progress'),
            ),
          );

      for (var i = 0; i < routine.exercises.length; i++) {
        final ex = routine.exercises[i];
        await _db.into(_db.dailyTrainingRecords).insert(
              DailyTrainingRecordsCompanion.insert(
                id: _uuid.v4(),
                sessionId: sessionId,
                exerciseName: ex.name,
                activityType: ex.activityType,
                sets: Value(ex.targetSets),
                durationSeconds: Value(ex.targetDurationSeconds),
                repetitions: Value(ex.targetRepetitions),
                weightKg: Value(ex.targetWeightKg),
                isCompleted: const Value(false),
                orderIndex: Value(i),
              ),
            );
      }
    });

    final records = await (_db.select(_db.dailyTrainingRecords)
          ..where((tbl) => tbl.sessionId.equals(sessionId))
          ..orderBy([(t) => OrderingTerm.asc(t.orderIndex)]))
        .get();

    return DailyTrainingSession(
      id: sessionId,
      routineId: routine.id,
      routineName: routine.name,
      groupName: groupName,
      date: today,
      startedAt: now,
      status: 'in_progress',
      records: records.map(_recordToDomain).toList(),
    );
  }

  /// Updates daily record performance settings (sets, times, repetitions, weights, completion status).
  Future<void> updateRecordSettings({
    required String recordId,
    int? sets,
    int? durationSeconds,
    int? repetitions,
    double? weightKg,
    bool? isCompleted,
  }) async {
    await (_db.update(_db.dailyTrainingRecords)..where((tbl) => tbl.id.equals(recordId))).write(
      DailyTrainingRecordsCompanion(
        sets: sets != null ? Value(sets) : const Value.absent(),
        durationSeconds: durationSeconds != null ? Value(durationSeconds) : const Value.absent(),
        repetitions: repetitions != null ? Value(repetitions) : const Value.absent(),
        weightKg: weightKg != null ? Value(weightKg) : const Value.absent(),
        isCompleted: isCompleted != null ? Value(isCompleted) : const Value.absent(),
      ),
    );
  }

  /// Concludes the daily training session.
  Future<void> concludeTraining(String sessionId) async {
    final now = DateTime.now();
    await (_db.update(_db.dailyTrainingSessions)..where((tbl) => tbl.id.equals(sessionId))).write(
      DailyTrainingSessionsCompanion(
        status: const Value('completed'),
        concludedAt: Value(now),
      ),
    );
  }

  /// Resumes or reopens a training session if needed.
  Future<void> resumeTraining(String sessionId) async {
    await (_db.update(_db.dailyTrainingSessions)..where((tbl) => tbl.id.equals(sessionId))).write(
      const DailyTrainingSessionsCompanion(
        status: Value('in_progress'),
        concludedAt: Value(null),
      ),
    );
  }

  /// Deletes a daily training session and all its associated records.
  Future<void> deleteDailySession(String sessionId) async {
    await _db.transaction(() async {
      await (_db.delete(_db.dailyTrainingRecords)..where((tbl) => tbl.sessionId.equals(sessionId))).go();
      await (_db.delete(_db.dailyTrainingSessions)..where((tbl) => tbl.id.equals(sessionId))).go();
    });
  }
}

/// Riverpod provider for [TrainingRepository].
final trainingRepositoryProvider = Provider<TrainingRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return TrainingRepository(db);
});

/// Riverpod StreamProvider for watching all active workout groups.
final workoutGroupsStreamProvider = StreamProvider<List<WorkoutGroup>>((ref) {
  final repo = ref.watch(trainingRepositoryProvider);
  return repo.watchWorkoutGroups();
});

/// Riverpod StreamProvider for today's training session.
final todayTrainingSessionStreamProvider = StreamProvider<DailyTrainingSession?>((ref) {
  final repo = ref.watch(trainingRepositoryProvider);
  return repo.watchTodaySession();
});

