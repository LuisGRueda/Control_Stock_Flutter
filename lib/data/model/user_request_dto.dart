class UserRequestDto {
  String userName;
  String password;
  String granttype;
  String accessType;
  String clienteId;

  UserRequestDto({
    required this.userName,
    required this.password,
    required this.granttype,
    required this.accessType,
    required this.clienteId,
  });

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'username': userName.trim(),
      'password': password.trim(),
      'grant_type': granttype.trim(),
      'accessType': accessType.trim(),
      'clienteId': clienteId
    };

    return map;
  }
}
