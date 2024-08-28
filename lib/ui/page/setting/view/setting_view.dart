import 'package:control_stock/main.dart';
import 'package:control_stock/ui/colors_view.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<SettingsView> {
  List<bool> isSelected = [true, false, false];

  @override
  Widget build(BuildContext context) {
    AppColor StyleApp = AppColor();
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Configuraciones',
            style: TextStyle(
              color: StyleApp.ColorText(context),
            ),
          ),
        ),
        backgroundColor: StyleApp.ColorContainer(context),
      ),
      backgroundColor: StyleApp.ColorBackgroud(context),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            ToggleButtons(
              isSelected: isSelected,
              onPressed: (int index) {
                setState(() {
                  isSelected[index] = !isSelected[index];
                });
                switch (index) {
                  case 0:
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
                    break;
                  case 1:
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
                    break;
                  case 2:
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
                    break;
                  default:
                    break;
                }
              },
              selectedColor: Colors.blue,
              color: Colors.grey,
              selectedBorderColor: Colors.blue,
              borderColor: Colors.grey,
              borderRadius: BorderRadius.circular(30),
              mouseCursor: MouseCursor.defer,
              hoverColor: Colors.blue,
              children: const <Widget>[
                Icon(Icons.circle_outlined),
                Icon(Icons.dark_mode),
                Icon(Icons.light_mode),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
