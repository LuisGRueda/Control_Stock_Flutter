import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/inventory/exit_note/exit_notecrud/view/exit_notecrud_view.dart';
import 'package:control_stock/ui/page/inventory/exit_note/exit_noteview/view/widgets/board_view.dart';
import 'package:control_stock/ui/page/inventory/exit_note/exit_noteview/view/widgets/buttoms_view.dart';
import 'package:control_stock/ui/page/inventory/exit_note/exit_noteview/view/widgets/card_exit_note.dart';
import 'package:control_stock/ui/page/inventory/exit_note/exit_noteview/view/widgets/header_exit_note.dart';
import 'package:control_stock/ui/page/inventory/exit_note/exit_noteview/viewmodel/exitnote_view_model.dart';
import 'package:control_stock/ui/responsive/responsive_view.dart';
import 'package:flutter/material.dart';

class ExitNoteView extends StatefulWidget {
  const ExitNoteView({super.key});
  @override
  State<ExitNoteView> createState() => _ExitNoteViewState();
}

class _ExitNoteViewState extends State<ExitNoteView> {
  @override
  AppColor StyleApp = AppColor();
  ExitNoteViewModel ProdModel = ExitNoteViewModel();
  Widget build(BuildContext context) {
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
            HeaderExitNote(),
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
                            CardExitNote(),
                            const SizedBox(
                              height: 20,
                            ),
                            if (ResponsiveView.isMobile(context)) ...{
                              //MyModalBottomExitNote(),
                              const SizedBox(
                                height: 20,
                              ),
                            },
                            BoardExitNote()
                          ],
                        ),
                      ),
                    ),
                    if (!ResponsiveView.isMobile(context))
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            children: const [
                              ButtomsViewExitNote(),
                              SizedBox(
                                height: 20,
                              ),
                              //ProfileCardWidget(),
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
