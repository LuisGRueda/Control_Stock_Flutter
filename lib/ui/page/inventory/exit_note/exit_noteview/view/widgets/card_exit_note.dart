import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/home/view/widgets/table_widget.dart';
import 'package:flutter/material.dart';

class CardExitNote extends StatelessWidget {
  const CardExitNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: StyleApp.ColorContText(),
          borderRadius: BorderRadius.circular(20)),
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text.rich(
                TextSpan(
                  style: TextStyle(fontSize: 16, color: AppColor.black),
                  children: const [
                    TextSpan(text: "Good Morning "),
                    TextSpan(
                      text: "Ravi Patel!",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "",
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.black,
                  height: 1.5,
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Read More",
                style: TextStyle(
                    fontSize: 14,
                    color: StyleApp.ColorText(context),
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              )
            ],
          ),
          if (MediaQuery.of(context).size.width >= 620) ...{
            Spacer(),
            Image.asset(
              "notification_image.png",
              height: 160,
            )
          }
        ],
      ),
    );
  }
}