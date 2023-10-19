import 'dart:convert';

ResetPasswordRequest resetPasswordRequestFromJson(String str) => ResetPasswordRequest.fromJson(json.decode(str));

String resetPasswordRequestToJson(ResetPasswordRequest data) => json.encode(data.toJson());

class ResetPasswordRequest {
  String? email;
  String? newPassword;

  ResetPasswordRequest({
    this.email,
    this.newPassword,
  });

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) => ResetPasswordRequest(
    email: json["email"],
    newPassword: json["new_password"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "new_password": newPassword,
  };
}
