import 'dart:ui';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:habit_builder/data/local/app_database.dart';
import 'package:habit_builder/data/local/tables/users_table.dart';
import 'package:habit_builder/data/repositories/user_repository.dart';
import '../test_helper.dart';

void main() {
  setUpAll(() {
    setupTestDatabase();
  });

  group('Users Table & UserRepository', () {
    late AppDatabase database;
    late UserRepository repository;

    setUp(() {
      database = AppDatabase(NativeDatabase.memory());
      repository = UserRepository(database);
    });

    tearDown(() async {
      await database.close();
    });

    test('persists user with UUID, createdAt, selectedLanguage, and name', () async {
      final now = DateTime.now();

      // Direct insert into Drift users table
      await database.into(database.users).insert(
            UsersCompanion.insert(
              id: 'test-uuid-001',
              createdAt: now,
              selectedLanguage: AppLanguage.portuguese,
              name: const Value('Alex Silva'),
            ),
          );

      // Verify row in database
      final user = await (database.select(database.users)
            ..where((tbl) => tbl.id.equals('test-uuid-001')))
          .getSingle();

      expect(user.id, 'test-uuid-001');
      expect(user.name, 'Alex Silva');
      expect(user.selectedLanguage, AppLanguage.portuguese);
      expect(user.selectedLanguage.id, 2);

      // Check raw SQL value of selected_language column to guarantee enum integer ID
      final rawResult = await database.customSelect(
        'SELECT id, created_at, selected_language, name FROM users WHERE id = ?',
        variables: [const Variable('test-uuid-001')],
      ).getSingle();

      expect(rawResult.read<int>('selected_language'), 2);
    });

    test('verifies enum integer IDs: Esperanto=1, Portuguese=2, English=3', () {
      expect(AppLanguage.esperanto.id, 1);
      expect(AppLanguage.portuguese.id, 2);
      expect(AppLanguage.english.id, 3);

      expect(AppLanguage.fromId(1), AppLanguage.esperanto);
      expect(AppLanguage.fromId(2), AppLanguage.portuguese);
      expect(AppLanguage.fromId(3), AppLanguage.english);
    });

    test('UserRepository automatically creates user on language selection and updates on name input', () async {
      // 1. Select language first (Esperanto)
      final userAfterLang = await repository.saveLanguage(AppLanguage.esperanto);
      expect(userAfterLang.id, isNotEmpty);
      expect(userAfterLang.selectedLanguage, AppLanguage.esperanto);
      expect(userAfterLang.selectedLanguage.id, 1);
      expect(userAfterLang.name, isEmpty);

      final initialId = userAfterLang.id;

      // 2. Inform name afterwards
      final userAfterName = await repository.saveName('Karlo');
      expect(userAfterName.id, initialId); // Must keep same user UUID
      expect(userAfterName.selectedLanguage, AppLanguage.esperanto);
      expect(userAfterName.name, 'Karlo');

      // 3. Update language to English
      final userAfterLangUpdate = await repository.saveLanguage(AppLanguage.english);
      expect(userAfterLangUpdate.id, initialId);
      expect(userAfterLangUpdate.selectedLanguage, AppLanguage.english);
      expect(userAfterLangUpdate.selectedLanguage.id, 3);
      expect(userAfterLangUpdate.name, 'Karlo');
    });

    test('fromDeviceLocale auto-detects Portuguese for pt language and Lusophone regions', () {
      // 1. Explicit Portuguese language code
      expect(AppLanguage.fromDeviceLocale(const Locale('pt')), AppLanguage.portuguese);
      expect(AppLanguage.fromDeviceLocale(const Locale('pt', 'BR')), AppLanguage.portuguese);
      expect(AppLanguage.fromDeviceLocale(const Locale('pt', 'PT')), AppLanguage.portuguese);
      expect(AppLanguage.fromDeviceLocale(const Locale('pt', 'AO')), AppLanguage.portuguese);

      // 2. Esperanto language code
      expect(AppLanguage.fromDeviceLocale(const Locale('eo')), AppLanguage.esperanto);

      // 3. Lusophone territories with non-Portuguese device system language (e.g. English UI in Brazil)
      expect(AppLanguage.fromDeviceLocale(const Locale('en', 'BR')), AppLanguage.portuguese);
      expect(AppLanguage.fromDeviceLocale(const Locale('en', 'PT')), AppLanguage.portuguese);
      expect(AppLanguage.fromDeviceLocale(const Locale('en', 'AO')), AppLanguage.portuguese);
      expect(AppLanguage.fromDeviceLocale(const Locale('en', 'MZ')), AppLanguage.portuguese);
      expect(AppLanguage.fromDeviceLocale(const Locale('en', 'CV')), AppLanguage.portuguese);
      expect(AppLanguage.fromDeviceLocale(const Locale('en', 'GW')), AppLanguage.portuguese);
      expect(AppLanguage.fromDeviceLocale(const Locale('en', 'ST')), AppLanguage.portuguese);
      expect(AppLanguage.fromDeviceLocale(const Locale('en', 'TL')), AppLanguage.portuguese);
      expect(AppLanguage.fromDeviceLocale(const Locale('en', 'MO')), AppLanguage.portuguese);

      // 4. Default fallback to English for other languages and regions
      expect(AppLanguage.fromDeviceLocale(const Locale('en', 'US')), AppLanguage.english);
      expect(AppLanguage.fromDeviceLocale(const Locale('en', 'GB')), AppLanguage.english);
      expect(AppLanguage.fromDeviceLocale(const Locale('fr', 'FR')), AppLanguage.english);
      expect(AppLanguage.fromDeviceLocale(const Locale('de', 'DE')), AppLanguage.english);
      expect(AppLanguage.fromDeviceLocale(const Locale('es', 'ES')), AppLanguage.english);
    });
  });
}
