import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/repositories/physical_activity_repository.dart';
import 'package:habit_builder/domain/models/physical_activity.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('physical_activities & daily_activities_completions Tables and Repository', () {
    late AppDatabase database;
    late PhysicalActivityRepository repository;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      repository = PhysicalActivityRepository(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('verifies exact table names in SQLite schema', () {
      expect(database.physicalActivities.actualTableName, 'physical_activities');
      expect(
        database.dailyActivitiesCompletions.actualTableName,
        'daily_activities_completions',
      );
    });

    test('creates Walking and Running activities with duration and push-ups with repetitions',
        () async {
      final walking = await repository.createActivity(
        type: PhysicalActivityType.walking,
        metric: PhysicalActivityMetric.duration,
        targetValue: 30,
      );

      final running = await repository.createActivity(
        type: PhysicalActivityType.running,
        metric: PhysicalActivityMetric.duration,
        targetValue: 20,
      );

      final pushups = await repository.createActivity(
        type: PhysicalActivityType.pushups,
        metric: PhysicalActivityMetric.repetitions,
        targetValue: 25,
      );

      expect(walking.id, isNotEmpty);
      expect(walking.type, PhysicalActivityType.walking);
      expect(walking.metric, PhysicalActivityMetric.duration);
      expect(walking.targetValue, 30);
      expect(walking.isActive, isTrue);

      expect(running.id, isNotEmpty);
      expect(running.type, PhysicalActivityType.running);
      expect(running.metric, PhysicalActivityMetric.duration);
      expect(running.targetValue, 20);

      expect(pushups.id, isNotEmpty);
      expect(pushups.type, PhysicalActivityType.pushups);
      expect(pushups.metric, PhysicalActivityMetric.repetitions);
      expect(pushups.targetValue, 25);

      final active = await repository.getActiveActivities();
      expect(active.length, 3);
      expect(active.map((e) => e.type), containsAll([
        PhysicalActivityType.walking,
        PhysicalActivityType.running,
        PhysicalActivityType.pushups,
      ]));
    });

    test('toggles daily completion state for an activity', () async {
      final walking = await repository.createActivity(
        type: PhysicalActivityType.walking,
        metric: PhysicalActivityMetric.duration,
        targetValue: 30,
      );

      final today = DateTime.now();

      // Initially no completion
      var completions = await repository.getCompletionsForDate(today);
      expect(completions[walking.id], isNull);

      // 1. Toggle completion to true
      final completed = await repository.toggleCompletion(
        activityId: walking.id,
        date: today,
      );
      expect(completed, isTrue);

      completions = await repository.getCompletionsForDate(today);
      expect(completions[walking.id], isNotNull);
      expect(completions[walking.id]!.completed, isTrue);
      expect(completions[walking.id]!.completedAt, isNotNull);

      // 2. Toggle again to false
      final toggledOff = await repository.toggleCompletion(
        activityId: walking.id,
        date: today,
      );
      expect(toggledOff, isFalse);

      completions = await repository.getCompletionsForDate(today);
      expect(completions[walking.id], isNotNull);
      expect(completions[walking.id]!.completed, isFalse);
    });

    test('soft-deletes an activity by setting isActive to false', () async {
      final running = await repository.createActivity(
        type: PhysicalActivityType.running,
        metric: PhysicalActivityMetric.duration,
        targetValue: 15,
      );

      expect((await repository.getActiveActivities()).length, 1);

      await repository.deleteActivity(running.id);

      final remaining = await repository.getActiveActivities();
      expect(remaining, isEmpty);
    });

    test('watchActiveActivities emits reactive updates', () async {
      final stream = repository.watchActiveActivities();

      expect(
        stream,
        emitsInOrder([
          isEmpty,
          hasLength(1),
          hasLength(2),
        ]),
      );

      await Future.delayed(const Duration(milliseconds: 30));
      await repository.createActivity(
        type: PhysicalActivityType.walking,
        metric: PhysicalActivityMetric.duration,
        targetValue: 15,
      );
      await Future.delayed(const Duration(milliseconds: 30));
      await repository.createActivity(
        type: PhysicalActivityType.running,
        metric: PhysicalActivityMetric.duration,
        targetValue: 20,
      );
    });
  });
}
