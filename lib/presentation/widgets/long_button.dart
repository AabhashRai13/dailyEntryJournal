import 'package:flutter/material.dart';
import 'package:reaching_our_goals/resources/color_manager.dart';
import 'package:reaching_our_goals/resources/values_manager.dart';

class LongButton extends StatefulWidget {
  final String buttonText;
  final Color buttonColor;
  final Function function;
  final bool loading;
  const LongButton(
      {Key? key,
      required this.buttonText,
      required this.buttonColor,
      required this.function,
      required this.loading})
      : super(key: key);

  @override
  _LongButtonState createState() => _LongButtonState();
}

class _LongButtonState extends State<LongButton> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 12, right: 12, bottom: 2.0, top: 10),
      height: MediaQuery.of(context).size.height * 0.04,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(primary: widget.buttonColor),
        onPressed: () {
          widget.function();
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              width: AppSize.s8,
            ),
            widget.loading
                ? CircularProgressIndicator(
                    color: ColorManager.gold,
                  )
                : Text(widget.buttonText,
                    style: Theme.of(context).textTheme.headline2),
          ],
        ),
      ),
    );
  }
}
