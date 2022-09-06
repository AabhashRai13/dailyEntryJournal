import 'package:flutter/material.dart';
import 'package:reaching_our_goals/app/constants/app_constants.dart';
import 'package:reaching_our_goals/data/model/journals.dart';
import 'package:reaching_our_goals/presentation/bloc/answer_cubit/answer_cubit.dart';
import 'package:reaching_our_goals/presentation/bloc/journal_cubit/journal_cubit.dart';
import 'package:reaching_our_goals/presentation/widgets/input_headings.dart';
import 'package:reaching_our_goals/presentation/widgets/long_button.dart';
import 'package:reaching_our_goals/presentation/widgets/responsive.dart';
import 'package:reaching_our_goals/presentation/widgets/text_input_list.dart';
import 'package:reaching_our_goals/presentation/widgets/text_input_widgets.dart';
import 'package:reaching_our_goals/resources/color_manager.dart';
import 'package:reaching_our_goals/resources/values_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class DataEntryView extends StatefulWidget {
  final Journal? journal;
  final bool? isNew;
  const DataEntryView({Key? key, this.journal, this.isNew}) : super(key: key);

  @override
  State<DataEntryView> createState() => _DataEntryViewState();
}

class _DataEntryViewState extends State<DataEntryView> {
  bool loading = false;
  DateTime? _dateTime;
  bool isNew = true;
  @override
  void initState() {
    super.initState();
    _dateTime = DateTime.now();
    preFillAnswers();
    setIsNew();
  }

  setIsNew() {
    isNew = widget.isNew!;
  }

