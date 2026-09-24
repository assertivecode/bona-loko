import 'dart:math' as math;
import '../models/life_area_evaluation.dart';

/// Categories classifying the urgency of life balance deficits and habit focus.
enum DeficitCategory {
  high,
  moderate,
  aligned;

  String get label {
    switch (this) {
      case DeficitCategory.high:
        return 'High Priority Deficit';
      case DeficitCategory.moderate:
        return 'Moderate Deficit';
      case DeficitCategory.aligned:
        return 'Aligned / Negligible';
    }
  }
}

/// Result of an energy conservation assessment across multiple life areas.
class EnergyConservationResult {
  final bool hasWarning;
  final String? advisoryMessage;
  final int highPriorityCount;

  const EnergyConservationResult({
    required this.hasWarning,
    this.advisoryMessage,
    required this.highPriorityCount,
  });
}

/// Pure Dart mathematical engine for computing priorities, gaps, and energy conservation
/// matching specs/domain/priority-model.spec.md.
class PriorityEngine {
  const PriorityEngine();

  /// Calculates the Investment Delta:
  /// ΔI = I_des - I_curr
  static double calculateInvestmentDelta({
    required double desiredInvestment,
    required double currentInvestment,
  }) {
    return desiredInvestment - currentInvestment;
  }

  /// Calculates the Weighted Priority Gap Score (G) for a 1..10 priority scale:
  /// G = max(0, ΔI) * (P / 10.0)
  static double calculatePriorityGapScore({
    required double investmentDelta,
    required double priority,
  }) {
    final double clampedDelta = math.max(0.0, investmentDelta);
    final double normalizedP = math.max(0.0, math.min(10.0, priority)) / 10.0;
    return clampedDelta * normalizedP;
  }

  /// Calculates the Weighted Deficit Score (W) for a [LifeAreaEvaluation]
  /// where score S in [0.0, 10.0] and currentPriority P in [1, 5]:
  /// W = (10.0 - S) * (P / 5.0)
  /// Result ranges from 0.0 (fully satisfied / no deficit) to 10.0 (maximum gap & top priority).
  static double calculateWeightedDeficit({
    required double score,
    required int currentPriority,
  }) {
    final double clampedScore = math.max(0.0, math.min(10.0, score));
    final double normalizedPriority = math.max(1, math.min(5, currentPriority)) / 5.0;
    final double deficit = 10.0 - clampedScore;
    return double.parse((deficit * normalizedPriority).toStringAsFixed(2));
  }

  /// Categorizes a weighted deficit score into [DeficitCategory].
  /// High Deficit: W >= 4.0 or priority == 5
  /// Moderate Deficit: 1.0 <= W < 4.0
  /// Aligned: W < 1.0
  static DeficitCategory classifyDeficit({
    required double score,
    required int currentPriority,
  }) {
    final double weighted = calculateWeightedDeficit(
      score: score,
      currentPriority: currentPriority,
    );

    if (currentPriority == 5 || weighted >= 4.0) {
      return DeficitCategory.high;
    } else if (weighted >= 1.0) {
      return DeficitCategory.moderate;
    } else {
      return DeficitCategory.aligned;
    }
  }

  /// Energy Conservation Check (Rule of Sustainable Focus):
  /// When a user marks more than 3 areas with highest priority (P = 5),
  /// the system advises gentle pacing to cultivate lasting habits without burnout.
  static EnergyConservationResult checkEnergyConservation(
    List<LifeAreaEvaluation> evaluations,
  ) {
    final int highPriorityCount =
        evaluations.where((e) => e.currentPriority == 5).length;

    if (highPriorityCount > 3) {
      return EnergyConservationResult(
        hasWarning: true,
        highPriorityCount: highPriorityCount,
        advisoryMessage:
            'Focusing simultaneously on $highPriorityCount top-priority areas may disperse your energy. Consider selecting 2 to 3 core areas to practice first.',
      );
    }

    return EnergyConservationResult(
      hasWarning: false,
      highPriorityCount: highPriorityCount,
    );
  }

  /// Ranks evaluations by focus urgency:
  /// 1. Current priority (5 down to 1)
  /// 2. Weighted deficit score descending
  /// 3. Score ascending (lower score needs more attention)
  static List<LifeAreaEvaluation> rankByFocusUrgency(
    List<LifeAreaEvaluation> evaluations,
  ) {
    final List<LifeAreaEvaluation> sorted = List.of(evaluations);
    sorted.sort((a, b) {
      // 1. Higher priority first
      final priorityComparison = b.currentPriority.compareTo(a.currentPriority);
      if (priorityComparison != 0) return priorityComparison;

      // 2. Higher weighted deficit first
      final deficitA = calculateWeightedDeficit(score: a.score, currentPriority: a.currentPriority);
      final deficitB = calculateWeightedDeficit(score: b.score, currentPriority: b.currentPriority);
      final deficitComparison = deficitB.compareTo(deficitA);
      if (deficitComparison != 0) return deficitComparison;

      // 3. Lower score first
      return a.score.compareTo(b.score);
    });
    return sorted;
  }
}
