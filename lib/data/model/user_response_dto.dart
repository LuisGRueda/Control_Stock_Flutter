class UserResponseDto {
  String accesToken;
  String tokenType;
  String expiresIn;
  String scope;

  UserResponseDto(
      {required this.accesToken,
      required this.tokenType,
      required this.expiresIn,
      required this.scope});

  // now create converter

  factory UserResponseDto.fromJson(Map<String, dynamic> responseData) {
    return UserResponseDto(
        accesToken: responseData['access_token'],
        tokenType: responseData['token_type'],
        expiresIn: responseData['expires_in'],
        scope: responseData['scope'] ?? "");
  }
}
