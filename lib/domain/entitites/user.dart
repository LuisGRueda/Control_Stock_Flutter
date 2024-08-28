class User {
  final int id;
  final String username;
  final String password;
  final String accessToken;
  final String tokenType;
  final String expiresIn;
  final String scope;
  final bool isLogin;

  User(this.id, this.username, this.password, this.accessToken, this.tokenType,
      this.expiresIn, this.scope, this.isLogin);
}
