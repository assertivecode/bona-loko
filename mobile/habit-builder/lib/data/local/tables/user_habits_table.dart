import 'package:drift/drift.dart';

/// SQLite table for persisting habits selected by the user for their daily routine.
@DataClassName('UserHabitData')
class UserHabits extends Table {
  @override
  String get tableName => 'user_habits';

  TextColumn get id => text()(); // Canonical habit id, e.g. 'habit_nurture_of_gratitude'
  DateTimeColumn get selectedAt => dateTime()();
  BoolColumn get isActive => boolean().withDefault(const Constant(true))();

  @override
  Set<Column> get primaryKey => {id};
}
