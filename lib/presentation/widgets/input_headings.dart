import 'package:flutter/material.dart';
import 'package:reaching_our_goals/resources/values_manager.dart';

import '../../../resources/color_manager.dart';

class SubHeadingQuestion extends StatefulWidget {
  const SubHeadingQuestion({
    Key? key,
    required this.heading,
  }) : super(key: key);

  final String heading;

  @override
  State<SubHeadingQuestion> createState() => _SubHeadingQuestionState();
}

class _SubHeadingQuestionState extends State<SubHeadingQuestion> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(24.0, 0.0, 24.0, 0.0),
      child: Text(
        widget.heading,
        style: TextStyle(
          color: ColorManager.fontColorBlack,
          fontSize: (MediaQuery.of(context).size.width < 1100 &&
                  MediaQuery.of(context).size.width >= 650)
              ? AppSize.s22
              : AppSize.s16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
