import 'dart:convert';

ForgetOtpVerifyRequest forgetOtpVerifyRequestFromJson(String str) => ForgetOtpVerifyRequest.fromJson(json.decode(str));

String forgetOtpVerifyRequestToJson(ForgetOtpVerifyRequest data) => json.encode(data.toJson());

class ForgetOtpVerifyRequest {
  String? email;
  String? otpCode;

  ForgetOtpVerifyRequest({
    this.email,
    this.otpCode,
  });

  factory ForgetOtpVerifyRequest.fromJson(Map<String, dynamic> json) => ForgetOtpVerifyRequest(
    email: json["email"],
    otpCode: json["otp_code"],
  );

  Map<String, dynamic> toJson() => {
    "email": email,
    "otp_code": otpCode,
  };
}
