import 'package:flutter/material.dart';
import 'package:reaching_our_goals/data/model/journals.dart';
import 'package:reaching_our_goals/presentation/bloc/answer_cubit/answer_cubit.dart';
import 'package:reaching_our_goals/resources/color_manager.dart';
import 'package:reaching_our_goals/resources/font_manager.dart';
import 'package:reaching_our_goals/resources/values_manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TextFieldQuestionWidget extends StatefulWidget {
  const TextFieldQuestionWidget(
      {Key? key,
      required this.question,
      required this.date,
      this.hintText,
      this.answer,
      this.border,
      this.isDescription = false})
      : super(key: key);
  final DateTime date;
  final String question;
  final String? hintText;
  final String? answer;
  final bool? isDescription;
  final bool? border;

  @override
  State<TextFieldQuestionWidget> createState() =>
      _TextFieldQuestionWidgetState();
}

class _TextFieldQuestionWidgetState extends State<TextFieldQuestionWidget> {
  late TextEditingController _textEditingController;

  initialValidateCheck() {}
  @override
  void initState() {
    super.initState();

    _textEditingController = TextEditingController(text: widget.answer ?? "");
    // if (widget.answer != null) {
    //   saveAnswer(widget.answer!, widget.question);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (MediaQuery.of(context).size.width < 1100 &&
              MediaQuery.of(context).size.width >= 650)
          ? MediaQuery.of(context).size.height * 0.1
          : MediaQuery.of(context).size.height * 0.06,
      margin: (MediaQuery.of(context).size.width < 1100 &&
              MediaQuery.of(context).size.width >= 650)
          ? const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0)
          : const EdgeInsets.symmetric(horizontal: 20.0, vertical: 2.0),
      child: TextFormField(
        textCapitalization: TextCapitalization.sentences,
        validator: (value) {
          return null;
        },
        style: TextStyle(
          color: ColorManager.selectedFontColor,
          fontSize: (MediaQuery.of(context).size.width < 1100 &&
                  MediaQuery.of(context).size.width >= 650)
              ? FontSize.s24
              : FontSize.s14,
        ),
        controller: _textEditingController,
        decoration: InputDecoration(
          // hintText: lstate.locale.languageCode == AppConstants.englishLanguage
          //     ? widget.question.name!.en!
          //     : widget.question.name!.km!,
          fillColor: ColorManager.filledInputColorsForForm.withOpacity(0.1),
          hintStyle: TextStyle(
            color: ColorManager.fontColorLightHint,
            fontSize: (MediaQuery.of(context).size.width < 1100 &&
                    MediaQuery.of(context).size.width >= 650)
                ? FontSize.s24
                : FontSize.s14,
          ),
          filled: widget.border ?? true ? true : false,

          counterText: "",

          border: widget.border ?? true
              ? const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(AppSize.s8),
                  ),
                )
              : InputBorder.none,
          enabledBorder: widget.border ?? true
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorManager.lightGrey.withOpacity(0.2), width: 0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSize.s8),
                  ),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorManager.lightGrey.withOpacity(0.8), width: 0),
                ),
          focusedBorder: widget.border ?? true
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: ColorManager.lightGrey.withOpacity(0.2), width: 0),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(AppSize.s8),
                  ),
                )
              : UnderlineInputBorder(
                  borderSide: BorderSide(color: ColorManager.gold),
                ),
          // errorText: state.validate! ? state.errorText : null,
        ),
        onChanged: (value) {
          saveAnswer(value, widget.question);
        },
        maxLines: (MediaQuery.of(context).size.width < 1100 &&
                MediaQuery.of(context).size.width >= 650)
            ? 5
            : 1,
      ),
    );
  }

  void saveAnswer(String value, String questionCode) {
    BlocProvider.of<AnswerCubit>(context).list.isNotEmpty
        ? BlocProvider.of<AnswerCubit>(context)
            .list
            .removeWhere(((item) => item.questionCode == questionCode))
        : null;
    BlocProvider.of<AnswerCubit>(context).saveAnswerToList(
      Answer(
        value: value,
        questionCode: questionCode,
        date: widget.date,
      ),
    );
  }
}
