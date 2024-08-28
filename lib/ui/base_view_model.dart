import 'package:stacked/stacked.dart';

abstract class PrincipalViewModel extends BaseViewModel {
  bool _loading = false;
  bool get loading => _loading;

  Future loadData() async {
    //doInializar
    notify();
  }

  void showProgress() {
    _loading = true;
    notify();
  }

  void hideProgress() {
    _loading = false;
    notify();
  }

  notify() {
    notifyListeners();
  }
}
