import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

import 'tables/assessments_table.dart';
import 'tables/financial_categories_table.dart';
import 'tables/financial_transactions_table.dart';
import 'tables/gratitude_entries_table.dart';
import 'tables/life_areas_evaluations_table.dart';
import 'tables/monthly_currencies_table.dart';
import 'tables/physical_activities_table.dart';
import 'tables/training_tables.dart';
import 'tables/user_habits_table.dart';
import 'tables/users_table.dart';
import '../../domain/models/life_area.dart';

part 'app_database.g.dart';

/// The central Drift SQLite database for Bona Loko Habit Builder.
@DriftDatabase(tables: [
  Assessments,
  AssessmentAreaScores,
  Users,
  LifeAreasEvaluations,
  GratitudeEntries,
  DailyGratitudeCompletions,
  PhysicalActivities,
  DailyActivitiesCompletions,
  WorkoutGroups,
  WorkoutRoutines,
  TrainingExercises,
  DailyTrainingSessions,
  DailyTrainingRecords,
  FinancialTransactions,
  FinancialCategories,
  MonthlyCurrencies,
  UserHabits,
])
class AppDatabase extends _$AppDatabase {
  AppDatabase([QueryExecutor? e]) : super(e ?? _openConnection());

  @override
  int get schemaVersion => 1;

  final Set<String> _ensuredTableNames = {};

  /// Ensures that all required application tables exist in the underlying SQLite database,
  /// healing schema desyncs and ensuring the single unified schema is in place.
  Future<void> ensureTablesExist() async {
    final m = createMigrator();

    // Clean up obsolete tables from previous iterations
    await customStatement('DROP TABLE IF EXISTS "training_plans";');
    await customStatement('DROP TABLE IF EXISTS "training_sets";');

    Future<void> checkAndCreate(String tableName, TableInfo table) async {
      if (_ensuredTableNames.contains(tableName)) return;
      try {
        final rows = await customSelect(
          "SELECT count(*) as cnt FROM sqlite_master WHERE type='table' AND name=?",
          variables: [Variable.withString(tableName)],
        ).get();
        if (rows.isEmpty || rows.first.read<int>('cnt') == 0) {
          await m.createTable(table);
        }
        _ensuredTableNames.add(tableName);
      } catch (_) {
        // Table might already exist or concurrent access
      }
    }

    await checkAndCreate(assessments.actualTableName, assessments);
    await checkAndCreate(assessmentAreaScores.actualTableName, assessmentAreaScores);
    await checkAndCreate(users.actualTableName, users);
    await checkAndCreate(lifeAreasEvaluations.actualTableName, lifeAreasEvaluations);
    await checkAndCreate(gratitudeEntries.actualTableName, gratitudeEntries);
    await checkAndCreate(dailyGratitudeCompletions.actualTableName, dailyGratitudeCompletions);
    await checkAndCreate(physicalActivities.actualTableName, physicalActivities);
    await checkAndCreate(dailyActivitiesCompletions.actualTableName, dailyActivitiesCompletions);
    await checkAndCreate(workoutGroups.actualTableName, workoutGroups);
    await checkAndCreate(workoutRoutines.actualTableName, workoutRoutines);
    await checkAndCreate(trainingExercises.actualTableName, trainingExercises);
    await checkAndCreate(dailyTrainingSessions.actualTableName, dailyTrainingSessions);
    await checkAndCreate(dailyTrainingRecords.actualTableName, dailyTrainingRecords);
    await checkAndCreate(financialTransactions.actualTableName, financialTransactions);
    await checkAndCreate(financialCategories.actualTableName, financialCategories);
    await checkAndCreate(monthlyCurrencies.actualTableName, monthlyCurrencies);
    await checkAndCreate(userHabits.actualTableName, userHabits);
  }

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON;');
        await ensureTablesExist();
      },
      onCreate: (m) async {
        await m.createAll();
      },
    );
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'bona_loko_habits.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
