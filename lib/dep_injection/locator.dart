import 'package:control_stock/data/datasource/api/login_client.dart';
import 'package:control_stock/data/datasource/api/login_client_repository.dart';
import 'package:control_stock/domain/repository/login_repository_impl.dart';
import 'package:control_stock/ui/page/layout/viewmodel/layout_view_model.dart';
import 'package:get_it/get_it.dart';
import '../ui/navigation.dart';
import 'package:http/http.dart' as http;

final getIt = GetIt.instance;

Future<void> initializeDI() async {
  _data();
  _domain();
  _view();
}

void _data() async {
  // DATA
  getIt.registerSingleton<LoginClientRepository>(LoginClient(http.Client()));
  getIt.registerSingleton<LoginRepository>(LoginRepositoryimp(getIt.get()));
}

void _domain() async {}

void _view() async {
  getIt.registerSingleton<Navigation>(Navigation());
  getIt.registerFactory<LayoutViewModel>(() => LayoutViewModel(getIt()));
}
