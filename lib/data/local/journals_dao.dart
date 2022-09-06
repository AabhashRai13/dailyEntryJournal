import 'dart:developer';

import 'package:reaching_our_goals/app/di.dart';
import 'package:reaching_our_goals/data/local/answer_dao.dart';
import 'package:reaching_our_goals/data/local/dao.dart';
import 'package:reaching_our_goals/data/model/journals.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';

import 'app_database_provider.dart';

class JournalsDao implements Dao<Journal> {
  final AppDatabaseProvider _appDatabaseProvider;
  JournalsDao(this._appDatabaseProvider);
  final AnswerDao _answerDao = instance<AnswerDao>();
  // database provider

  // constructor for DAO

  // Journal table name
  static const _tableName = 'Journal';

  // fields

  static const _date = 'date';
  static const _id = 'id';

  @override
  String get createTableQuery => "CREATE TABLE $_tableName($_date TEXT,"
      " $_id INTEGER PRIMARY KEY AUTOINCREMENT)";

  @override
  Journal fromMap(Map<String, dynamic> query) {
    Journal journal = Journal(
      dateTime: query[_date],
    );
    return journal;
  }

  @override
  Map<String, dynamic> toMap(Journal object) {
    return <String, dynamic>{
      _date: DateFormat("yyyy-MM-dd HH:mm:ss").format(object.dateTime!),
    };
  }

  @override
  List<Journal> fromList(List<Map<String, dynamic>> query) {
    List<Journal> journal = List<Journal>.empty();
    for (Map<String, dynamic> map in query) {
      journal.add(fromMap(map));
    }
    return journal;
  }

  getAnswers(String date) async {
    List<Answer>? answer = await _answerDao.getAnswerByDate(date);
    log("fillter $answer");
    return answer;
  }

  insertAnswer(
    Answer answer,
  ) {
    _answerDao.insert(answer).then((_) {
      // getAnswers("REG-);
    });
  }

  updateAnswer(
    Answer answer,
    String date,
  ) {
    _answerDao.update(answer, date);
  }

  insert(Journal? journal) async {
    if (journal != null) {
      await _appDatabaseProvider.db?.insert(_tableName, toMap(journal),
          conflictAlgorithm: ConflictAlgorithm.replace);

      if (journal.answers != null) {
        for (int i = 0; i < journal.answers!.length; i++) {
          insertAnswer(
            Answer(
                date: journal.dateTime,
                value: journal.answers![i].value,
                questionCode: journal.answers![i].questionCode),
          );
        }
      }
    }
  }

  update(Journal? journal, String date) async {
    if (journal != null) {
      await _appDatabaseProvider.db?.update(
        _tableName,
        toMap(journal),
        where: '$_date = ?',
        whereArgs: [date],
      );

      if (journal.answers != null) {
        for (int i = 0; i < journal.answers!.length; i++) {
          updateAnswer(
              Answer(
                  date: journal.dateTime,
                  value: journal.answers![i].value,
                  questionCode: journal.answers![i].questionCode),
              date);
        }
      }
    }
  }

  Future<List<Journal>?> getJournals() async {
    // Get a reference to the database.
    final db = _appDatabaseProvider.db;
    List<Journal>? journals = <Journal>[];
    final List<Map<String, dynamic>?> maps = await db!.query(_tableName);

    journals = await populateList(maps);
    return journals;
  }

  Journal? journal;
  populateList(
    List<Map<String, dynamic>?> maps,
  ) async {
    List<Journal>? journals = [];

    for (int i = 0; i < maps.length; i++) {
      await getJournal(
        maps[i],
      );
      journals.add(journal!);
    }
    return journals;
  }

  getJournal(
    Map? map,
  ) async {
    journal = Journal(
        dateTime: DateTime.parse((map?['date'])),
        answers: await _answerDao.getAnswerByDate(
          (map?["date"]),
        ));
  }

  Future<void> deleteAll() async {
    final db = _appDatabaseProvider.db;
    return await db!.execute('DELETE FROM $_tableName');
  }

  Future<int> deleteJournal(String date) async {
    final db = _appDatabaseProvider.db;
    return await db!.delete(
      _tableName,
      where: '$_date = ?',
      whereArgs: [date],
    );
  }
}
