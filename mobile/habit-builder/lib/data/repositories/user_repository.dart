import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../local/app_database.dart';
import '../local/database_provider.dart';
import '../local/tables/users_table.dart';

/// Repository responsible for persisting and retrieving user preferences
/// (preferred language, name, created_at, UUID) from the local SQLite 'users' table.
class UserRepository {
  final AppDatabase _db;
  final Uuid _uuid;

  UserRepository(this._db, [Uuid? uuid]) : _uuid = uuid ?? const Uuid();

  /// Retrieves the single local user profile or null if not yet created.
  Future<UserData?> getUser() async {
    return (_db.select(_db.users)..limit(1)).getSingleOrNull();
  }

  /// Observes the single local user profile reactively.
  Stream<UserData?> watchUser() {
    return (_db.select(_db.users)..limit(1)).watchSingleOrNull();
  }

  /// Saves or updates the preferred language in the SQLite 'users' table.
  /// Esperanto = 1, Portuguese = 2, English = 3.
  Future<UserData> saveLanguage(AppLanguage language) async {
    final existing = await getUser();
    if (existing != null) {
      await (_db.update(_db.users)..where((tbl) => tbl.id.equals(existing.id))).write(
        UsersCompanion(
          selectedLanguage: Value(language),
        ),
      );
      return (await getUser())!;
    } else {
      final newUser = UsersCompanion.insert(
        id: _uuid.v4(),
        createdAt: DateTime.now(),
        selectedLanguage: language,
        name: const Value(''),
      );
      await _db.into(_db.users).insert(newUser);
      return (await getUser())!;
    }
  }

  /// Saves or updates the user's name in the SQLite 'users' table.
  Future<UserData> saveName(String name) async {
    final existing = await getUser();
    if (existing != null) {
      await (_db.update(_db.users)..where((tbl) => tbl.id.equals(existing.id))).write(
        UsersCompanion(
          name: Value(name),
        ),
      );
      return (await getUser())!;
    } else {
      final newUser = UsersCompanion.insert(
        id: _uuid.v4(),
        createdAt: DateTime.now(),
        selectedLanguage: AppLanguage.english,
        name: Value(name),
      );
      await _db.into(_db.users).insert(newUser);
      return (await getUser())!;
    }
  }

  /// Sets whether the user has completed the initial onboarding setup.
  Future<UserData> setOnboardingCompleted(bool completed) async {
    final existing = await getUser();
    if (existing != null) {
      await (_db.update(_db.users)..where((tbl) => tbl.id.equals(existing.id))).write(
        UsersCompanion(
          onboardingCompleted: Value(completed),
        ),
      );
      return (await getUser())!;
    } else {
      final newUser = UsersCompanion.insert(
        id: _uuid.v4(),
        createdAt: DateTime.now(),
        selectedLanguage: AppLanguage.english,
        name: const Value(''),
        onboardingCompleted: Value(completed),
      );
      await _db.into(_db.users).insert(newUser);
      return (await getUser())!;
    }
  }
}

/// Riverpod provider for UserRepository.
final userRepositoryProvider = Provider<UserRepository>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return UserRepository(db);
});
