// To parse this JSON data, do
//
//     final ownerPublishPublicDeals = ownerPublishPublicDealsFromJson(jsonString);

import 'dart:convert';

OwnerPublishPublicDeals ownerPublishPublicDealsFromJson(String str) => OwnerPublishPublicDeals.fromJson(json.decode(str));

String ownerPublishPublicDealsToJson(OwnerPublishPublicDeals data) => json.encode(data.toJson());

class OwnerPublishPublicDeals {
  bool? success;
  String? message;
  Data? data;
  String? error;

  OwnerPublishPublicDeals({
    this.success,
    this.message,
    this.data,
    this.error,
  });

  factory OwnerPublishPublicDeals.fromJson(Map<String, dynamic> json) => OwnerPublishPublicDeals(
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
  List<PublishDeal>? publishDeal;
  List<PublishDeal>? unpublishDeal;
  int? publishDealsCount;
  int? unpublishDealsCount;

  Data({
    this.publishDeal,
    this.unpublishDeal,
    this.publishDealsCount,
    this.unpublishDealsCount,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    publishDeal: json["publishDeal"] == null ? [] : List<PublishDeal>.from(json["publishDeal"]!.map((x) => PublishDeal.fromJson(x))),
    unpublishDeal: json["unpublishDeal"] == null ? [] : List<PublishDeal>.from(json["unpublishDeal"]!.map((x) => PublishDeal.fromJson(x))),
    publishDealsCount: json["publishDealsCount"],
    unpublishDealsCount: json["unpublishDealsCount"],
  );

  Map<String, dynamic> toJson() => {
    "publishDeal": publishDeal == null ? [] : List<dynamic>.from(publishDeal!.map((x) => x.toJson())),
    "unpublishDeal": unpublishDeal == null ? [] : List<dynamic>.from(unpublishDeal!.map((x) => x.toJson())),
    "publishDealsCount": publishDealsCount,
    "unpublishDealsCount": unpublishDealsCount,
  };
}

class PublishDeal {
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

  PublishDeal({
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

  factory PublishDeal.fromJson(Map<String, dynamic> json) => PublishDeal(
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
