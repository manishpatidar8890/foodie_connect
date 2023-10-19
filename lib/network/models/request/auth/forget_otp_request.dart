import 'dart:convert';

ForgetOtpRequest ForgetOtpRequestFromJson(String str) => ForgetOtpRequest.fromJson(json.decode(str));

String ForgetOtpRequestToJson(ForgetOtpRequest data) => json.encode(data.toJson());

class ForgetOtpRequest {
  String email;

  ForgetOtpRequest({
    required this.email,
  });

  factory ForgetOtpRequest.fromJson(Map<String, dynamic> json) => ForgetOtpRequest(
    email: json["email"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
  };
}
