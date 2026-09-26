import 'dart:ui' as ui;
import 'package:drift/drift.dart';
import 'package:flutter/widgets.dart' show WidgetsBinding, Locale;

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

  /// Canonical ISO 3166-1 alpha-2 territory codes where Portuguese is official or co-official (CPLP / Lusophone).
  static const Set<String> lusophoneCountryCodes = {
    'BR', // Brazil
    'PT', // Portugal
    'AO', // Angola
    'MZ', // Mozambique
    'CV', // Cape Verde
    'GW', // Guinea-Bissau
    'ST', // São Tomé and Príncipe
    'TL', // Timor-Leste
    'MO', // Macau
  };

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

  /// Automatically resolves the default [AppLanguage] based on the user's device system language or region.
  ///
  /// Resolution precedence:
  /// 1. Language code matches 'pt' -> [AppLanguage.portuguese]
  /// 2. Language code matches 'eo' -> [AppLanguage.esperanto]
  /// 3. Region / Country code is in [lusophoneCountryCodes] -> [AppLanguage.portuguese]
  /// 4. Fallback -> [AppLanguage.english]
  static AppLanguage fromDeviceLocale([Locale? locale]) {
    try {
      Locale? target = locale;
      if (target == null) {
        try {
          target = WidgetsBinding.instance.platformDispatcher.locale;
        } catch (_) {
          target = ui.PlatformDispatcher.instance.locale;
        }
      }
      final lang = target.languageCode.toLowerCase();
      final country = target.countryCode?.toUpperCase();

      if (lang == 'pt') {
        return AppLanguage.portuguese;
      }
      if (lang == 'eo') {
        return AppLanguage.esperanto;
      }

      if (country != null && lusophoneCountryCodes.contains(country)) {
        return AppLanguage.portuguese;
      }

      return AppLanguage.english;
    } catch (_) {
      return AppLanguage.english;
    }
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
