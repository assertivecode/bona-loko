import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/domain/models/life_area.dart';
import 'package:habit_builder/domain/models/suggested_habit.dart';

void main() {
  group('SuggestedHabit Model Invariants & Validations', () {
    test('Constructs successfully with valid weights (1..5)', () {
      final habit = SuggestedHabit(
        id: 'habit_test_exercise',
        title: 'Daily Exercise',
        description: 'Movement for body and mind',
        areaWeights: {
          LifeArea.healthFitness: 5,
          LifeArea.emotionalWellbeing: 4,
          LifeArea.focusMastery: 3,
          LifeArea.recreationPlay: 2,
        },
      );

      expect(habit.id, 'habit_test_exercise');
      expect(habit.title, 'Daily Exercise');
      expect(habit.weightFor(LifeArea.healthFitness), 5);
      expect(habit.weightFor(LifeArea.emotionalWellbeing), 4);
      expect(habit.weightFor(LifeArea.focusMastery), 3);
      expect(habit.weightFor(LifeArea.recreationPlay), 2);
      expect(habit.weightFor(LifeArea.financesWealth), 0);
      expect(habit.hasHighSynergyWith(LifeArea.healthFitness), isTrue);
      expect(habit.hasHighSynergyWith(LifeArea.recreationPlay), isFalse);
    });

    test('Throws ArgumentError when weight is less than 1', () {
      expect(
        () => SuggestedHabit(
          id: 'habit_invalid_zero',
          title: 'Invalid Habit',
          description: 'Desc',
          areaWeights: {
            LifeArea.healthFitness: 0,
          },
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Throws ArgumentError when weight is greater than 5', () {
      expect(
        () => SuggestedHabit(
          id: 'habit_invalid_six',
          title: 'Invalid Habit',
          description: 'Desc',
          areaWeights: {
            LifeArea.healthFitness: 6,
          },
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Throws ArgumentError when ID or title is empty', () {
      expect(
        () => SuggestedHabit(
          id: '',
          title: 'Valid Title',
          description: 'Desc',
          areaWeights: {LifeArea.healthFitness: 3},
        ),
        throwsA(isA<ArgumentError>()),
      );

      expect(
        () => SuggestedHabit(
          id: 'habit_valid_id',
          title: '   ',
          description: 'Desc',
          areaWeights: {LifeArea.healthFitness: 3},
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Throws ArgumentError when areaWeights is empty', () {
      expect(
        () => SuggestedHabit(
          id: 'habit_no_areas',
          title: 'No Areas',
          description: 'Desc',
          areaWeights: {},
        ),
        throwsA(isA<ArgumentError>()),
      );
    });

    test('Canonical habits list includes exercise habit matching user prompt example', () {
      final habits = SuggestedHabit.canonicalHabits;
      expect(habits, isNotEmpty);

      final exerciseHabit = habits.firstWhere(
        (h) => h.id == 'habit_regular_exercise_workout',
      );
      expect(exerciseHabit.weightFor(LifeArea.healthFitness), 5);
      expect(exerciseHabit.weightFor(LifeArea.emotionalWellbeing), 4);
      expect(exerciseHabit.weightFor(LifeArea.focusMastery), 3);
      expect(exerciseHabit.weightFor(LifeArea.recreationPlay), 2);
    });
  });
}
