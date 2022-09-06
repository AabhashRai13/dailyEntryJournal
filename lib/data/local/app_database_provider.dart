import 'package:path/path.dart';
import 'package:reaching_our_goals/data/local/answer_dao.dart';
import 'package:reaching_our_goals/data/local/journals_dao.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabaseProvider {
  Database? db;
  String? path;
  AppDatabaseProvider() {
    _init();
  }

  Future _init() async {
    var databasesPath = await getDatabasesPath();
    path = join(databasesPath, "reaching_our_goals.db");
    db = await openDatabase(path!, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(JournalsDao(this).createTableQuery);
      await db.execute(AnswerDao(this).createTableQuery);
    });
  }
}
