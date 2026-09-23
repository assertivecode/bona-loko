import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models/life_area.dart';
import '../../domain/models/life_area_evaluation.dart';
import '../local/app_database.dart';
import '../local/database_provider.dart';

/// Repository responsible for persisting and querying life area evaluations
/// in the SQLite "life_areas_evaluations" table.
class LifeAreaEvaluationRepository {
  final AppDatabase _db;

  LifeAreaEvaluationRepository(this._db);

  /// Converts a Drift row [LifeAreaEvaluationData] to the immutable domain [LifeAreaEvaluation].
  LifeAreaEvaluation _toDomain(LifeAreaEvaluationData row) {
    return LifeAreaEvaluation(
      id: row.id,
      lifeArea: row.lifeArea,
      score: row.score,
      currentPriority: row.currentPriority,
      evaluatedAt: row.evaluatedAt,
    );
  }

  /// Converts an immutable domain [LifeAreaEvaluation] to a Drift insert companion.
  LifeAreasEvaluationsCompanion _toCompanion(LifeAreaEvaluation domain) {
    return LifeAreasEvaluationsCompanion.insert(
      id: domain.id,
      lifeArea: domain.lifeArea,
      score: domain.score,
      currentPriority: domain.currentPriority,
      evaluatedAt: domain.evaluatedAt,
    );
  }

  /// Persists a single life area evaluation, replacing any previous record for that area.
  Future<void> saveEvaluation(LifeAreaEvaluation evaluation) async {
    await _db.transaction(() async {
      await (_db.delete(_db.lifeAreasEvaluations)
            ..where((tbl) => tbl.lifeArea.equals(evaluation.lifeArea.value)))
          .go();
      await _db.into(_db.lifeAreasEvaluations).insert(_toCompanion(evaluation));
    });
  }

  /// Persists a batch of evaluations within a single database transaction.
  Future<void> saveBatchEvaluations(List<LifeAreaEvaluation> evaluations) async {
    await _db.transaction(() async {
      for (final evaluation in evaluations) {
        await (_db.delete(_db.lifeAreasEvaluations)
              ..where((tbl) => tbl.lifeArea.equals(evaluation.lifeArea.value)))
            .go();
        await _db.into(_db.lifeAreasEvaluations).insert(_toCompanion(evaluation));
      }
    });
  }

  /// Retrieves the latest evaluation for each of the 12 life areas.
  Future<Map<LifeArea, LifeAreaEvaluation>> getLatestEvaluations() async {
    final allRows = await (_db.select(_db.lifeAreasEvaluations)
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.evaluatedAt)]))
        .get();

    final Map<LifeArea, LifeAreaEvaluation> latestMap = {};
    for (final row in allRows) {
      if (!latestMap.containsKey(row.lifeArea)) {
        latestMap[row.lifeArea] = _toDomain(row);
      }
    }
    return latestMap;
  }

  /// Observes the latest evaluation for each life area reactively.
  Stream<Map<LifeArea, LifeAreaEvaluation>> watchLatestEvaluations() {
    return (_db.select(_db.lifeAreasEvaluations)
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.evaluatedAt)]))
        .watch()
        .map((rows) {
      final Map<LifeArea, LifeAreaEvaluation> latestMap = {};
      for (final row in rows) {
        if (!latestMap.containsKey(row.lifeArea)) {
          latestMap[row.lifeArea] = _toDomain(row);
        }
      }
      return latestMap;
    });
  }

  /// Retrieves the most recent evaluation for a specific life area, or null if none exists.
  Future<LifeAreaEvaluation?> getEvaluationForArea(LifeArea area) async {
    final row = await (_db.select(_db.lifeAreasEvaluations)
          ..where((tbl) => tbl.lifeArea.equals(area.value))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.evaluatedAt)])
          ..limit(1))
        .getSingleOrNull();

    return row != null ? _toDomain(row) : null;
  }

  /// Retrieves all historical evaluations for a given area, newest first.
  Future<List<LifeAreaEvaluation>> getHistoryForArea(LifeArea area) async {
    final rows = await (_db.select(_db.lifeAreasEvaluations)
          ..where((tbl) => tbl.lifeArea.equals(area.value))
          ..orderBy([(tbl) => OrderingTerm.desc(tbl.evaluatedAt)]))
        .get();

    return rows.map(_toDomain).toList();
  }

  /// Checks whether all 12 canonical life areas have been evaluated at least once.
  Future<bool> hasCompletedBaseline() async {
    final latest = await getLatestEvaluations();
    return latest.length >= 12;
  }
}

/// Riverpod provider for [LifeAreaEvaluationRepository].
final lifeAreaEvaluationRepositoryProvider =
    Provider<LifeAreaEvaluationRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return LifeAreaEvaluationRepository(db);
});
