import 'dart:convert';

SignupInfluencerResponse signupInfluencerResponseFromJson(String str) =>
    SignupInfluencerResponse.fromJson(json.decode(str));

String signupInfluencerResponseToJson(SignupInfluencerResponse data) =>
    json.encode(data.toJson());

class SignupInfluencerResponse {
  bool? success;
  String? message;
  List<dynamic>? data;
  String? error;

  SignupInfluencerResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory SignupInfluencerResponse.fromJson(Map<String, dynamic> json) =>
      SignupInfluencerResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"] == null
            ? []
            : List<dynamic>.from(json["data"]!.map((x) => x)),
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x)),
        "error": error,
      };
}
