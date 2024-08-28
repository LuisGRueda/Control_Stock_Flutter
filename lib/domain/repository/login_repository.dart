import '../entitites/user.dart';

abstract class LoginRepository {
  Future<User> userLogin({String username, String password});
  Future<void> userLogout();
}
