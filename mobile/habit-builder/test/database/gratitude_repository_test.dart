import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/repositories/gratitude_repository.dart';
import 'package:habit_builder/domain/models/gratitude_entry.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('gratitude_entries & daily_gratitude_completions SQLite Tables & GratitudeRepository', () {
    late AppDatabase database;
    late GratitudeRepository repository;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      repository = GratitudeRepository(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('persists a gratitude entry with content, timestamp, period, and orderIndex', () async {
      final now = DateTime(2026, 9, 21, 8, 30);
      final created = await repository.addEntry(
        content: 'Warm cup of coffee and morning sunlight',
        period: GratitudePeriod.morning,
        createdAt: now,
      );

      expect(created.id, isNotEmpty);
      expect(created.content, 'Warm cup of coffee and morning sunlight');
      expect(created.period, GratitudePeriod.morning);
      expect(created.createdAt, now);
      expect(created.orderIndex, 0);

      final all = await repository.getAllEntries();
      expect(all.length, 1);
      expect(all.first.id, created.id);
      expect(all.first.content, created.content);
      expect(all.first.period, GratitudePeriod.morning);
    });

    test('reorders gratitude entries according to user preference and persists order', () async {
      final e1 = await repository.addEntry(content: 'First entry');
      final e2 = await repository.addEntry(content: 'Second entry');
      final e3 = await repository.addEntry(content: 'Third entry');

      var all = await repository.getAllEntries();
      expect(all.map((e) => e.content).toList(), ['First entry', 'Second entry', 'Third entry']);

      // User moves 'Third entry' to the top
      await repository.reorderEntries([e3.id, e1.id, e2.id]);

      all = await repository.getAllEntries();
      expect(all.map((e) => e.content).toList(), ['Third entry', 'First entry', 'Second entry']);
      expect(all[0].orderIndex, 0);
      expect(all[1].orderIndex, 1);
      expect(all[2].orderIndex, 2);
    });

    test('deletes an entry by its ID', () async {
      final entry = await repository.addEntry(content: 'Temporary note');
      expect((await repository.getAllEntries()).length, 1);

      await repository.deleteEntry(entry.id);
      expect((await repository.getAllEntries()).length, 0);
    });

    test('tracks daily gratitude completions for morning and evening', () async {
      final today = DateTime.now();

      // Initially no completion
      var completion = await repository.getOrCreateDailyCompletion(today);
      expect(completion.morningCompleted, isFalse);
      expect(completion.eveningCompleted, isFalse);

      // Toggle morning completion
      completion = await repository.toggleMorningCompletion(today);
      expect(completion.morningCompleted, isTrue);
      expect(completion.morningCompletedAt, isNotNull);
      expect(completion.eveningCompleted, isFalse);

      // Toggle evening completion
      completion = await repository.toggleEveningCompletion(today);
      expect(completion.morningCompleted, isTrue);
      expect(completion.eveningCompleted, isTrue);
      expect(completion.eveningCompletedAt, isNotNull);
      expect(completion.isFullyCompleted, isTrue);

      // Toggle morning off
      completion = await repository.toggleMorningCompletion(today);
      expect(completion.morningCompleted, isFalse);
      expect(completion.morningCompletedAt, isNull);
      expect(completion.eveningCompleted, isTrue);
    });

    test('watchAllEntries emits reactive updates when new entries are added', () async {
      final stream = repository.watchAllEntries();

      expect(
        stream,
        emitsInOrder([
          isEmpty,
          hasLength(1),
          hasLength(2),
        ]),
      );

      await Future.delayed(const Duration(milliseconds: 50));
      await repository.addEntry(content: 'Entry 1');
      await Future.delayed(const Duration(milliseconds: 50));
      await repository.addEntry(content: 'Entry 2');
    });
  });
}
