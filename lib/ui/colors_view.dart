import 'package:flutter/material.dart';

class AppColor {
  static Color bgColor = Color(0xfff8f7f3);
  static Color bgSideMenu = Color(0xff131e29);
  static Color white = Colors.white;
  static Color black = Colors.black;
  Color ColorContText() {
    return Colors.lightBlue;
  }

  Color ColorBackgroud(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Color.fromARGB(210, 80, 84, 88);
    } else {
      return Color.fromRGBO(232, 233, 239, 1);
    }
  }

  Color ColorContainer(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Color.fromARGB(211, 43, 48, 53);
    } else {
      return Color.fromARGB(211, 255, 255, 255);
    }
  }

  Color ColorText(BuildContext context) {
    if (Theme.of(context).brightness == Brightness.dark) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }

  TextStyle StyleTextTittle(BuildContext context) {
    return TextStyle(
      fontSize: 30,
      color: ColorText(context),
      fontWeight: FontWeight.bold,
    );
  }

  TextStyle StyleText(BuildContext context) {
    return TextStyle(
      fontSize: 18,
      color: ColorText(context),
      fontWeight: FontWeight.bold,
    );
  }

  InputDecoration StyleInputText(BuildContext context, String Name) {
    return InputDecoration(
      labelText: Name,
      labelStyle: const TextStyle(
        fontSize: 12,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(5.0),
        borderSide: const BorderSide(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  SizedBox Separate12() {
    return const SizedBox(
      height: 12,
    );
  }

  // ignore: non_constant_identifier_names
  SizedBox Separate16() {
    return const SizedBox(
      height: 16,
    );
  }
}
