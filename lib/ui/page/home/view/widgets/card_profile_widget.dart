import 'package:control_stock/ui/colors_view.dart';
import 'package:flutter/material.dart';

class ProfileCardWidget extends StatefulWidget {
  @override
  State<ProfileCardWidget> createState() => _ProfileCardWidgetState();
}

class _ProfileCardWidgetState extends State<ProfileCardWidget> {
  AppColor StyleApp = AppColor();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: StyleApp.ColorContainer(context),
        borderRadius: BorderRadius.circular(10),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              /*ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Image.asset(
                  "assets/user1.jpg",
                  height: 60,
                  width: 60,
                ),
              ),*/
              const SizedBox(width: 10),
              Column(
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "Kathy Walker",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("HR Manager"),
                ],
              )
            ],
          ),
          const Divider(
            thickness: 0.5,
            color: Colors.grey,
          ),
          profileListTile("Joined Date", "18-Apr-2021"),
          profileListTile("Projects", "32 Active"),
          profileListTile("Accomplishment", "125"),
        ],
      ),
    );
  }

  Widget profileListTile(text, value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          Text(
            value,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                color: StyleApp.ColorText(context)),
          ),
        ],
      ),
    );
  }
}
