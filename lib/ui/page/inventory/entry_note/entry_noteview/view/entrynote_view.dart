import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/inventory/entry_note/entry_noteview/view/widgets/board_view.dart';
import 'package:control_stock/ui/page/inventory/entry_note/entry_noteview/view/widgets/header_entry_note.dart';
import 'package:control_stock/ui/page/inventory/entry_note/entry_noteview/viewmodel/entrynote_view_model.dart';
import 'package:control_stock/ui/responsive/responsive_view.dart';
import 'package:flutter/material.dart';

class EntryNoteView extends StatefulWidget {
  const EntryNoteView({super.key});
  @override
  State<EntryNoteView> createState() => _EntryNoteViewState();
}

class _EntryNoteViewState extends State<EntryNoteView> {
  @override
  AppColor StyleApp = AppColor();
  EntryNoteViewModel ProdModel = EntryNoteViewModel();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: StyleApp.ColorContainer(context),
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: StyleApp.ColorBackgroud(context),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            HeaderEntryNote(),
            const Divider(
              height: 1,
              thickness: 1,
              color: Color.fromARGB(200, 194, 196, 197),
            ),
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
                            const SizedBox(
                              height: 20,
                            ),
                            if (ResponsiveView.isMobile(context)) ...{
                              const SizedBox(
                                height: 20,
                              ),
                            },
                            const BoardEntryNote()
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
