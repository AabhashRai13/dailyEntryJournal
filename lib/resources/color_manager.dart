import 'package:flutter/material.dart';

class ColorManager {
  static Color primary = HexColor.fromHex("#000000");
  static Color gold = HexColor.fromHex("#FFCC00");

  static Color darkGrey = HexColor.fromHex("#525252");
  static Color grey = HexColor.fromHex("#737477");
  static Color lightGrey = HexColor.fromHex("#9E9E9E");
  static Color transparent = HexColor.fromHex("00FFFFFF");
  static Color darkBlue = HexColor.fromHex("#6F8FAF");
  static Color teal = HexColor.fromHex("#0EA7FB");
  static Color cyan = HexColor.fromHex("#00FFFF");
  static Color buttonColor = HexColor.fromHex("#3360F9");
  static Color lightBlueColor = HexColor.fromHex("#00B9FD");
  static Color fontColor = HexColor.fromHex("#728491");
  static Color telegramColor = HexColor.fromHex("#2CB7EE");
  static Color selectedFontColor = HexColor.fromHex("#303340");
  static Color red = HexColor.fromHex("#FF0000");
  static Color lightRed = HexColor.fromHex("#FFCCCB");
  static Color green = HexColor.fromHex("#98fb98");

// new colors
  static Color darkPrimary = HexColor.fromHex("#d17d11");
  static Color grey1 = HexColor.fromHex("#707070");
  static Color grey2 = HexColor.fromHex("#797979");
  static Color white = HexColor.fromHex("#FFFFFF");
  static Color greenIconColor = HexColor.fromHex("#47B14B");
  static Color bgWhite = HexColor.fromHex("#FCFCFC");
  static Color fontColorBlack = HexColor.fromHex("#1F2933");
  static Color error = HexColor.fromHex("#e61f34"); // red color
  static Color filledInputColorsForForm =
      HexColor.fromHex("#B0B8BF"); // red color

  static const Color colorTextFieldBorder = Color(0x1F000000);
  static const Color colorInputText = Color(0xBD000000);
  static const Color colorTextDescription = Color(0x82000000);
  static Color iconGrey = HexColor.fromHex("#9FA8B1");
  static Color fontColorLightHint = HexColor.fromHex("#7C84A0");
}

extension HexColor on Color {
  static Color fromHex(String hexColorString) {
    hexColorString = hexColorString.replaceAll("#", "");
    if (hexColorString.length == 6) {
      hexColorString = "FF" + hexColorString; // 8 char with opactiy 100%
    }
    return Color(int.parse(hexColorString, radix: 16));
  }
}
