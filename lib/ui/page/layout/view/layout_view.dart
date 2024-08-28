import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/SlideBarNav/view/slidebar_view.dart';
import 'package:control_stock/ui/page/home/view/home_view.dart';
import 'package:control_stock/ui/page/inventory/entry_note/entry_noteview/view/entrynote_view.dart';
import 'package:control_stock/ui/page/inventory/exit_note/exit_noteview/view/exitnote_view.dart';
import 'package:control_stock/ui/page/layout/viewmodel/layout_view_model.dart';
import 'package:control_stock/ui/page/person/view/person_view.dart';
import 'package:control_stock/ui/page/setting/view/setting_view.dart';
import 'package:control_stock/ui/page/inventory/product/productview/view/product_view.dart';
import 'package:flutter/material.dart';
import 'package:sidebarx/sidebarx.dart';
import 'package:control_stock/dep_injection/locator.dart';
import 'package:control_stock/ui/base_view.dart';

class LayoutView extends PrincipalView<LayoutViewModel> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final SidebarXController _controller =
      SidebarXController(selectedIndex: 0, extended: true);

  LayoutView() : super(getIt());

  @override
  Widget widget(LayoutViewModel model, BuildContext context) {
    final isSmallScreen = MediaQuery.of(context).size.width < 600;
    AppColor StyleApp = AppColor();
    return Scaffold(
      backgroundColor: StyleApp.ColorContainer(context),
      key: _key,
      appBar: isSmallScreen
          ? AppBar(
              leading: IconButton(
                onPressed: () {
                  _key.currentState?.openDrawer();
                },
                icon: const Icon(
                  Icons.menu,
                  color: Colors.lightBlue,
                ),
              ),
              backgroundColor: StyleApp.ColorContainer(context),
            )
          : null,
      drawer: SideBarX(
        controller: _controller,
      ),
      body: Row(
        children: [
          if (!isSmallScreen) SideBarX(controller: _controller),
          Expanded(
            child: Center(
              child: AnimatedBuilder(
                animation: _controller,
                builder: (context, child) {
                  switch (_controller.selectedIndex) {
                    case 0:
                      _key.currentState?.closeDrawer();
                      return const Center(child: HomeView());
                    case 1:
                      _key.currentState?.closeDrawer();
                      return const Center(child: ProductView());
                    case 2:
                      _key.currentState?.closeDrawer();
                      return const Center(child: EntryNoteView());
                    case 3:
                      _key.currentState?.closeDrawer();
                      return const Center(child: ExitNoteView());
                    case 4:
                      _key.currentState?.closeDrawer();
                      return const Center(child: PersonView());
                    default:
                      _key.currentState?.closeDrawer();
                      return const Center(child: SettingsView());
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
