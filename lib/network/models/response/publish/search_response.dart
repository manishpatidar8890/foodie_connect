// To parse this JSON data, do
//
//     final searchDealResponse = searchDealResponseFromJson(jsonString);

import 'dart:convert';

SearchDealResponse searchDealResponseFromJson(String str) => SearchDealResponse.fromJson(json.decode(str));

String searchDealResponseToJson(SearchDealResponse data) => json.encode(data.toJson());

class SearchDealResponse {
  bool? success;
  String? message;
  List<Datum>? data;
  String? error;

  SearchDealResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory SearchDealResponse.fromJson(Map<String, dynamic> json) => SearchDealResponse(
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
  int? id;
  int? userId;
  String? image;
  String? title;
  String? amount;
  String? customerFee;
  String? customerBonus;
  DateTime? startDate;
  DateTime? endDate;
  String? description;
  String? influencerId;
  int? isPublishDeal;
  int? isExclusiveDeal;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  Datum({
    this.id,
    this.userId,
    this.image,
    this.title,
    this.amount,
    this.customerFee,
    this.customerBonus,
    this.startDate,
    this.endDate,
    this.description,
    this.influencerId,
    this.isPublishDeal,
    this.isExclusiveDeal,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    id: json["id"],
    userId: json["user_id"],
    image: json["image"],
    title: json["title"],
    amount: json["amount"],
    customerFee: json["customer_fee"],
    customerBonus: json["customer_bonus"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    description: json["description"],
    influencerId: json["influencer_id"],
    isPublishDeal: json["is_publish_deal"],
    isExclusiveDeal: json["is_exclusive_deal"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "image": image,
    "title": title,
    "amount": amount,
    "customer_fee": customerFee,
    "customer_bonus": customerBonus,
    "start_date": startDate?.toIso8601String(),
    "end_date": endDate?.toIso8601String(),
    "description": description,
    "influencer_id": influencerId,
    "is_publish_deal": isPublishDeal,
    "is_exclusive_deal": isExclusiveDeal,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
