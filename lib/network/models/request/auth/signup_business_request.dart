
import 'dart:convert';

SignupBusinessRequest signupBusinessRequestFromJson(String str) => SignupBusinessRequest.fromJson(json.decode(str));

String signupBusinessRequestToJson(SignupBusinessRequest data) => json.encode(data.toJson());

class SignupBusinessRequest {
  String? businessName;
  String? email;
  String? password;
  String? userName;

  SignupBusinessRequest({
    this.businessName,
    this.email,
    this.password,
    this.userName,
  });

  factory SignupBusinessRequest.fromJson(Map<String, dynamic> json) => SignupBusinessRequest(
    businessName: json["business_name"],
    email: json["email"],
    password: json["password"],
    userName: json["user_name"],
  );

  Map<String, dynamic> toJson() => {
    "business_name": businessName,
    "email": email,
    "password": password,
    "user_name": userName,
  };
}
