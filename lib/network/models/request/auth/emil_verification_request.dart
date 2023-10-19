import 'dart:convert';

EmailVerificationRequest emailVerificationRequestFromJson(String str) => EmailVerificationRequest.fromJson(json.decode(str));

String emailVerificationRequestToJson(EmailVerificationRequest data) => json.encode(data.toJson());

class EmailVerificationRequest {
  String email;
  String otpCode;

  EmailVerificationRequest({
    required this.email,
    required this.otpCode,
  });

  factory EmailVerificationRequest.fromJson(Map<String, dynamic> json) => EmailVerificationRequest(
    email: json["email"],
    otpCode: json["otp_code"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "otp_code": otpCode,
  };
}
