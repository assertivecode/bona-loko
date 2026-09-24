/// Core application constants for Bona Loko Habit Builder.
class AppConstants {
  AppConstants._();

  static const String appName = 'Bona Loko';
  static const String databaseName = 'bona_loko_habits.db';
  static const int databaseVersion = 1;

  // Domain constraints
  static const int minScore = 1;
  static const int maxScore = 10;
  static const int defaultScore = 5;
  static const int totalLifeAreas = 12;
}
