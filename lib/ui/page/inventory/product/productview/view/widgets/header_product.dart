import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/responsive/responsive_view.dart';
import 'package:flutter/material.dart';
import 'package:control_stock/ui/page/inventory/product/productcrud/view/crudproduct_view.dart';

class HeaderProduct extends StatefulWidget {
  const HeaderProduct({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HeaderProductState createState() => _HeaderProductState();
}

class _HeaderProductState extends State<HeaderProduct> {
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
                "Productos",
                style: styleapp.StyleTextTittle(context),
              ),
              const Spacer(),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!ResponsiveView.isMobile(context))
                    MyModalBottomProduct(
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
            MyModalBottomProduct(
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
