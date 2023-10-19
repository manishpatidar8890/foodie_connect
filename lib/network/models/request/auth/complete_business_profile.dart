import 'dart:convert';
CompleteBusinessProfileRequest completeBusinessProfileRequestFromJson(String str) => CompleteBusinessProfileRequest.fromJson(json.decode(str));

String completeBusinessProfileRequestToJson(CompleteBusinessProfileRequest data) => json.encode(data.toJson());

class CompleteBusinessProfileRequest {

  String? website;
  String? preferredNumber;
  String? businessNumber;
  String? address;


  CompleteBusinessProfileRequest({
    this.website,
    this. preferredNumber,
    this. businessNumber,
    this.address
  });

  factory CompleteBusinessProfileRequest.fromJson(Map<String, dynamic> json) => CompleteBusinessProfileRequest(
    website: json["website"],
    preferredNumber: json["mobile"],
    businessNumber: json["business_phone_number"],
    address: json["address"],

  );

  Map<String, dynamic> toJson() => {

    "website": website,
    "mobile": preferredNumber,
    "business_phone_number": businessNumber,
    "address": address,

  };
}
