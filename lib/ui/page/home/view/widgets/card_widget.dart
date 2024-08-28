import 'package:control_stock/ui/colors_view.dart';
import 'package:flutter/material.dart';

class NotificationCardWidget extends StatefulWidget {
  @override
  State<NotificationCardWidget> createState() => _NotificationCardWidgetState();
}

class _NotificationCardWidgetState extends State<NotificationCardWidget> {
  @override
  Widget build(BuildContext context) {
    AppColor StyleApp = AppColor();
    return Container(
      decoration: BoxDecoration(
          color: StyleApp.ColorContText(),
          borderRadius: BorderRadius.circular(20)),
      padding: EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: 16, color: AppColor.black),
                  children: [
                    Saludo(),
                    const TextSpan(
                      text: "Master Administrador",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Estamos muy contentos de tenerte aquí.",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.black,
                  height: 1.5,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "",
                style: TextStyle(
                    fontSize: 14,
                    color: AppColor.black,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              )
            ],
          ),
        ],
      ),
    );
  }

  TextSpan Saludo() {
    var now = DateTime.now();
    var saludo = '';

    if (now.hour >= 4 && now.hour < 12) {
      saludo = 'Buenos días ';
    } else if (now.hour >= 12 && now.hour < 18) {
      saludo = 'Buenas tardes ';
    } else {
      saludo = 'Buenas noches ';
    }

    return TextSpan(
      text: saludo,
    );
  }
}
