// To parse this JSON data, do
//
//     final createDealResponse = createDealResponseFromJson(jsonString);

import 'dart:convert';

CreateDealResponse createDealResponseFromJson(String str) => CreateDealResponse.fromJson(json.decode(str));

String createDealResponseToJson(CreateDealResponse data) => json.encode(data.toJson());

class CreateDealResponse {
  bool? success;
  String? message;
  Data? data;
  String? error;

  CreateDealResponse({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory CreateDealResponse.fromJson(Map<String, dynamic> json) => CreateDealResponse(
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
  int? userId;
  String? image;
  String? title;
  String? amount;
  String? customerBonus;
  String? customerFee;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  String? influencerId;
  String? isExclusiveDeal;
  int? isPublishDeal;
  DateTime? updatedAt;
  DateTime? createdAt;
  int? id;

  Data({
    this.userId,
    this.image,
    this.title,
    this.amount,
    this.customerBonus,
    this.customerFee,
    this.description,
    this.startDate,
    this.endDate,
    this.influencerId,
    this.isExclusiveDeal,
    this.isPublishDeal,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    userId: json["user_id"],
    image: json["image"],
    title: json["title"],
    amount: json["amount"],
    customerBonus: json["customer_bonus"],
    customerFee: json["customer_fee"],
    description: json["description"],
    startDate: json["start_date"] == null ? null : DateTime.parse(json["start_date"]),
    endDate: json["end_date"] == null ? null : DateTime.parse(json["end_date"]),
    influencerId: json["influencer_id"],
    isExclusiveDeal: json["is_exclusive_deal"],
    isPublishDeal: json["is_publish_deal"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "image": image,
    "title": title,
    "amount": amount,
    "customer_bonus": customerBonus,
    "customer_fee": customerFee,
    "description": description,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "influencer_id": influencerId,
    "is_exclusive_deal": isExclusiveDeal,
    "is_publish_deal": isPublishDeal,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
