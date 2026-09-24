/// Domain model representing a workout group (collection of workout routines).
class WorkoutGroup {
  final String id;
  final String name;
  final String? description;
  final DateTime createdAt;
  final bool isActive;
  final int orderIndex;
  final List<WorkoutRoutine> routines;

  const WorkoutGroup({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt,
    this.isActive = true,
    this.orderIndex = 0,
    this.routines = const [],
  });

  WorkoutGroup copyWith({
    String? id,
    String? name,
    String? description,
    DateTime? createdAt,
    bool? isActive,
    int? orderIndex,
    List<WorkoutRoutine>? routines,
  }) {
    return WorkoutGroup(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      isActive: isActive ?? this.isActive,
      orderIndex: orderIndex ?? this.orderIndex,
      routines: routines ?? this.routines,
    );
  }
}

/// Domain model representing a specific workout routine inside a group.
class WorkoutRoutine {
  final String id;
  final String groupId;
  final String name;
  final String? description;
  final DateTime createdAt;
  final int orderIndex;
  final List<TrainingExercise> exercises;

  const WorkoutRoutine({
    required this.id,
    required this.groupId,
    required this.name,
    this.description,
    required this.createdAt,
    this.orderIndex = 0,
    this.exercises = const [],
  });

  WorkoutRoutine copyWith({
    String? id,
    String? groupId,
    String? name,
    String? description,
    DateTime? createdAt,
    int? orderIndex,
    List<TrainingExercise>? exercises,
  }) {
    return WorkoutRoutine(
      id: id ?? this.id,
      groupId: groupId ?? this.groupId,
      name: name ?? this.name,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      orderIndex: orderIndex ?? this.orderIndex,
      exercises: exercises ?? this.exercises,
    );
  }
}

/// Domain model representing an individual exercise configured in a routine.
class TrainingExercise {
  final String id;
  final String routineId;
  final String name;
  final String activityType; // 'duration' | 'repetition'
  final int targetSets; // e.g. 3 sets
  final int? targetDurationSeconds;
  final int? targetRepetitions;
  final double? targetWeightKg;
  final int orderIndex;

  const TrainingExercise({
    required this.id,
    required this.routineId,
    required this.name,
    required this.activityType,
    this.targetSets = 3,
    this.targetDurationSeconds,
    this.targetRepetitions,
    this.targetWeightKg,
    this.orderIndex = 0,
  });

  TrainingExercise copyWith({
    String? id,
    String? routineId,
    String? name,
    String? activityType,
    int? targetSets,
    int? targetDurationSeconds,
    int? targetRepetitions,
    double? targetWeightKg,
    int? orderIndex,
  }) {
    return TrainingExercise(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      name: name ?? this.name,
      activityType: activityType ?? this.activityType,
      targetSets: targetSets ?? this.targetSets,
      targetDurationSeconds: targetDurationSeconds ?? this.targetDurationSeconds,
      targetRepetitions: targetRepetitions ?? this.targetRepetitions,
      targetWeightKg: targetWeightKg ?? this.targetWeightKg,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}

/// Domain model representing a daily workout session execution.
class DailyTrainingSession {
  final String id;
  final String? routineId;
  final String routineName;
  final String? groupName;
  final DateTime date;
  final DateTime startedAt;
  final DateTime? concludedAt;
  final String status; // 'in_progress' | 'completed'
  final List<DailyTrainingRecord> records;

  const DailyTrainingSession({
    required this.id,
    this.routineId,
    required this.routineName,
    this.groupName,
    required this.date,
    required this.startedAt,
    this.concludedAt,
    this.status = 'in_progress',
    this.records = const [],
  });

  bool get isCompleted => status == 'completed' || concludedAt != null;

  DailyTrainingSession copyWith({
    String? id,
    String? routineId,
    String? routineName,
    String? groupName,
    DateTime? date,
    DateTime? startedAt,
    DateTime? concludedAt,
    String? status,
    List<DailyTrainingRecord>? records,
  }) {
    return DailyTrainingSession(
      id: id ?? this.id,
      routineId: routineId ?? this.routineId,
      routineName: routineName ?? this.routineName,
      groupName: groupName ?? this.groupName,
      date: date ?? this.date,
      startedAt: startedAt ?? this.startedAt,
      concludedAt: concludedAt ?? this.concludedAt,
      status: status ?? this.status,
      records: records ?? this.records,
    );
  }
}

/// Domain model representing the performance and completion record of an individual exercise during a daily session.
class DailyTrainingRecord {
  final String id;
  final String sessionId;
  final String exerciseName;
  final String activityType; // 'duration' | 'repetition'
  final int? sets;
  final int? durationSeconds;
  final int? repetitions;
  final double? weightKg;
  final bool isCompleted;
  final int orderIndex;

  const DailyTrainingRecord({
    required this.id,
    required this.sessionId,
    required this.exerciseName,
    required this.activityType,
    this.sets = 3,
    this.durationSeconds,
    this.repetitions,
    this.weightKg,
    this.isCompleted = false,
    this.orderIndex = 0,
  });

  DailyTrainingRecord copyWith({
    String? id,
    String? sessionId,
    String? exerciseName,
    String? activityType,
    int? sets,
    int? durationSeconds,
    int? repetitions,
    double? weightKg,
    bool? isCompleted,
    int? orderIndex,
  }) {
    return DailyTrainingRecord(
      id: id ?? this.id,
      sessionId: sessionId ?? this.sessionId,
      exerciseName: exerciseName ?? this.exerciseName,
      activityType: activityType ?? this.activityType,
      sets: sets ?? this.sets,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      repetitions: repetitions ?? this.repetitions,
      weightKg: weightKg ?? this.weightKg,
      isCompleted: isCompleted ?? this.isCompleted,
      orderIndex: orderIndex ?? this.orderIndex,
    );
  }
}
