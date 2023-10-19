import 'dart:convert';

SignupInfluencerRequest signupInfluencerRequestFromJson(String str) => SignupInfluencerRequest.fromJson(json.decode(str));

String signupInfluencerRequestToJson(SignupInfluencerRequest data) => json.encode(data.toJson());

class SignupInfluencerRequest {
  String? firstName;
  String? lastName;
  String? userName;
  String? email;
  String? password;

  SignupInfluencerRequest({
    this.firstName,
    this.lastName,
    this.userName,
    this.email,
    this.password,
  });

  factory SignupInfluencerRequest.fromJson(Map<String, dynamic> json) => SignupInfluencerRequest(
    firstName: json["first_name"],
    lastName: json["last_name"],
    userName: json["user_name"],
    email: json["email"],
    password: json["password"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "user_name": userName,
    "email": email,
    "password": password,
  };
}
