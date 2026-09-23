import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/domain/engine/priority_engine.dart';
import 'package:habit_builder/domain/models/life_area.dart';
import 'package:habit_builder/domain/models/life_area_evaluation.dart';

void main() {
  group('PriorityEngine Mathematical Calculations', () {
    test('calculateInvestmentDelta: computes I_des - I_curr correctly', () {
      expect(
        PriorityEngine.calculateInvestmentDelta(desiredInvestment: 8, currentInvestment: 3),
        5.0,
      );
      expect(
        PriorityEngine.calculateInvestmentDelta(desiredInvestment: 5, currentInvestment: 5),
        0.0,
      );
      expect(
        PriorityEngine.calculateInvestmentDelta(desiredInvestment: 2, currentInvestment: 6),
        -4.0,
      );
    });

    test('calculatePriorityGapScore: matches specs/domain/priority-model.spec.md', () {
      // P=10, ΔI=5 -> G = 5 * (10/10) = 5.0
      expect(
        PriorityEngine.calculatePriorityGapScore(investmentDelta: 5.0, priority: 10.0),
        5.0,
      );

      // Clamps negative delta to 0
      expect(
        PriorityEngine.calculatePriorityGapScore(investmentDelta: -3.0, priority: 8.0),
        0.0,
      );

      // High boundary: P=9, ΔI=9 -> G = 9 * 0.9 = 8.1
      expect(
        PriorityEngine.calculatePriorityGapScore(investmentDelta: 9.0, priority: 9.0),
        closeTo(8.1, 0.001),
      );
    });

    test('calculateWeightedDeficit: calculates W = (10 - score) * (priority / 5)', () {
      // Score = 4.0, Priority = 5 -> (10 - 4) * (5/5) = 6.0
      expect(
        PriorityEngine.calculateWeightedDeficit(score: 4.0, currentPriority: 5),
        6.0,
      );

      // Score = 10.0, Priority = 5 -> (10 - 10) * (5/5) = 0.0
      expect(
        PriorityEngine.calculateWeightedDeficit(score: 10.0, currentPriority: 5),
        0.0,
      );

      // Score = 0.0, Priority = 5 -> (10 - 0) * (5/5) = 10.0
      expect(
        PriorityEngine.calculateWeightedDeficit(score: 0.0, currentPriority: 5),
        10.0,
      );

      // Score = 5.0, Priority = 3 -> 5.0 * 0.6 = 3.0
      expect(
        PriorityEngine.calculateWeightedDeficit(score: 5.0, currentPriority: 3),
        3.0,
      );

      // Score = 8.5, Priority = 2 -> 1.5 * 0.4 = 0.6
      expect(
        PriorityEngine.calculateWeightedDeficit(score: 8.5, currentPriority: 2),
        0.6,
      );
    });

    test('classifyDeficit: categorizes into high, moderate, aligned', () {
      // Any area with priority == 5 is High Priority Deficit
      expect(
        PriorityEngine.classifyDeficit(score: 7.0, currentPriority: 5),
        DeficitCategory.high,
      );

      // W >= 4.0 with priority 4: (10 - 5.0) * (4/5) = 4.0 -> High
      expect(
        PriorityEngine.classifyDeficit(score: 5.0, currentPriority: 4),
        DeficitCategory.high,
      );

      // W in [1.0, 4.0): (10 - 6.0) * (3/5) = 2.4 -> Moderate
      expect(
        PriorityEngine.classifyDeficit(score: 6.0, currentPriority: 3),
        DeficitCategory.moderate,
      );

      // W < 1.0: (10 - 9.0) * (2/5) = 0.4 -> Aligned
      expect(
        PriorityEngine.classifyDeficit(score: 9.0, currentPriority: 2),
        DeficitCategory.aligned,
      );
    });

    test('checkEnergyConservation: triggers warning when > 3 areas have priority 5', () {
      final now = DateTime.now();
      final evaluations = [
        LifeAreaEvaluation(id: '1', lifeArea: LifeArea.healthFitness, score: 5, currentPriority: 5, evaluatedAt: now),
        LifeAreaEvaluation(id: '2', lifeArea: LifeArea.careerCalling, score: 6, currentPriority: 5, evaluatedAt: now),
        LifeAreaEvaluation(id: '3', lifeArea: LifeArea.financesWealth, score: 4, currentPriority: 5, evaluatedAt: now),
      ];

      // 3 areas: no warning
      final safeCheck = PriorityEngine.checkEnergyConservation(evaluations);
      expect(safeCheck.hasWarning, isFalse);
      expect(safeCheck.highPriorityCount, 3);

      // 4 areas: warning triggered
      final overloaded = [
        ...evaluations,
        LifeAreaEvaluation(id: '4', lifeArea: LifeArea.focusMastery, score: 3, currentPriority: 5, evaluatedAt: now),
      ];
      final warningCheck = PriorityEngine.checkEnergyConservation(overloaded);
      expect(warningCheck.hasWarning, isTrue);
      expect(warningCheck.highPriorityCount, 4);
      expect(warningCheck.advisoryMessage, contains('Consider selecting 2 to 3 core areas'));
    });

    test('rankByFocusUrgency: ranks priority 5 first, then higher deficit, then lower score', () {
      final now = DateTime.now();
      final evals = [
        LifeAreaEvaluation(id: '1', lifeArea: LifeArea.personalGrowth, score: 8.0, currentPriority: 3, evaluatedAt: now),
        LifeAreaEvaluation(id: '2', lifeArea: LifeArea.healthFitness, score: 4.0, currentPriority: 5, evaluatedAt: now),
        LifeAreaEvaluation(id: '3', lifeArea: LifeArea.focusMastery, score: 2.0, currentPriority: 5, evaluatedAt: now),
        LifeAreaEvaluation(id: '4', lifeArea: LifeArea.recreationPlay, score: 9.0, currentPriority: 1, evaluatedAt: now),
      ];

      final ranked = PriorityEngine.rankByFocusUrgency(evals);

      // FocusMastery (P=5, Score=2) should precede HealthFitness (P=5, Score=4)
      expect(ranked[0].lifeArea, LifeArea.focusMastery);
      expect(ranked[1].lifeArea, LifeArea.healthFitness);
      expect(ranked[2].lifeArea, LifeArea.personalGrowth);
      expect(ranked[3].lifeArea, LifeArea.recreationPlay);
    });
  });
}
