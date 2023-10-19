// To parse this JSON data, do
//
//     final searchInfluencerResponse = searchInfluencerResponseFromJson(jsonString);

import 'dart:convert';

SearchInfluencerResponse searchInfluencerResponseFromJson(String str) => SearchInfluencerResponse.fromJson(json.decode(str));

String searchInfluencerResponseToJson(SearchInfluencerResponse data) => json.encode(data.toJson());

class SearchInfluencerResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  String? error;

  SearchInfluencerResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory SearchInfluencerResponse.fromJson(Map<String, dynamic> json) => SearchInfluencerResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
    error: json["error"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "error": error,
  };
}

class Datum {
  String? firstName;
  String? lastName;
  dynamic image;
  int? id;

  Datum({
    this.firstName,
    this.lastName,
    this.image,
    this.id,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    firstName: json["first_name"],
    lastName: json["last_name"],
    image: json["image"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "first_name": firstName,
    "last_name": lastName,
    "image": image,
    "id": id,
  };
}
