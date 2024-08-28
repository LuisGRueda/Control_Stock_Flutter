import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/home/view/widgets/calendar_widget.dart';
import 'package:control_stock/ui/page/home/view/widgets/card_profile_widget.dart';
import 'package:control_stock/ui/page/home/view/widgets/card_widget.dart';
import 'package:control_stock/ui/page/home/view/widgets/table_widget.dart';
import 'package:control_stock/ui/responsive/responsive_view.dart';
import 'package:flutter/material.dart';
import 'package:control_stock/ui/page/home/view/widgets/header_widget.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    AppColor StyleApp = AppColor();
    return Container(
      color: StyleApp.ColorContainer(context),
      child: Container(
        margin: EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: StyleApp.ColorBackgroud(context),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            /// Header Part
            HeaderWidget(),
            Expanded(
              child: SingleChildScrollView(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        child: Column(
                          children: [
                            NotificationCardWidget(),
                            const SizedBox(
                              height: 20,
                            ),
                            if (ResponsiveView.isMobile(context)) ...{
                              CalendarWidget(),
                              const SizedBox(
                                height: 20,
                              ),
                            },
                            RecruitmentDataWidget(),
                          ],
                        ),
                      ),
                    ),
                    if (!ResponsiveView.isMobile(context))
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: [
                              CalendarWidget(),
                              const SizedBox(
                                height: 20,
                              ),
                              ProfileCardWidget(),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
