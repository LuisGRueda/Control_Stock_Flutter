import 'package:control_stock/ui/base_view_model.dart';
import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/navigation.dart';
import 'package:control_stock/ui/page/profile/view/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:sidebarx/sidebarx.dart';
import '../../../../main.dart';

const canvasColor = Color.fromARGB(255, 255, 255, 255);
const colorFondo = Color.fromRGBO(232, 233, 239, 1);

class SideBarX extends StatefulWidget {
  const SideBarX({Key? key, required this.controller}) : super(key: key);

  final SidebarXController controller;

  @override
  State<SideBarX> createState() => _SideBarXState();
}

class _SideBarXState extends State<SideBarX> {
  // ignore: non_constant_identifier_names
  AppColor StyleApp = AppColor();
  @override
  Widget build(BuildContext context) {
    List<bool> isSelected = [false, false, false];
    return SidebarX(
      controller: widget.controller,
      theme: SidebarXTheme(
        decoration: BoxDecoration(
          color: StyleApp.ColorContainer(context),
        ),
      ),
      extendedTheme: const SidebarXTheme(
          width: 220,
          selectedItemDecoration: BoxDecoration(color: Colors.lightBlue),
          selectedTextStyle: TextStyle(color: Colors.white),
          selectedIconTheme: IconThemeData(color: Colors.white)),
      footerDivider: const Divider(
        height: 1,
        color: Color.fromARGB(200, 194, 196, 197),
      ),
      headerBuilder: _buildHeader,
      showToggleButton: true,
      items: const [
        SidebarXItem(icon: Icons.home, label: 'Home'),
        SidebarXItem(icon: Icons.inventory, label: 'Productos'),
        SidebarXItem(icon: Icons.note, label: 'Nota de Entrada'),
        SidebarXItem(icon: Icons.person, label: 'Nota de Salida'),
        SidebarXItem(icon: Icons.business, label: 'Personal'),
        SidebarXItem(icon: Icons.settings, label: 'Configuracion'),
      ],
    );
  }

  Widget _buildHeader(BuildContext context, bool extended) {
    final isSmallScreen = MediaQuery.of(context).size.width < 800;
    return GestureDetector(
      onTap: () {},
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          SizedBox(
            width: 100,
            height: 100,
            child: ClipOval(
              child: Image.network(
                'https://cdn.pixabay.com/photo/2016/12/26/18/33/logo-1932539_1280.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 10),
          const Divider(
            height: 1,
            thickness: 1,
            color: Color.fromARGB(200, 194, 196, 197),
          ),
        ],
      ),
    );
  }
}
