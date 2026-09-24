import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/training_repository.dart';
import '../../domain/models/training.dart';

/// StateNotifier controlling workout groups, routines, exercises, and daily workout execution.
class TrainingController extends StateNotifier<AsyncValue<void>> {
  final TrainingRepository _repository;

  TrainingController(this._repository) : super(const AsyncValue.data(null));

  /// Creates a new Workout Group.
  Future<WorkoutGroup?> createGroup(String name, {String? description}) async {
    state = const AsyncValue.loading();
    try {
      final group = await _repository.createGroup(name, description: description);
      state = const AsyncValue.data(null);
      return group;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  /// Updates the name of a Workout Group.
  Future<void> updateGroupName(String groupId, String name) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateGroupName(groupId, name);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Deletes a Workout Group.
  Future<void> deleteGroup(String groupId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteGroup(groupId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Creates a new Workout Routine in a Group.
  Future<WorkoutRoutine?> createRoutine({
    required String groupId,
    required String name,
    String? description,
  }) async {
    state = const AsyncValue.loading();
    try {
      final routine = await _repository.createRoutine(
        groupId: groupId,
        name: name,
        description: description,
      );
      state = const AsyncValue.data(null);
      return routine;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  /// Updates the name of a Workout Routine.
  Future<void> updateRoutineName(String routineId, String name) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateRoutineName(routineId, name);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Deletes a Workout Routine.
  Future<void> deleteRoutine(String routineId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteRoutine(routineId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Reorders Workout Routines within a Group.
  Future<void> reorderRoutines(
    String groupId,
    int oldIndex,
    int newIndex,
    List<WorkoutRoutine> currentRoutines,
  ) async {
    state = const AsyncValue.loading();
    try {
      final items = List<WorkoutRoutine>.from(currentRoutines);
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);

      final orderedIds = items.map((r) => r.id).toList();
      await _repository.reorderRoutines(groupId, orderedIds);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Adds a new exercise into a Workout Routine.
  Future<void> addExercise({
    required String routineId,
    required String name,
    required String activityType,
    int targetSets = 3,
    int? targetDurationSeconds,
    int? targetRepetitions,
    double? targetWeightKg,
  }) async {
    state = const AsyncValue.loading();
    try {
      await _repository.addExercise(
        routineId: routineId,
        name: name,
        activityType: activityType,
        targetSets: targetSets,
        targetDurationSeconds: targetDurationSeconds,
        targetRepetitions: targetRepetitions,
        targetWeightKg: targetWeightKg,
      );
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Deletes an exercise from a routine.
  Future<void> deleteExercise(String exerciseId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteExercise(exerciseId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Reorders exercises within a routine.
  Future<void> reorderExercises(
    String routineId,
    int oldIndex,
    int newIndex,
    List<TrainingExercise> currentExercises,
  ) async {
    state = const AsyncValue.loading();
    try {
      final items = List<TrainingExercise>.from(currentExercises);
      if (newIndex > oldIndex) {
        newIndex -= 1;
      }
      final item = items.removeAt(oldIndex);
      items.insert(newIndex, item);

      final orderedIds = items.map((e) => e.id).toList();
      await _repository.reorderExercises(routineId, orderedIds);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Starts a new daily workout session from a routine.
  Future<DailyTrainingSession?> startTraining(WorkoutRoutine routine, {String? groupName}) async {
    state = const AsyncValue.loading();
    try {
      final session = await _repository.startTraining(routine, groupName: groupName);
      state = const AsyncValue.data(null);
      return session;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      return null;
    }
  }

  /// Updates daily performance settings (sets, times, repetitions, weights, completion) on a record.
  Future<void> updateDailyRecord({
    required String recordId,
    int? sets,
    int? durationSeconds,
    int? repetitions,
    double? weightKg,
    bool? isCompleted,
  }) async {
    try {
      await _repository.updateRecordSettings(
        recordId: recordId,
        sets: sets,
        durationSeconds: durationSeconds,
        repetitions: repetitions,
        weightKg: weightKg,
        isCompleted: isCompleted,
      );
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Concludes the active daily training session.
  Future<void> concludeTraining(String sessionId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.concludeTraining(sessionId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Resumes an already concluded training session if reopened.
  Future<void> resumeTraining(String sessionId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.resumeTraining(sessionId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  /// Deletes a daily training session.
  Future<void> deleteDailySession(String sessionId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteDailySession(sessionId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

/// Riverpod StateNotifierProvider for [TrainingController].
final trainingControllerProvider =
    StateNotifierProvider<TrainingController, AsyncValue<void>>((ref) {
  final repo = ref.watch(trainingRepositoryProvider);
  return TrainingController(repo);
});

