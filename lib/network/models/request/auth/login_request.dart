
import 'dart:convert';

LoginRequest loginRequestFromJson(String str) => LoginRequest.fromJson(json.decode(str));

String loginRequestToJson(LoginRequest data) => json.encode(data.toJson());

class LoginRequest {
  String? userType;
  String? emailOrUsername;
  String? password;

  LoginRequest({
    this.userType,
    this.emailOrUsername,
    this.password,
  });

  factory LoginRequest.fromJson(Map<String, dynamic> json) => LoginRequest(
    userType: json["user_type"],
    emailOrUsername: json["email_or_username"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "user_type": userType,
    "email_or_username": emailOrUsername,
    "password": password,
  };
}
