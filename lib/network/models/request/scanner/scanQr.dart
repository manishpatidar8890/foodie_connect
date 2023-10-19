// To parse this JSON data, do
//
//     final scanQrRequest = scanQrRequestFromJson(jsonString);

import 'dart:convert';

ScanQrRequest scanQrRequestFromJson(String str) => ScanQrRequest.fromJson(json.decode(str));

String scanQrRequestToJson(ScanQrRequest data) => json.encode(data.toJson());

class ScanQrRequest {
  String? qrCode;
  String? userName;

  ScanQrRequest({
    this.qrCode,
    this.userName,
  });

  factory ScanQrRequest.fromJson(Map<String, dynamic> json) => ScanQrRequest(
    qrCode: json["qrCode"],
    userName: json["userName"],
  );

  Map<String, dynamic> toJson() => {
    "qrCode": qrCode,
    "userName": userName,
  };
}
