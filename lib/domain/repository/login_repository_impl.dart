import 'package:control_stock/data/datasource/api/login_client_repository.dart';
import 'package:control_stock/domain/entitites/user.dart';

class LoginRepositoryimp extends LoginRepository {
  late final LoginClientRepository _loginClient;

  LoginRepositoryimp(this._loginClient);
  @override
  Future<User> userLogin({String? username, String? password}) async {
    final user = await _loginClient.userLogin(
        username: username ?? "", password: password ?? "");
    return user;
  }

  @override
  Future<void> userLogout() {
    // TODO: implement userLogout
    throw UnimplementedError();
  }
}

class LoginRepository {}
