import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:reaching_our_goals/data/local/journals_dao.dart';
import 'package:reaching_our_goals/data/model/journals.dart';

import '../../../app/di.dart';
import 'package:bloc/bloc.dart';
part 'journal_state.dart';

class JournalCubit extends Cubit<JournalState> {
  JournalCubit() : super(const JournalState(journal: []));
  final JournalsDao _journalsDao = instance<JournalsDao>();
  List<Journal>? list = [];
  getJournals() async {
    list = await _journalsDao.getJournals();

    emit(JournalState(journal: list!));
  }

  deleteJournal(String date) async {
    int delete = await _journalsDao.deleteJournal(date);
    log("$delete");
  }
}
