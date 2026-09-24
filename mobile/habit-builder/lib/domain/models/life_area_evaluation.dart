import 'life_area.dart';

/// Immutable domain model representing a single evaluation for a specific life area.
class LifeAreaEvaluation {
  final String id;
  final LifeArea lifeArea;
  final double score;
  final int currentPriority;
  final DateTime evaluatedAt;

  LifeAreaEvaluation({
    required this.id,
    required this.lifeArea,
    required this.score,
    required this.currentPriority,
    required this.evaluatedAt,
  }) {
    if (score < 0.0 || score > 10.0) {
      throw ArgumentError.value(
        score,
        'score',
        'Score must be between 0.0 and 10.0 inclusive.',
      );
    }
    // Verify half-integer precision (e.g., 0.0, 0.5, 1.0, 1.5, ..., 10.0)
    final double doubled = score * 2;
    if (doubled != doubled.roundToDouble()) {
      throw ArgumentError.value(
        score,
        'score',
        'Score must be a whole or half-integer (e.g., 0.0, 0.5, 1.0, ..., 10.0).',
      );
    }
    if (currentPriority < 1 || currentPriority > 5) {
      throw ArgumentError.value(
        currentPriority,
        'currentPriority',
        'Current priority must be an integer between 1 and 5 inclusive (5 = highest priority to focus/practice).',
      );
    }
  }

  LifeAreaEvaluation copyWith({
    String? id,
    LifeArea? lifeArea,
    double? score,
    int? currentPriority,
    DateTime? evaluatedAt,
  }) {
    return LifeAreaEvaluation(
      id: id ?? this.id,
      lifeArea: lifeArea ?? this.lifeArea,
      score: score ?? this.score,
      currentPriority: currentPriority ?? this.currentPriority,
      evaluatedAt: evaluatedAt ?? this.evaluatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LifeAreaEvaluation &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          lifeArea == other.lifeArea &&
          score == other.score &&
          currentPriority == other.currentPriority &&
          evaluatedAt.isAtSameMomentAs(other.evaluatedAt);

  @override
  int get hashCode => Object.hash(id, lifeArea, score, currentPriority, evaluatedAt);

  @override
  String toString() =>
      'LifeAreaEvaluation(id: $id, lifeArea: ${lifeArea.key}, score: $score, priority: $currentPriority, evaluatedAt: $evaluatedAt)';
}
