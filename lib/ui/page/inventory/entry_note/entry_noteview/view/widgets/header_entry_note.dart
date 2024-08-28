import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/inventory/entry_note/entry_notecrud/view/crudentrynote_view.dart';
import 'package:control_stock/ui/responsive/responsive_view.dart';
import 'package:flutter/material.dart';

class HeaderEntryNote extends StatefulWidget {
  const HeaderEntryNote({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeaderEntryNoteState createState() => _HeaderEntryNoteState();
}

class _HeaderEntryNoteState extends State<HeaderEntryNote> {
  AppColor styleapp = AppColor();
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            children: [
              Text(
                "EntryNoteos",
                style: styleapp.StyleTextTittle(context),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!ResponsiveView.isMobile(context))
                    MyModalBottomEntryNote(
                      null,
                      onNewDataAdded: () {
                        setState(() {});
                      },
                    ),
                ],
              ),
            ],
          ),
          if (ResponsiveView.isMobile(context)) ...[
            styleapp.Separate16(),
            MyModalBottomEntryNote(
              null,
              onNewDataAdded: () {
                setState(() {});
              },
            ),
          ],
        ],
      ),
    );
  }
}
