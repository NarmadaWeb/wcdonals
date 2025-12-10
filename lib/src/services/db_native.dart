// db_native.dart
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io';

void initializeDatabaseFactory() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
     sqfliteFfiInit();
     databaseFactory = databaseFactoryFfi;
  }
}
