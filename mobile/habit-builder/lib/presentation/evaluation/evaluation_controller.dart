import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../data/repositories/life_area_evaluation_repository.dart';
import '../../domain/models/life_area.dart';
import '../../domain/models/life_area_evaluation.dart';
import '../onboarding/user_controller.dart';

/// State representation for in-progress life area evaluations during assessment or editing.
class AssessmentState {
  final Map<LifeArea, double> scores;
  final Map<LifeArea, int> priorities;
  final int currentStepIndex; // 0 to 11
  final bool isSaving;
  final bool isLoaded;

  const AssessmentState({
    required this.scores,
    required this.priorities,
    this.currentStepIndex = 0,
    this.isSaving = false,
    this.isLoaded = false,
  });

  AssessmentState copyWith({
    Map<LifeArea, double>? scores,
    Map<LifeArea, int>? priorities,
    int? currentStepIndex,
    bool? isSaving,
    bool? isLoaded,
  }) {
    return AssessmentState(
      scores: scores ?? this.scores,
      priorities: priorities ?? this.priorities,
      currentStepIndex: currentStepIndex ?? this.currentStepIndex,
      isSaving: isSaving ?? this.isSaving,
      isLoaded: isLoaded ?? this.isLoaded,
    );
  }

  factory AssessmentState.initial() {
    final defaultScores = <LifeArea, double>{};
    final defaultPriorities = <LifeArea, int>{};

    for (final area in LifeArea.values) {
      defaultScores[area] = 5.0;
      defaultPriorities[area] = 3;
    }

    return AssessmentState(
      scores: defaultScores,
      priorities: defaultPriorities,
      currentStepIndex: 0,
      isSaving: false,
      isLoaded: false,
    );
  }
}

/// Controller managing in-progress assessment steps, progressive persistence, and draft resumption.
class AssessmentController extends StateNotifier<AssessmentState> {
  final LifeAreaEvaluationRepository _evaluationRepo;
  final Ref _ref;
  final Uuid _uuid;

  AssessmentController(this._evaluationRepo, this._ref, [Uuid? uuid])
      : _uuid = uuid ?? const Uuid(),
        super(AssessmentState.initial()) {
    loadExistingEvaluations();
  }

  /// Queries existing evaluations from SQLite and sets currentStepIndex to the first unevaluated area.
  Future<void> loadExistingEvaluations() async {
    try {
      final latestMap = await _evaluationRepo.getLatestEvaluations();
      final updatedScores = Map<LifeArea, double>.from(state.scores);
      final updatedPriorities = Map<LifeArea, int>.from(state.priorities);

      for (final entry in latestMap.entries) {
        updatedScores[entry.key] = entry.value.score;
        updatedPriorities[entry.key] = entry.value.currentPriority;
      }

      int firstUnevaluatedIndex = 0;
      for (int i = 0; i < LifeArea.values.length; i++) {
        final area = LifeArea.values[i];
        if (!latestMap.containsKey(area)) {
          firstUnevaluatedIndex = i;
          break;
        }
      }

      // If all 12 are already evaluated
      if (latestMap.length >= LifeArea.values.length) {
        firstUnevaluatedIndex = 0;
      }

      state = state.copyWith(
        scores: updatedScores,
        priorities: updatedPriorities,
        currentStepIndex: firstUnevaluatedIndex,
        isLoaded: true,
      );
    } catch (_) {
      state = state.copyWith(isLoaded: true);
    }
  }

  void setStep(int step) {
    if (step >= 0 && step < LifeArea.values.length) {
      state = state.copyWith(currentStepIndex: step);
    }
  }

  void nextStep() {
    if (state.currentStepIndex < LifeArea.values.length - 1) {
      state = state.copyWith(currentStepIndex: state.currentStepIndex + 1);
    }
  }

  void previousStep() {
    if (state.currentStepIndex > 0) {
      state = state.copyWith(currentStepIndex: state.currentStepIndex - 1);
    }
  }

  void updateScore(LifeArea area, double score) {
    final updatedScores = Map<LifeArea, double>.from(state.scores);
    updatedScores[area] = score;
    state = state.copyWith(scores: updatedScores);
  }

  void updatePriority(LifeArea area, int priority) {
    final updatedPriorities = Map<LifeArea, int>.from(state.priorities);
    updatedPriorities[area] = priority;
    state = state.copyWith(priorities: updatedPriorities);
  }

  /// Saves the current step's life area evaluation immediately to SQLite "life_areas_evaluations".
  Future<void> saveCurrentStep() async {
    if (state.currentStepIndex >= 0 && state.currentStepIndex < LifeArea.values.length) {
      final area = LifeArea.values[state.currentStepIndex];
      final score = state.scores[area] ?? 5.0;
      final priority = state.priorities[area] ?? 3;
      await saveSingleArea(area, score, priority);
    }
  }

  /// Saves a single evaluation for a specific life area (e.g. from the Home Page re-evaluation dialog).
  Future<void> saveSingleArea(LifeArea area, double score, int priority) async {
    final evaluation = LifeAreaEvaluation(
      id: _uuid.v4(),
      lifeArea: area,
      score: score,
      currentPriority: priority,
      evaluatedAt: DateTime.now(),
    );

    await _evaluationRepo.saveEvaluation(evaluation);
    updateScore(area, score);
    updatePriority(area, priority);
  }

  /// Finalizes the full 12-area assessment: persists all 12 evaluations to SQLite
  /// and marks onboarding completed in the user table.
  Future<void> completeAssessment() async {
    state = state.copyWith(isSaving: true);

    try {
      final now = DateTime.now();
      final List<LifeAreaEvaluation> evaluations = [];

      for (final area in LifeArea.values) {
        final score = state.scores[area] ?? 5.0;
        final priority = state.priorities[area] ?? 3;

        evaluations.add(
          LifeAreaEvaluation(
            id: _uuid.v4(),
            lifeArea: area,
            score: score,
            currentPriority: priority,
            evaluatedAt: now,
          ),
        );
      }

      // Batch insert into life_areas_evaluations table
      await _evaluationRepo.saveBatchEvaluations(evaluations);

      // Mark onboarding completed in users table
      await _ref.read(userControllerProvider.notifier).completeOnboarding();

      state = state.copyWith(isSaving: false);
    } catch (e) {
      state = state.copyWith(isSaving: false);
      rethrow;
    }
  }
}

/// Provider for [AssessmentController].
final assessmentControllerProvider =
    StateNotifierProvider<AssessmentController, AssessmentState>((ref) {
  final repo = ref.watch(lifeAreaEvaluationRepositoryProvider);
  return AssessmentController(repo, ref);
});

/// Stream provider for all latest evaluations per life area.
final latestEvaluationsProvider =
    StreamProvider<Map<LifeArea, LifeAreaEvaluation>>((ref) {
  final repo = ref.watch(lifeAreaEvaluationRepositoryProvider);
  return repo.watchLatestEvaluations();
});
