import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/repositories/training_repository.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('TrainingRepository & SQLite 3-Tier Training Tables', () {
    late AppDatabase database;
    late TrainingRepository repository;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      repository = TrainingRepository(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('verifies exact table names in SQLite schema', () {
      expect(database.workoutGroups.actualTableName, 'workout_groups');
      expect(database.workoutRoutines.actualTableName, 'workout_routines');
      expect(database.trainingExercises.actualTableName, 'training_exercises');
      expect(database.dailyTrainingSessions.actualTableName, 'daily_training_sessions');
      expect(database.dailyTrainingRecords.actualTableName, 'daily_training_records');
    });

    test('creates default Group, Routine, and Exercise with sets if none exist', () async {
      final defaultGroup = await repository.getOrCreateDefaultGroupAndRoutine(
        defaultGroupName: 'Default Group',
        defaultRoutineName: 'Sample Workout',
      );

      expect(defaultGroup.id, isNotEmpty);
      expect(defaultGroup.name, 'Default Group');
      expect(defaultGroup.routines.length, 1);
      expect(defaultGroup.routines.first.name, 'Sample Workout');
      expect(defaultGroup.routines.first.exercises.length, 1);
      expect(defaultGroup.routines.first.exercises.first.name, 'Squats');
      expect(defaultGroup.routines.first.exercises.first.targetSets, 3);
      expect(defaultGroup.routines.first.exercises.first.targetRepetitions, 25);
    });

    test('creates Groups, Routines, and configures Exercises with sets, targets and weights',
        () async {
      // 1. Create a Group
      final newGroup = await repository.createGroup('Hipertrofia ABC');
      expect(newGroup.name, 'Hipertrofia ABC');

      // 2. Add Routine inside Group
      final routineA = await repository.createRoutine(
        groupId: newGroup.id,
        name: 'Treino A - Peito e Tríceps',
      );
      expect(routineA.name, 'Treino A - Peito e Tríceps');
      expect(routineA.groupId, newGroup.id);

      // 3. Add Exercises with sets inside Routine
      final ex1 = await repository.addExercise(
        routineId: routineA.id,
        name: 'Agachamentos',
        activityType: 'repetition',
        targetSets: 3,
        targetRepetitions: 25,
        targetWeightKg: 40.0,
      );

      final ex2 = await repository.addExercise(
        routineId: routineA.id,
        name: 'Running',
        activityType: 'duration',
        targetSets: 1,
        targetDurationSeconds: 1200,
      );

      expect(ex1.name, 'Agachamentos');
      expect(ex1.targetSets, 3);
      expect(ex1.targetRepetitions, 25);
      expect(ex1.targetWeightKg, 40.0);
      expect(ex1.orderIndex, 0);

      expect(ex2.name, 'Running');
      expect(ex2.targetSets, 1);
      expect(ex2.targetDurationSeconds, 1200);
      expect(ex2.orderIndex, 1);

      // 4. Verify full hierarchy
      final groups = await repository.getWorkoutGroups();
      final fetchedGroup = groups.firstWhere((g) => g.id == newGroup.id);
      expect(fetchedGroup.routines.length, 1);
      expect(fetchedGroup.routines.first.exercises.length, 2);
    });

    test('reorders exercises within a routine', () async {
      final defaultGroup = await repository.getOrCreateDefaultGroupAndRoutine();
      final routine = defaultGroup.routines.first;

      final ex1 = await repository.addExercise(
        routineId: routine.id,
        name: 'Exercise A',
        activityType: 'repetition',
        targetSets: 3,
      );
      final ex2 = await repository.addExercise(
        routineId: routine.id,
        name: 'Exercise B',
        activityType: 'duration',
        targetSets: 3,
      );

      await repository.reorderExercises(routine.id, [ex2.id, ex1.id]);

      final groups = await repository.getWorkoutGroups();
      final updatedRoutine = groups.first.routines.first;
      // Index 0 was initial Squats, then Exercise B, then Exercise A
      expect(updatedRoutine.exercises.map((e) => e.name).contains('Exercise B'), isTrue);
      expect(updatedRoutine.exercises.map((e) => e.name).contains('Exercise A'), isTrue);
    });

    test('starts workout session from a routine, modifies daily settings, and concludes session',
        () async {
      final defaultGroup = await repository.getOrCreateDefaultGroupAndRoutine();
      final routine = defaultGroup.routines.first;

      await repository.addExercise(
        routineId: routine.id,
        name: 'Push-ups',
        activityType: 'repetition',
        targetSets: 3,
        targetRepetitions: 20,
        targetWeightKg: 0.0,
      );

      final loadedGroups = await repository.getWorkoutGroups();
      final loadedRoutine = loadedGroups.first.routines.first;

      // 1. Start Workout Session for this Routine
      final session = await repository.startTraining(loadedRoutine, groupName: defaultGroup.name);
      expect(session.id, isNotEmpty);
      expect(session.routineId, loadedRoutine.id);
      expect(session.routineName, loadedRoutine.name);
      expect(session.groupName, defaultGroup.name);
      expect(session.status, 'in_progress');
      expect(session.records.length, greaterThanOrEqualTo(1));
      expect(session.records[0].sets, 3);
      expect(session.records[0].isCompleted, isFalse);

      // 2. Adjust daily performance settings (sets, repetitions, weights)
      final recordId = session.records[0].id;
      await repository.updateRecordSettings(
        recordId: recordId,
        sets: 4,
        repetitions: 30,
        weightKg: 50.0,
        isCompleted: true,
      );

      // 3. Conclude Workout Session
      await repository.concludeTraining(session.id);

      final sessionAfter = await repository.watchTodaySession().first;
      expect(sessionAfter, isNotNull);
      expect(sessionAfter!.status, 'completed');
      expect(sessionAfter.concludedAt, isNotNull);
      expect(sessionAfter.records[0].sets, 4);
      expect(sessionAfter.records[0].repetitions, 30);
      expect(sessionAfter.records[0].weightKg, 50.0);
      expect(sessionAfter.records[0].isCompleted, isTrue);

      // 4. Delete Workout Session
      await repository.deleteDailySession(session.id);
      final sessionDeleted = await repository.watchTodaySession().first;
      expect(sessionDeleted, isNull);
    });
  });
}

