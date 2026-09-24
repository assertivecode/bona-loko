import 'package:drift/drift.dart';

/// Supported application languages mapped to their exact database enum integer IDs:
/// Esperanto = 1, Portuguese = 2, English = 3.
enum AppLanguage {
  esperanto(1, 'eo', 'Esperanto'),
  portuguese(2, 'pt', 'Português'),
  english(3, 'en', 'English');

  final int id;
  final String code;
  final String displayName;

  const AppLanguage(this.id, this.code, this.displayName);

  static AppLanguage fromId(int id) {
    return AppLanguage.values.firstWhere(
      (e) => e.id == id,
      orElse: () => AppLanguage.english,
    );
  }

  static AppLanguage fromCode(String code) {
    return AppLanguage.values.firstWhere(
      (e) => e.code == code,
      orElse: () => AppLanguage.english,
    );
  }
}

/// TypeConverter to persist [AppLanguage] as an integer in SQLite:
/// 1 = Esperanto, 2 = Portuguese, 3 = English.
class AppLanguageConverter extends TypeConverter<AppLanguage, int> {
  const AppLanguageConverter();

  @override
  AppLanguage fromSql(int fromDb) => AppLanguage.fromId(fromDb);

  @override
  int toSql(AppLanguage value) => value.id;
}

/// SQLite table definition for the local user profile and preferences.
@DataClassName('UserData')
class Users extends Table {
  @override
  String get tableName => 'users';

  TextColumn get id => text()();
  DateTimeColumn get createdAt => dateTime()();
  IntColumn get selectedLanguage => integer().map(const AppLanguageConverter())();
  TextColumn get name => text().withDefault(const Constant(''))();
  BoolColumn get onboardingCompleted => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}
