import 'package:flutter/material.dart';
import 'package:reaching_our_goals/data/model/journals.dart';
import 'package:reaching_our_goals/presentation/widgets/text_input_widgets.dart';
import 'package:reaching_our_goals/resources/color_manager.dart';
import 'package:reaching_our_goals/resources/styles_manager.dart';
import 'package:reaching_our_goals/resources/values_manager.dart';

class TextInputList extends StatefulWidget {
  final String question;
  final DateTime dateTime;
  final Journal? journal;
  const TextInputList(
      {Key? key, required this.question, required this.dateTime, this.journal})
      : super(key: key);

  @override
  State<TextInputList> createState() => _TextInputListState();
}

class _TextInputListState extends State<TextInputList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 3,
      itemBuilder: (BuildContext context, int index) {
        return SizedBox(
          height: (MediaQuery.of(context).size.width < 1100 &&
                  MediaQuery.of(context).size.width >= 650)
              ? MediaQuery.of(context).size.height * 0.07
              : MediaQuery.of(context).size.height * 0.042,
          child: ListTile(
            minLeadingWidth: 0,
            leading: Text(
              "${index + 1}",
              style: getSemiBoldStyle(
                  color: ColorManager.primary,
                  fontSize: (MediaQuery.of(context).size.width < 1100 &&
                          MediaQuery.of(context).size.width >= 650)
                      ? AppSize.s22
                      : AppSize.s12),
            ),
            title: TextFieldQuestionWidget(
              question: "${widget.question}${index + 1}",
              date: widget.dateTime,
              border: false,
              answer: getAnswer("${widget.question}${index + 1}"),
            ),
          ),
        );
      },
    );
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
}
