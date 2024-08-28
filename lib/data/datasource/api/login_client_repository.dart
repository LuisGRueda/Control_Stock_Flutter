import 'package:control_stock/domain/entitites/user.dart';

abstract class LoginClientRepository {
  Future<User> userLogin({String username, String password});
  Future<void> userLogout();
}
