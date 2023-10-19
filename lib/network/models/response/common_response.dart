class CommonResponse {
  bool? success;
  String? message;

  CommonResponse({
    this.success,
    this.message,
  });

  factory CommonResponse.fromJson(Map<String, dynamic> json) => CommonResponse(
        success: json["success"],
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
      };
}
