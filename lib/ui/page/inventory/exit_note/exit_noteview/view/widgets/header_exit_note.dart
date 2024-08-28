import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/responsive/responsive_view.dart';
import 'package:flutter/material.dart';

class HeaderExitNote extends StatefulWidget {
  const HeaderExitNote({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeaderExitNoteState createState() => _HeaderExitNoteState();
}

class _HeaderExitNoteState extends State<HeaderExitNote> {
  AppColor StyleApp = AppColor();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            "Notas de Salida",
            style: StyleApp.StyleTextTittle(context),
          ),
          if (!ResponsiveView.isMobile(context)) ...{
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [],
            )
          }
        ],
      ),
    );
  }
}