  preFillAnswers() {
    if (widget.journal == null) {
      BlocProvider.of<AnswerCubit>(context).list = autofilledList();
    } else {
      BlocProvider.of<AnswerCubit>(context).list = widget.journal!.answers!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daily Entry"),
      ),
      body: BlocListener<AnswerCubit, AnswerState>(
        bloc: BlocProvider.of<AnswerCubit>(context),
        listener: (context, state) {
          if (state.answerList[0].questionCode != "Na") {
            BlocProvider.of<JournalCubit>(context).getJournals();
            Navigator.of(context).pop();
          }
        },
        child: Responsive(
          mobile: Scrollbar(child: widgetMobile(context)),
          tablet: widgetTablet(context),
        ),
      ),
    );
  }

  ListView widgetMobile(BuildContext context) {
    return ListView(children: [
      const SizedBox(
        height: AppSize.s2,
      ),
      const SubHeadingQuestion(
        heading: "Today's #1 Goal",
      ),
      TextFieldQuestionWidget(
        question: AppConstants.todaysGoal,
        date: _dateTime!,
        answer: getAnswer(AppConstants.todaysGoal),
      ),
      const SubHeadingQuestion(
        heading: "S.M.A.R.T Goals",
      ),
      TextFieldQuestionWidget(
        question: AppConstants.smartGoals,
        date: _dateTime!,
        answer: getAnswer(AppConstants.smartGoals),
      ),
      const SubHeadingQuestion(
        heading: "Continue Doing",
      ),
      TextFieldQuestionWidget(
        question: AppConstants.continueDoing,
        date: _dateTime!,
        answer: getAnswer(AppConstants.continueDoing),
      ),
      const SubHeadingQuestion(
        heading: "Start Doing",
      ),
      TextFieldQuestionWidget(
        question: AppConstants.startDoing,
        date: _dateTime!,
        answer: getAnswer(AppConstants.startDoing),
      ),
      const SubHeadingQuestion(
        heading: "Stop Doing",
      ),
      TextFieldQuestionWidget(
        question: AppConstants.stopDoing,
        date: _dateTime!,
        answer: getAnswer(AppConstants.stopDoing),
      ),
      const Divider(),
      const SubHeadingQuestion(
        heading: "Things I Learned",
      ),
      TextInputList(
        question: AppConstants.thingsILearned,
        dateTime: _dateTime!,
        journal: widget.journal,
      ),
      const Divider(),
      const SubHeadingQuestion(
        heading: "Things I Accomplished",
      ),
      TextInputList(
        question: AppConstants.thingsIAccomplished,
        dateTime: _dateTime!,
        journal: widget.journal,
      ),
      const Divider(),
      const SubHeadingQuestion(
        heading: "Visualization",
      ),
      TextFieldQuestionWidget(
        question: AppConstants.visualization,
        date: _dateTime!,
        answer: getAnswer(AppConstants.visualization),
      ),
      const SubHeadingQuestion(
        heading: "Self-Talk",
      ),
      TextFieldQuestionWidget(
        question: AppConstants.selfTalk,
        date: _dateTime!,
        answer: getAnswer(AppConstants.selfTalk),
      ),
      const SubHeadingQuestion(
        heading: "Focus",
      ),
      TextFieldQuestionWidget(
        question: AppConstants.focus,
        date: _dateTime!,
        answer: getAnswer(AppConstants.focus),
      ),
      LongButton(
        buttonColor: ColorManager.primary,
        buttonText: "Save",
        loading: loading,
        function: () async {
          bool success;
          setState(() {
            loading = true;
          });

          if (isNew) {
            success = await BlocProvider.of<AnswerCubit>(context)
                .saveAnswerToLocalDb(_dateTime);
          } else {
            success = await BlocProvider.of<AnswerCubit>(context)
                .updateAnswerToLocalDb(
                    _dateTime,
                    DateFormat("yyyy-MM-dd HH:mm:ss")
                        .format(widget.journal!.dateTime!));
          }

          setState(() {
            loading = success;
          });
        },
      )
    ]);
  }

  ListView widgetTablet(BuildContext context) {
    return ListView(children: [
      const SizedBox(
        height: AppSize.s20,
      ),
      const SubHeadingQuestion(
        heading: "Today's #1 Goal",
      ),
      TextFieldQuestionWidget(
        question: AppConstants.todaysGoal,
        date: _dateTime!,
        answer: getAnswer(AppConstants.todaysGoal),
      ),
      const SubHeadingQuestion(
        heading: "S.M.A.R.T Goals",
      ),
      TextFieldQuestionWidget(
        question: AppConstants.smartGoals,
        date: _dateTime!,
        answer: getAnswer(AppConstants.smartGoals),
      ),
      Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const SubHeadingQuestion(
                  heading: "Continue Doing",
                ),
                TextFieldQuestionWidget(
                  question: AppConstants.continueDoing,
                  date: _dateTime!,
                  answer: getAnswer(AppConstants.continueDoing),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SubHeadingQuestion(
                  heading: "Start Doing",
                ),
                TextFieldQuestionWidget(
                  question: AppConstants.startDoing,
                  date: _dateTime!,
                  answer: getAnswer(AppConstants.startDoing),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SubHeadingQuestion(
                  heading: "Stop Doing",
                ),
                TextFieldQuestionWidget(
                  question: AppConstants.stopDoing,
                  date: _dateTime!,
                  answer: getAnswer(AppConstants.stopDoing),
                ),
              ],
            ),
          ),
        ],
      ),
      const Divider(),
      const SubHeadingQuestion(
        heading: "Things I Learned",
      ),
      TextInputList(
        question: AppConstants.thingsILearned,
        dateTime: _dateTime!,
        journal: widget.journal,
      ),
      const Divider(),
      const SubHeadingQuestion(
        heading: "Things I Accomplished",
      ),
      TextInputList(
        question: AppConstants.thingsIAccomplished,
        dateTime: _dateTime!,
        journal: widget.journal,
      ),
      const Divider(),
      Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const SubHeadingQuestion(
                  heading: "Visualization",
                ),
                TextFieldQuestionWidget(
                  question: AppConstants.visualization,
                  date: _dateTime!,
                  answer: getAnswer(AppConstants.visualization),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SubHeadingQuestion(
                  heading: "Self-Talk",
                ),
                TextFieldQuestionWidget(
                  question: AppConstants.selfTalk,
                  date: _dateTime!,
                  answer: getAnswer(AppConstants.selfTalk),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const SubHeadingQuestion(
                  heading: "Focus",
                ),
                TextFieldQuestionWidget(
                  question: AppConstants.focus,
                  date: _dateTime!,
                  answer: getAnswer(AppConstants.focus),
                ),
              ],
            ),
          ),
        ],
      ),
      LongButton(
        buttonColor: ColorManager.primary,
        buttonText: "Save",
        loading: loading,
        function: () async {
          bool success;
          setState(() {
            loading = true;
          });

          if (isNew) {
            success = await BlocProvider.of<AnswerCubit>(context)
                .saveAnswerToLocalDb(_dateTime);
            setState(() {
              loading = success;
            });
          } else {
            success = await BlocProvider.of<AnswerCubit>(context)
                .updateAnswerToLocalDb(
                    _dateTime,
                    DateFormat("yyyy-MM-dd HH:mm:ss")
                        .format(widget.journal!.dateTime!));
            setState(() {
              loading = success;
            });
          }
        },
      )
    ]);
  }

  String getAnswer(String questionCode) {
    if (widget.journal != null) {
      final answer = widget.journal!.answers!
          .where((element) => element.questionCode == questionCode)
          .toList();

      return answer.isEmpty ? "" : answer[0].value!;
    } else {
      return "";
    }
  }

  bool isAnswersEmpty() {
    bool isAnswerEmpty = BlocProvider.of<AnswerCubit>(context)
        .list
        .every((element) => element.value == "");
    return isAnswerEmpty;
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            'No Entries!',
            style: TextStyle(color: Colors.red),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('Fill Atleast one data to save journal'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  List<Answer> autofilledList() {
    List<Answer> list = [];
    list = [
      Answer(
          date: _dateTime, questionCode: AppConstants.continueDoing, value: ""),
      Answer(date: _dateTime, questionCode: AppConstants.smartGoals, value: ""),
      Answer(date: _dateTime, questionCode: AppConstants.todaysGoal, value: ""),
      Answer(date: _dateTime, questionCode: AppConstants.startDoing, value: ""),
      Answer(date: _dateTime, questionCode: AppConstants.stopDoing, value: ""),
      Answer(
          date: _dateTime,
          questionCode: "${AppConstants.thingsILearned}1",
          value: ""),
      Answer(
          date: _dateTime,
          questionCode: "${AppConstants.thingsILearned}2",
          value: ""),
      Answer(
          date: _dateTime,
          questionCode: "${AppConstants.thingsILearned}3",
          value: ""),
      Answer(
          date: _dateTime,
          questionCode: "${AppConstants.thingsIAccomplished}1",
          value: ""),
      Answer(
          date: _dateTime,
          questionCode: "${AppConstants.thingsIAccomplished}1",
          value: ""),
      Answer(
          date: _dateTime,
          questionCode: "${AppConstants.thingsIAccomplished}1",
          value: ""),
      Answer(
          date: _dateTime, questionCode: AppConstants.visualization, value: ""),
      Answer(date: _dateTime, questionCode: AppConstants.selfTalk, value: ""),
      Answer(date: _dateTime, questionCode: AppConstants.focus, value: ""),
    ];
    return list;
  }
}
