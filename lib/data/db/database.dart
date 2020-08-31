import 'package:golden_app/data/constants.dart';
import 'package:golden_app/data/db/config/base.dart';

class Floor {
  static final Floor _instance = Floor._internal();

  static Floor get instance => _instance;

  AppDatabase _database;

  Future<AppDatabase> get database async {
    if (_database != null) return _database;
    return await $FloorAppDatabase.databaseBuilder(Constants.DB_NAME).build();
  }

  Floor._internal();
}
