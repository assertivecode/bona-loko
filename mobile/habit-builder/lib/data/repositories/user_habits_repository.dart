import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../local/app_database.dart';
import '../local/database_provider.dart';

/// Repository for managing user selected habits and routine persistence.
class UserHabitsRepository {
  final AppDatabase _db;

  UserHabitsRepository(this._db);

  /// Streams the list of active habit IDs in the user's daily routine.
  Stream<List<String>> watchSelectedHabitIds() {
    return (_db.select(_db.userHabits)
          ..where((tbl) => tbl.isActive.equals(true))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.selectedAt)]))
        .watch()
        .map((rows) => rows.map((r) => r.id).toList());
  }

  /// Fetches the current list of active habit IDs synchronously/async once.
  Future<List<String>> getSelectedHabitIds() async {
    final rows = await (_db.select(_db.userHabits)
          ..where((tbl) => tbl.isActive.equals(true))
          ..orderBy([(tbl) => OrderingTerm.asc(tbl.selectedAt)]))
        .get();
    return rows.map((r) => r.id).toList();
  }

  /// Checks if a specific habit is actively selected.
  Future<bool> isHabitSelected(String habitId) async {
    final row = await (_db.select(_db.userHabits)
          ..where((tbl) => tbl.id.equals(habitId) & tbl.isActive.equals(true)))
        .getSingleOrNull();
    return row != null;
  }

  /// Toggles habit selection for the user's daily routine.
  Future<void> toggleHabitSelection(String habitId) async {
    final existing = await (_db.select(_db.userHabits)
          ..where((tbl) => tbl.id.equals(habitId)))
        .getSingleOrNull();

    if (existing == null) {
      await _db.into(_db.userHabits).insert(
            UserHabitsCompanion.insert(
              id: habitId,
              selectedAt: DateTime.now(),
              isActive: const Value(true),
            ),
          );
    } else {
      await (_db.update(_db.userHabits)..where((tbl) => tbl.id.equals(habitId)))
          .write(
        UserHabitsCompanion(
          isActive: Value(!existing.isActive),
          selectedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  /// Explicitly selects a habit.
  Future<void> selectHabit(String habitId) async {
    final existing = await (_db.select(_db.userHabits)
          ..where((tbl) => tbl.id.equals(habitId)))
        .getSingleOrNull();

    if (existing == null) {
      await _db.into(_db.userHabits).insert(
            UserHabitsCompanion.insert(
              id: habitId,
              selectedAt: DateTime.now(),
              isActive: const Value(true),
            ),
          );
    } else if (!existing.isActive) {
      await (_db.update(_db.userHabits)..where((tbl) => tbl.id.equals(habitId)))
          .write(
        UserHabitsCompanion(
          isActive: const Value(true),
          selectedAt: Value(DateTime.now()),
        ),
      );
    }
  }

  /// Explicitly unselects a habit.
  Future<void> unselectHabit(String habitId) async {
    await (_db.update(_db.userHabits)..where((tbl) => tbl.id.equals(habitId)))
        .write(
      const UserHabitsCompanion(
        isActive: Value(false),
      ),
    );
  }
}

/// Riverpod provider for [UserHabitsRepository].
final userHabitsRepositoryProvider = Provider<UserHabitsRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return UserHabitsRepository(db);
});

/// Reactive stream provider for the active selected habit IDs.
final selectedHabitIdsStreamProvider = StreamProvider<List<String>>((ref) {
  final repo = ref.watch(userHabitsRepositoryProvider);
  return repo.watchSelectedHabitIds();
});
