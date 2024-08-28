import 'package:control_stock/ui/page/inventory/product/productview/view/product_view.dart';
import 'package:get/get.dart';

class Navigation {
  void toVentas() {
    //Get.to(VentasView());
  }
  void toProduct() {
    Get.to(ProductView());
  }

  void backViaje() {
    Get.back();
  }
}
