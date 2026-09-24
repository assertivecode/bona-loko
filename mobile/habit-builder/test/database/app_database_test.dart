import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/data/local/app_database.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('AppDatabase with Drift', () {
    late AppDatabase database;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
    });

    tearDown(() async {
      await database.close();
    });

    test('supports lambda syntax queries and relational cascade', () async {
      final now = DateTime.now();

      // Insert Assessment
      await database.into(database.assessments).insert(
            AssessmentsCompanion.insert(
              id: 'assessment-001',
              createdAt: now,
              status: 'draft',
            ),
          );

      // Query with lambda syntax
      final activeDraft = await (database.select(database.assessments)
            ..where((tbl) =>
                tbl.id.equals('assessment-001') & tbl.status.equals('draft')))
          .getSingle();

      expect(activeDraft.id, 'assessment-001');
      expect(activeDraft.status, 'draft');

      // Insert Assessment Area Scores
      await database.into(database.assessmentAreaScores).insert(
            AssessmentAreaScoresCompanion.insert(
              id: 'score-001',
              assessmentId: 'assessment-001',
              areaKey: 'health_fitness',
              currentPriority: 9,
              currentState: 4,
              currentInvestment: 3,
              desiredInvestment: 8,
              intent: 'improve',
              investmentDelta: 5,
              priorityGapScore: 4.5,
            ),
          );

      await database.into(database.assessmentAreaScores).insert(
            AssessmentAreaScoresCompanion.insert(
              id: 'score-002',
              assessmentId: 'assessment-001',
              areaKey: 'emotional_wellbeing',
              currentPriority: 7,
              currentState: 6,
              currentInvestment: 5,
              desiredInvestment: 6,
              intent: 'maintain',
              investmentDelta: 1,
              priorityGapScore: 0.7,
            ),
          );

      // Lambda query: Filter by priority gap deficit >= 4.0
      final highDeficits = await (database.select(database.assessmentAreaScores)
            ..where((tbl) =>
                tbl.assessmentId.equals('assessment-001') &
                tbl.priorityGapScore.isBiggerOrEqualValue(4.0))
            ..orderBy([(tbl) => OrderingTerm.desc(tbl.priorityGapScore)]))
          .get();

      expect(highDeficits.length, 1);
      expect(highDeficits.first.areaKey, 'health_fitness');
      expect(highDeficits.first.priorityGapScore, 4.5);

      // Delete assessment and verify CASCADE deletion of area scores
      await (database.delete(database.assessments)
            ..where((tbl) => tbl.id.equals('assessment-001')))
          .go();

      final remainingScores = await (database.select(database.assessmentAreaScores)
            ..where((tbl) => tbl.assessmentId.equals('assessment-001')))
          .get();

      expect(remainingScores, isEmpty);
    });

    test('ensureTablesExist verifies and self-heals required schema tables', () async {
      await database.ensureTablesExist();

      // Query sqlite_master to verify physical_activities exists
      final result = await database.customSelect(
        "SELECT count(*) as cnt FROM sqlite_master WHERE type='table' AND name='physical_activities'",
      ).getSingle();

      expect(result.read<int>('cnt'), 1);

      final completionsResult = await database.customSelect(
        "SELECT count(*) as cnt FROM sqlite_master WHERE type='table' AND name='daily_activities_completions'",
      ).getSingle();

      expect(completionsResult.read<int>('cnt'), 1);
    });
  });
}
