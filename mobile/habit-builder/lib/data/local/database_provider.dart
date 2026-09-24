import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app_database.dart';

/// Riverpod provider delivering the singleton AppDatabase instance.
final appDatabaseProvider = Provider<AppDatabase>((ref) {
  final database = AppDatabase();
  ref.onDispose(() => database.close());
  return database;
});
