
import 'dart:convert';

CommonResponseStatus commonResponseStatusFromJson(String str) => CommonResponseStatus.fromJson(json.decode(str));

String commonResponseStatusToJson(CommonResponseStatus data) => json.encode(data.toJson());

class CommonResponseStatus {
  bool? success;
  String? message;

  CommonResponseStatus({
    this.success,
    this.message,

  });

  factory CommonResponseStatus.fromJson(Map<String, dynamic> json) => CommonResponseStatus(
    success: json["success"],
    message: json["message"],

  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,

  };
}
