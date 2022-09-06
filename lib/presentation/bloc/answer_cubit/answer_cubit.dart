import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:reaching_our_goals/data/local/journals_dao.dart';
import 'package:reaching_our_goals/data/model/journals.dart';
import '../../../app/di.dart';
import 'package:bloc/bloc.dart';
part 'answer_state.dart';

class AnswerCubit extends Cubit<AnswerState> {
  AnswerCubit() : super(const AnswerState(answerList: []));
  final JournalsDao _journalsDao = instance<JournalsDao>();
  List<Answer> list = [];
  Random random = Random();
  saveAnswerToList(Answer answer) {
    list.add(answer);
    list.toSet().toList();
  }

  clearAnswers() {
    list.clear();
    emit(const AnswerState(answerList: []));
  }

  saveAnswerToLocalDb(DateTime? dateTime) async {
    await _journalsDao.insert(Journal(dateTime: dateTime, answers: list));
    list.clear();
    emit(AnswerState(
        answerList: [Answer(questionCode: "${random.nextInt(100)}")]));
    return false;
  }

  updateAnswerToLocalDb(DateTime? dateTime, String? oldDate) async {
    await _journalsDao.update(
        Journal(dateTime: dateTime, answers: list), oldDate!);
    list.clear();
    emit(AnswerState(
        answerList: [Answer(questionCode: "${random.nextInt(100)}")]));
    return false;
  }
}
