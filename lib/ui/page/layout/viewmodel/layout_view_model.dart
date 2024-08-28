import 'package:control_stock/ui/base_view_model.dart';
import 'package:control_stock/ui/navigation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_utils/src/get_utils/get_utils.dart';

class LayoutViewModel extends PrincipalViewModel {
  late final Navigation _navigator;
  LayoutViewModel(this._navigator);
  @override
  @override
  Future loadData() async {
    notify();
  }

  seletecPersona() {
    Get.snackbar("Hola", "Mi mensaje");
    GetUtils.isEmail("email@gmail.com");
  }
}
