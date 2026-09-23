import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/domain/models/life_area.dart';
import 'package:habit_builder/domain/models/life_area_evaluation.dart';

void main() {
  group('LifeArea Integer Enum', () {
    test('contains all 12 canonical life areas with 1-based integer values', () {
      expect(LifeArea.values.length, 12);

      expect(LifeArea.healthFitness.value, 1);
      expect(LifeArea.healthFitness.key, 'health_fitness');

      expect(LifeArea.emotionalWellbeing.value, 2);
      expect(LifeArea.emotionalWellbeing.key, 'emotional_wellbeing');

      expect(LifeArea.personalGrowth.value, 3);
      expect(LifeArea.personalGrowth.key, 'personal_growth');

      expect(LifeArea.careerCalling.value, 4);
      expect(LifeArea.careerCalling.key, 'career_calling');

      expect(LifeArea.financesWealth.value, 5);
      expect(LifeArea.financesWealth.key, 'finances_wealth');

      expect(LifeArea.relationshipsIntimacy.value, 6);
      expect(LifeArea.relationshipsIntimacy.key, 'relationships_intimacy');

      expect(LifeArea.familyParenting.value, 7);
      expect(LifeArea.familyParenting.key, 'family_parenting');

      expect(LifeArea.friendshipsCommunity.value, 8);
      expect(LifeArea.friendshipsCommunity.key, 'friendships_community');

      expect(LifeArea.physicalEnvironment.value, 9);
      expect(LifeArea.physicalEnvironment.key, 'physical_environment');

      expect(LifeArea.recreationPlay.value, 10);
      expect(LifeArea.recreationPlay.key, 'recreation_play');

      expect(LifeArea.focusMastery.value, 11);
      expect(LifeArea.focusMastery.key, 'focus_mastery');

      expect(LifeArea.contributionLegacy.value, 12);
      expect(LifeArea.contributionLegacy.key, 'contribution_legacy');
    });

    test('resolves from value and key correctly', () {
      expect(LifeArea.fromValue(1), LifeArea.healthFitness);
      expect(LifeArea.fromValue(12), LifeArea.contributionLegacy);

      expect(LifeArea.fromKey('personal_growth'), LifeArea.personalGrowth);
      expect(LifeArea.fromKey('focus_mastery'), LifeArea.focusMastery);
    });

    test('throws ArgumentError on invalid value or key', () {
      expect(() => LifeArea.fromValue(0), throwsArgumentError);
      expect(() => LifeArea.fromValue(13), throwsArgumentError);
      expect(() => LifeArea.fromKey('invalid_area'), throwsArgumentError);
    });
  });

  group('LifeAreaEvaluation Domain Model', () {
    test('instantiates valid evaluation with half decimal score and priority 1..5', () {
      final now = DateTime.now();
      final eval = LifeAreaEvaluation(
        id: 'eval-1',
        lifeArea: LifeArea.healthFitness,
        score: 7.5,
        currentPriority: 5,
        evaluatedAt: now,
      );

      expect(eval.id, 'eval-1');
      expect(eval.lifeArea, LifeArea.healthFitness);
      expect(eval.score, 7.5);
      expect(eval.currentPriority, 5);
      expect(eval.evaluatedAt, now);
    });

    test('validates score range [0.0, 10.0]', () {
      final now = DateTime.now();

      expect(
        () => LifeAreaEvaluation(
          id: '1',
          lifeArea: LifeArea.healthFitness,
          score: -0.5,
          currentPriority: 3,
          evaluatedAt: now,
        ),
        throwsArgumentError,
      );

      expect(
        () => LifeAreaEvaluation(
          id: '1',
          lifeArea: LifeArea.healthFitness,
          score: 10.5,
          currentPriority: 3,
          evaluatedAt: now,
        ),
        throwsArgumentError,
      );
    });

    test('validates half decimal precision (whole or half integers only)', () {
      final now = DateTime.now();

      // Valid: 0.0, 0.5, 7.0, 7.5, 10.0
      expect(
        LifeAreaEvaluation(
          id: '1',
          lifeArea: LifeArea.healthFitness,
          score: 0.0,
          currentPriority: 1,
          evaluatedAt: now,
        ).score,
        0.0,
      );

      expect(
        LifeAreaEvaluation(
          id: '2',
          lifeArea: LifeArea.healthFitness,
          score: 8.5,
          currentPriority: 4,
          evaluatedAt: now,
        ).score,
        8.5,
      );

      // Invalid precision: 7.3, 8.25
      expect(
        () => LifeAreaEvaluation(
          id: '3',
          lifeArea: LifeArea.healthFitness,
          score: 7.3,
          currentPriority: 3,
          evaluatedAt: now,
        ),
        throwsArgumentError,
      );
    });

    test('validates currentPriority range [1, 5]', () {
      final now = DateTime.now();

      expect(
        () => LifeAreaEvaluation(
          id: '1',
          lifeArea: LifeArea.healthFitness,
          score: 5.0,
          currentPriority: 0,
          evaluatedAt: now,
        ),
        throwsArgumentError,
      );

      expect(
        () => LifeAreaEvaluation(
          id: '2',
          lifeArea: LifeArea.healthFitness,
          score: 5.0,
          currentPriority: 6,
          evaluatedAt: now,
        ),
        throwsArgumentError,
      );
    });
  });
}
