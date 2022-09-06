part of 'answer_cubit.dart';

class AnswerState extends Equatable {
  final List<Answer> answerList;
  const AnswerState({
    required this.answerList,
  });

  @override
  List<Object> get props => [answerList];
}
