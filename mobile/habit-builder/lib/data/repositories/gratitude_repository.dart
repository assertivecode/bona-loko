import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../domain/models/gratitude_entry.dart';
import '../local/app_database.dart';
import '../local/database_provider.dart';

/// Repository responsible for persisting, querying, reordering, and tracking completions
/// for gratitude entries in SQLite.
class GratitudeRepository {
  final AppDatabase _db;
  static const _uuid = Uuid();

  GratitudeRepository(this._db);

  DateTime _normalizeDate(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

  GratitudeEntry _toDomain(GratitudeEntryData row) {
    return GratitudeEntry(
      id: row.id,
      content: row.content,
      createdAt: row.createdAt,
      period: GratitudePeriod.fromString(row.period),
      orderIndex: row.orderIndex,
    );
  }

  GratitudeEntriesCompanion _toCompanion(GratitudeEntry entry) {
    return GratitudeEntriesCompanion.insert(
      id: entry.id,
      content: entry.content,
      createdAt: entry.createdAt,
      period: Value(entry.period.toDbString()),
      orderIndex: Value(entry.orderIndex),
    );
  }

  DailyGratitudeCompletion _completionToDomain(DailyGratitudeCompletionData row) {
    return DailyGratitudeCompletion(
      id: row.id,
      date: row.date,
      morningCompleted: row.morningCompleted,
      morningCompletedAt: row.morningCompletedAt,
      eveningCompleted: row.eveningCompleted,
      eveningCompletedAt: row.eveningCompletedAt,
    );
  }

  /// Reactively streams all gratitude entries ordered by user preference (orderIndex ASC, createdAt ASC).
  Stream<List<GratitudeEntry>> watchAllEntries() {
    return (_db.select(_db.gratitudeEntries)
          ..orderBy([
            (t) => OrderingTerm.asc(t.orderIndex),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .watch()
        .map((rows) => rows.map(_toDomain).toList());
  }

  /// Retrieves all gratitude entries ordered by user preference.
  Future<List<GratitudeEntry>> getAllEntries() async {
    final rows = await (_db.select(_db.gratitudeEntries)
          ..orderBy([
            (t) => OrderingTerm.asc(t.orderIndex),
            (t) => OrderingTerm.asc(t.createdAt),
          ]))
        .get();
    return rows.map(_toDomain).toList();
  }

  /// Adds and persists a new gratitude entry at the end of the user's custom ordered list.
  Future<GratitudeEntry> addEntry({
    required String content,
    GratitudePeriod period = GratitudePeriod.anytime,
    DateTime? createdAt,
  }) async {
    final entries = await getAllEntries();
    final nextOrderIndex = entries.isEmpty
        ? 0
        : entries.map((e) => e.orderIndex).reduce((a, b) => a > b ? a : b) + 1;

    final entry = GratitudeEntry(
      id: _uuid.v4(),
      content: content.trim(),
      createdAt: createdAt ?? DateTime.now(),
      period: period,
      orderIndex: nextOrderIndex,
    );
    await _db.into(_db.gratitudeEntries).insert(_toCompanion(entry));
    return entry;
  }

  /// Persists a new user-defined order for gratitude entries.
  Future<void> reorderEntries(List<String> orderedIds) async {
    await _db.transaction(() async {
      for (var i = 0; i < orderedIds.length; i++) {
        await (_db.update(_db.gratitudeEntries)..where((tbl) => tbl.id.equals(orderedIds[i])))
            .write(GratitudeEntriesCompanion(orderIndex: Value(i)));
      }
    });
  }

  /// Deletes a specific gratitude entry by its unique ID.
  Future<void> deleteEntry(String id) async {
    await (_db.delete(_db.gratitudeEntries)..where((tbl) => tbl.id.equals(id))).go();
  }

  /// Reactively streams the daily gratitude completion for a given calendar date.
  Stream<DailyGratitudeCompletion?> watchDailyCompletion(DateTime date) {
    final normalized = _normalizeDate(date);
    return (_db.select(_db.dailyGratitudeCompletions)
          ..where((tbl) => tbl.date.equals(normalized)))
        .watchSingleOrNull()
        .map((row) => row != null ? _completionToDomain(row) : null);
  }

  /// Retrieves or initializes a daily gratitude completion record for the specified date.
  Future<DailyGratitudeCompletion> getOrCreateDailyCompletion(DateTime date) async {
    final normalized = _normalizeDate(date);
    final existing = await (_db.select(_db.dailyGratitudeCompletions)
          ..where((tbl) => tbl.date.equals(normalized)))
        .getSingleOrNull();

    if (existing != null) {
      return _completionToDomain(existing);
    }

    final newId = _uuid.v4();
    await _db.into(_db.dailyGratitudeCompletions).insert(
          DailyGratitudeCompletionsCompanion.insert(
            id: newId,
            date: normalized,
            morningCompleted: const Value(false),
            eveningCompleted: const Value(false),
          ),
        );

    return DailyGratitudeCompletion(
      id: newId,
      date: normalized,
      morningCompleted: false,
      eveningCompleted: false,
    );
  }

  /// Toggles morning grounding completion for the given date.
  Future<DailyGratitudeCompletion> toggleMorningCompletion(DateTime date) async {
    final current = await getOrCreateDailyCompletion(date);
    final newMorning = !current.morningCompleted;
    final now = DateTime.now();

    await (_db.update(_db.dailyGratitudeCompletions)..where((tbl) => tbl.id.equals(current.id)))
        .write(DailyGratitudeCompletionsCompanion(
          morningCompleted: Value(newMorning),
          morningCompletedAt: Value(newMorning ? now : null),
        ));

    return DailyGratitudeCompletion(
      id: current.id,
      date: current.date,
      morningCompleted: newMorning,
      morningCompletedAt: newMorning ? now : null,
      eveningCompleted: current.eveningCompleted,
      eveningCompletedAt: current.eveningCompletedAt,
    );
  }

  /// Toggles evening reflection completion for the given date.
  Future<DailyGratitudeCompletion> toggleEveningCompletion(DateTime date) async {
    final current = await getOrCreateDailyCompletion(date);
    final newEvening = !current.eveningCompleted;
    final now = DateTime.now();

    await (_db.update(_db.dailyGratitudeCompletions)..where((tbl) => tbl.id.equals(current.id)))
        .write(DailyGratitudeCompletionsCompanion(
          eveningCompleted: Value(newEvening),
          eveningCompletedAt: Value(newEvening ? now : null),
        ));

    return DailyGratitudeCompletion(
      id: current.id,
      date: current.date,
      morningCompleted: current.morningCompleted,
      morningCompletedAt: current.morningCompletedAt,
      eveningCompleted: newEvening,
      eveningCompletedAt: newEvening ? now : null,
    );
  }
}

/// Riverpod provider for [GratitudeRepository].
final gratitudeRepositoryProvider = Provider<GratitudeRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return GratitudeRepository(db);
});

/// Riverpod StreamProvider for reactively watching all gratitude entries ordered.
final gratitudeEntriesStreamProvider = StreamProvider<List<GratitudeEntry>>((ref) {
  final repo = ref.watch(gratitudeRepositoryProvider);
  return repo.watchAllEntries();
});

/// Riverpod StreamProvider for reactively watching today's gratitude completion.
final todayGratitudeCompletionStreamProvider = StreamProvider<DailyGratitudeCompletion>((ref) {
  final repo = ref.watch(gratitudeRepositoryProvider);
  final today = DateTime.now();
  return repo.watchDailyCompletion(today).map((record) =>
      record ??
      DailyGratitudeCompletion(
        id: '',
        date: DateTime(today.year, today.month, today.day),
        morningCompleted: false,
        eveningCompleted: false,
      ));
});
