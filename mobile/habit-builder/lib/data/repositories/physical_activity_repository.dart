import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/physical_activity.dart';
import '../local/app_database.dart';
import '../local/database_provider.dart';

/// Repository handling persistence and observation for physical activities and daily completions.
class PhysicalActivityRepository {
  final AppDatabase _db;
  final Uuid _uuid;

  PhysicalActivityRepository(this._db, [Uuid? uuid]) : _uuid = uuid ?? const Uuid();

  Future<void> _ensureReady() async {
    await _db.ensureTablesExist();
  }

  /// Maps a Drift generated [PhysicalActivityData] row to the immutable domain [PhysicalActivity].
  PhysicalActivity _mapDataToModel(PhysicalActivityData data) {
    return PhysicalActivity(
      id: data.id,
      type: PhysicalActivityType.fromKey(data.activityType),
      customName: data.customName,
      metric: PhysicalActivityMetric.fromKey(data.metricType),
      targetValue: data.targetValue,
      createdAt: data.createdAt,
      isActive: data.isActive,
    );
  }

  /// Observes all active daily physical activities ordered chronologically.
  Stream<List<PhysicalActivity>> watchActiveActivities() async* {
    await _ensureReady();
    final query = _db.select(_db.physicalActivities)
      ..where((tbl) => tbl.isActive.equals(true))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.asc)]);

    yield* query.watch().map((rows) => rows.map(_mapDataToModel).toList());
  }

  /// Retrieves all active physical activities once.
  Future<List<PhysicalActivity>> getActiveActivities() async {
    await _ensureReady();
    final query = _db.select(_db.physicalActivities)
      ..where((tbl) => tbl.isActive.equals(true))
      ..orderBy([(tbl) => OrderingTerm(expression: tbl.createdAt, mode: OrderingMode.asc)]);

    final rows = await query.get();
    return rows.map(_mapDataToModel).toList();
  }

  /// Creates and persists a new physical activity.
  Future<PhysicalActivity> createActivity({
    required PhysicalActivityType type,
    String? customName,
    required PhysicalActivityMetric metric,
    required int targetValue,
  }) async {
    await _ensureReady();
    final id = _uuid.v4();
    final now = DateTime.now();

    await _db.into(_db.physicalActivities).insert(
          PhysicalActivitiesCompanion.insert(
            id: id,
            activityType: type.key,
            customName: Value(customName),
            metricType: metric.key,
            targetValue: targetValue,
            createdAt: now,
            isActive: const Value(true),
          ),
        );

    return PhysicalActivity(
      id: id,
      type: type,
      customName: customName,
      metric: metric,
      targetValue: targetValue,
      createdAt: now,
      isActive: true,
    );
  }

  /// Deletes a physical activity and its associated completions cascade.
  Future<void> deleteActivity(String id) async {
    await _ensureReady();
    await (_db.delete(_db.physicalActivities)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Observes completion records for a specific calendar day (normalized to midnight).
  Stream<Map<String, DailyActivityCompletionData>> watchCompletionsForDate(DateTime date) async* {
    await _ensureReady();
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final query = _db.select(_db.dailyActivitiesCompletions)
      ..where((tbl) => tbl.date.equals(normalizedDate));

    yield* query.watch().map((rows) {
      final map = <String, DailyActivityCompletionData>{};
      for (final row in rows) {
        map[row.activityId] = row;
      }
      return map;
    });
  }

  /// Retrieves completion records once for a specific calendar day.
  Future<Map<String, DailyActivityCompletionData>> getCompletionsForDate(DateTime date) async {
    await _ensureReady();
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final query = _db.select(_db.dailyActivitiesCompletions)
      ..where((tbl) => tbl.date.equals(normalizedDate));

    final rows = await query.get();
    final map = <String, DailyActivityCompletionData>{};
    for (final row in rows) {
      map[row.activityId] = row;
    }
    return map;
  }

  /// Toggles or updates the completion state of an activity for a specific calendar date.
  /// Returns the new completion state.
  Future<bool> toggleCompletion({
    required String activityId,
    required DateTime date,
    bool? completed,
  }) async {
    await _ensureReady();
    final normalizedDate = DateTime(date.year, date.month, date.day);
    final existing = await (_db.select(_db.dailyActivitiesCompletions)
          ..where((tbl) => tbl.activityId.equals(activityId) & tbl.date.equals(normalizedDate)))
        .getSingleOrNull();

    final targetCompleted = completed ?? (existing != null ? !existing.completed : true);
    final completedAt = targetCompleted ? DateTime.now() : null;

    if (existing != null) {
      await (_db.update(_db.dailyActivitiesCompletions)..where((tbl) => tbl.id.equals(existing.id))).write(
        DailyActivitiesCompletionsCompanion(
          completed: Value(targetCompleted),
          completedAt: Value(completedAt),
        ),
      );
    } else {
      await _db.into(_db.dailyActivitiesCompletions).insert(
            DailyActivitiesCompletionsCompanion.insert(
              id: _uuid.v4(),
              activityId: activityId,
              date: normalizedDate,
              completed: Value(targetCompleted),
              completedAt: Value(completedAt),
            ),
          );
    }

    return targetCompleted;
  }
}

/// Riverpod provider for [PhysicalActivityRepository].
final physicalActivityRepositoryProvider = Provider<PhysicalActivityRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return PhysicalActivityRepository(db);
});
