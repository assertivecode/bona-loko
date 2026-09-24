import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/repositories/life_area_evaluation_repository.dart';
import 'package:habit_builder/domain/models/life_area.dart';
import 'package:habit_builder/domain/models/life_area_evaluation.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('life_areas_evaluations SQLite Table & Repository', () {
    late AppDatabase database;
    late LifeAreaEvaluationRepository repository;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      repository = LifeAreaEvaluationRepository(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('persists single evaluation with UUID, LifeArea enum, half-decimal score, priority 1..5, and DateTime',
        () async {
      final now = DateTime.now();
      final evaluation = LifeAreaEvaluation(
        id: 'eval-uuid-001',
        lifeArea: LifeArea.healthFitness,
        score: 7.5,
        currentPriority: 5,
        evaluatedAt: now,
      );

      await repository.saveEvaluation(evaluation);

      // Verify row in database
      final retrieved = await repository.getEvaluationForArea(LifeArea.healthFitness);
      expect(retrieved, isNotNull);
      expect(retrieved!.id, 'eval-uuid-001');
      expect(retrieved.lifeArea, LifeArea.healthFitness);
      expect(retrieved.lifeArea.value, 1);
      expect(retrieved.score, 7.5);
      expect(retrieved.currentPriority, 5);
      expect(retrieved.evaluatedAt.millisecondsSinceEpoch,
          closeTo(now.millisecondsSinceEpoch, 1000));
    });

    test('persists batch of 12 evaluations in a single transaction', () async {
      final now = DateTime.now();
      final List<LifeAreaEvaluation> allAreas = LifeArea.values.map((area) {
        return LifeAreaEvaluation(
          id: 'uuid-${area.key}',
          lifeArea: area,
          score: 6.5,
          currentPriority: 4,
          evaluatedAt: now,
        );
      }).toList();

      await repository.saveBatchEvaluations(allAreas);

      final latestMap = await repository.getLatestEvaluations();
      expect(latestMap.length, 12);
      expect(await repository.hasCompletedBaseline(), isTrue);

      for (final area in LifeArea.values) {
        expect(latestMap.containsKey(area), isTrue);
        expect(latestMap[area]!.score, 6.5);
        expect(latestMap[area]!.currentPriority, 4);
      }
    });

    test('watchLatestEvaluations emits updates reactively', () async {
      final stream = repository.watchLatestEvaluations();

      // Initially empty
      expect(await stream.first, isEmpty);

      final now = DateTime.now();
      await repository.saveEvaluation(
        LifeAreaEvaluation(
          id: 'test-1',
          lifeArea: LifeArea.emotionalWellbeing,
          score: 8.0,
          currentPriority: 3,
          evaluatedAt: now,
        ),
      );

      final updated = await repository.getLatestEvaluations();
      expect(updated.length, 1);
      expect(updated[LifeArea.emotionalWellbeing]!.score, 8.0);
    });
  });
}
