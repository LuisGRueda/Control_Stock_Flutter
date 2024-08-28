import 'package:control_stock/ui/colors_view.dart';
import 'package:flutter/material.dart';

class ButtomsViewExitNote extends StatelessWidget {
  const ButtomsViewExitNote({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    AppColor StyleApp = AppColor();
    return Container(
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: StyleApp.ColorBackgroud(context),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Column(
          children: const [
            //MyModalBottomExitNote(),
            SizedBox(
              height: 10,
            ),
            //MyModalBottomExitNote(),
          ],
        ),
      ),
    );
  }
}
