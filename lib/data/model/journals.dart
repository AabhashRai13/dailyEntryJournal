import 'package:equatable/equatable.dart';

class Journal extends Equatable {
  const Journal({this.dateTime, this.answers});

  final DateTime? dateTime;

  final List<Answer>? answers;

  @override
  List<Object?> get props => [dateTime, answers];

  factory Journal.fromJson(Map<String, dynamic> json) => Journal(
      dateTime: json["dateTime"],
      answers: json["answers"] == null
          ? null
          : List<Answer>.from(
              json["filterAttributes"].map((x) => Answer.fromJson(x))));

  @override
  bool get stringify => true;
}

class Answer extends Equatable {
  const Answer({this.date, this.value, this.questionCode});

  final DateTime? date;
  final String? value;
  final String? questionCode;
  factory Answer.fromJson(Map<String, dynamic> json) => Answer(
        date: json["date"],
        value: json["value"],
        questionCode: json["questionCode"]
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "value": value,
        "questionCode": questionCode
      };

  @override
  List<Object?> get props => [
        date,
        value,
        questionCode
      ];
  @override
  bool get stringify => true;
}
