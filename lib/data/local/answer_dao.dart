import 'package:intl/intl.dart';

import 'package:sqflite/sqflite.dart';

import '../model/journals.dart';
import 'app_database_provider.dart';
import 'dao.dart';

class AnswerDao implements Dao<Answer> {
  // database provider
  final AppDatabaseProvider _appDatabaseProvider;
  // constructor for DAO
  AnswerDao(this._appDatabaseProvider);

  // Option table name
  static const _tableName = 'Answer';

  // fields

  static const _date = 'date';
  static const _value = 'value';
  static const _questionCode = 'questionCode';

  @override
  String get createTableQuery => "CREATE TABLE $_tableName($_questionCode TEXT,"
      " $_date TEXT,"
      " $_value TEXT,"
      "PRIMARY KEY ($_questionCode, $_date))";

  @override
  Answer fromMap(Map<String, dynamic> query) {
    Answer answer = Answer(
        questionCode: query[_questionCode],
        value: query[_value],
        date: query[_date]);

    return answer;
  }

  @override
  Map<String, dynamic> toMap(Answer answer) {
    return <String, dynamic>{
      _questionCode: answer.questionCode,
      _date: DateFormat("yyyy-MM-dd HH:mm:ss").format(answer.date!),
      _value: answer.value,
    };
  }

  @override
  List<Answer> fromList(List<Map<String, dynamic>> query) {
    List<Answer> answer = List<Answer>.empty();
    for (Map<String, dynamic> map in query) {
      answer.add(fromMap(map));
    }
    return answer;
  }

  insert(
    Answer? answer,
  ) async {
    if (answer != null) {
      await _appDatabaseProvider.db?.insert(_tableName, toMap(answer),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  update(
    Answer? answer,
    String date,
  ) async {
    if (answer != null) {
      await _appDatabaseProvider.db?.update(
        _tableName,
        toMap(answer),
        where: '$_date = ? AND $_questionCode = ?',
        whereArgs: [date, answer.questionCode],
        
      );
    }
  }

  Future<List<Answer>?> getAnswerByDate(String date) async {
    // Get a reference to the database.
    final db = _appDatabaseProvider.db;

    final List<Map<String, dynamic>?> maps = await db!
        .rawQuery("SELECT * FROM $_tableName WHERE $_date = ?", [date]);

    return List.generate(maps.length, (i) {
      return getAnswer(maps[i]);
    });
  }

  Answer getAnswer(Map? map) {
    return Answer(
      date: DateTime.parse(map?["date"]),
      questionCode: map?["questionCode"],
      value: map?["value"],
    );
  }

  Future<void> deleteAll(
    AppDatabaseProvider _appDatabaseProvider,
  ) async {
    final db = _appDatabaseProvider.db;
    return await db!.execute('DELETE FROM $_tableName');
  }
}
