import 'dart:convert';

import 'package:control_stock/data/datasource/api/login_client_repository.dart';
import 'package:control_stock/data/model/user_request_dto.dart';
import 'package:control_stock/data/model/user_response_dto.dart';
import 'package:control_stock/domain/entitites/user.dart';
import 'package:http/http.dart';

class LoginClient extends LoginClientRepository {
  // final String _endpoint = "http://10.0.2.2:63058/api/Token";
  final String _endpoint = "http://localhost:63058/api/Token";
  late final Client _client;

  LoginClient(this._client);

  @override
  Future<User> userLogin({String? username, String? password}) async {
    UserRequestDto requestModel = UserRequestDto(
        userName: username ?? "",
        password: password ?? "",
        granttype: "",
        accessType: "",
        clienteId: "appAdmin");
    var body = requestModel.toJson();
    final response = await _client.post(Uri.parse(_endpoint),
        body: body, encoding: Encoding.getByName("utf-8"));
    final dto = UserResponseDto.fromJson(jsonDecode(response.body));
    if (response.statusCode == 200) {
      return User(0, username ?? "", password ?? "", dto.accesToken,
          dto.tokenType, dto.expiresIn, dto.scope, true);
    } else {
      return User(0, username ?? "", password ?? "", dto.accesToken,
          dto.tokenType, dto.expiresIn, dto.scope, false);
    }
  }

  @override
  Future<void> userLogout() {
    throw UnimplementedError();
  }
}
