import 'package:control_stock/main.dart';
import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/responsive/responsive_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class HeaderWidget extends StatefulWidget {
  const HeaderWidget({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeaderWidgetState createState() => _HeaderWidgetState();
}

class _HeaderWidgetState extends State<HeaderWidget> {
  @override
  Widget build(BuildContext context) {
    // ignore: non_constant_identifier_names
    AppColor StyleApp = AppColor();
    final themeMode = Provider.of<ThemeModel>(context).themeMode;
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          Text("Dashboard", style: StyleApp.StyleTextTittle(context)),
          if (!ResponsiveView.isMobile(context)) ...{
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onTap: () {
                    cambiaModo(themeMode);
                  },
                  child: Icon(
                    themeMode == ThemeMode.system
                        ? Icons.circle_outlined
                        : themeMode == ThemeMode.light
                            ? Icons.light_mode
                            : Icons.dark_mode,
                    color: Colors.black,
                  ),
                ),
                navigationIcon(icon: Icons.send),
                navigationIcon(icon: Icons.notifications_none_rounded),
              ],
            )
          }
        ],
      ),
    );
  }

  void cambiaModo(themeMode) {
    if (themeMode == ThemeMode.system) {
      Provider.of<ThemeModel>(context, listen: false).themeMode =
          ThemeMode.light;
      Fluttertoast.showToast(
        msg: "Modo claro seleccionado",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else if (themeMode == ThemeMode.light) {
      Provider.of<ThemeModel>(context, listen: false).themeMode =
          ThemeMode.dark;
      Fluttertoast.showToast(
        msg: "Modo oscuro seleccionado",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } else {
      Provider.of<ThemeModel>(context, listen: false).themeMode =
          ThemeMode.system;
      Fluttertoast.showToast(
        msg: "Modo del sistema seleccionado",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Widget navigationIcon({icon}) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Icon(
        icon,
        color: AppColor.black,
      ),
    );
  }
}
