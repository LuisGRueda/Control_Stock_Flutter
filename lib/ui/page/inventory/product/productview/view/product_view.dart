import 'package:control_stock/ui/colors_view.dart';
import 'package:control_stock/ui/page/inventory/product/productview/view/widgets/board_view.dart';
import 'package:control_stock/ui/page/inventory/product/productview/view/widgets/header_product.dart';
import 'package:control_stock/ui/responsive/responsive_view.dart';
import 'package:flutter/material.dart';
import 'package:control_stock/ui/page/inventory/product/productview/viewmodel/product_view_model.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});
  @override
  State<ProductView> createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  @override
  AppColor StyleApp = AppColor();
  ProductViewModel ProdModel = ProductViewModel();

  @override
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
            HeaderProduct(),
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
                            const BoardProduct()
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
