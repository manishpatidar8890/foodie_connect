// To parse this JSON data, do
//
//     final scanQrResponse = scanQrResponseFromJson(jsonString);

import 'dart:convert';

ScanQrResponse scanQrResponseFromJson(String str) => ScanQrResponse.fromJson(json.decode(str));

String scanQrResponseToJson(ScanQrResponse data) => json.encode(data.toJson());

class ScanQrResponse {
  bool? success;
  String? message;
  Data? data;
  String? error;

  ScanQrResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory ScanQrResponse.fromJson(Map<String, dynamic> json) => ScanQrResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "error": error,
  };
}

class Data {
  int? totalScanned;

  Data({
    this.totalScanned,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    totalScanned: json["total_scanned"],
  );

  Map<String, dynamic> toJson() => {
    "total_scanned": totalScanned,
  };
}
