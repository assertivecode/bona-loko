import 'dart:ffi';
import 'dart:io';
import 'package:sqlite3/open.dart';

/// Configures native dependencies for local desktop test runs.
void setupTestDatabase() {
  if (Platform.isWindows) {
    final pubCache = Platform.environment['PUB_CACHE'] ??
        '${Platform.environment['USERPROFILE']}\\AppData\\Local\\Pub\\Cache';
    final candidatePaths = [
      '$pubCache\\hosted\\pub.dev\\sqflite_common_ffi-2.3.4+4\\lib\\src\\windows\\sqlite3.dll',
    ];

    for (final path in candidatePaths) {
      if (File(path).existsSync()) {
        open.overrideFor(
          OperatingSystem.windows,
          () => DynamicLibrary.open(path),
        );
        break;
      }
    }
  }
}
