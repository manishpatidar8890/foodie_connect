import 'dart:convert';
CreateDealRequest createDealRequestFromJson(String str) => CreateDealRequest.fromJson(json.decode(str));

String createDealRequestToJson(CreateDealRequest data) => json.encode(data.toJson());

class CreateDealRequest {

  String? title;
  String? description;
  String? start_date;
  String? end_date;
  String? amount;
  String? customer_bonus;
  String? customer_fee;
  String? is_exclusive_deal;
  String? influencer_id;
  bool? published;

  CreateDealRequest({
    this.title,
    this.description,
    this.start_date,
    this.end_date,
    this.amount,
    this.customer_bonus,
    this.customer_fee,
    this.is_exclusive_deal,
    this.influencer_id,
    this.published,
  });

  factory CreateDealRequest.fromJson(Map<String, dynamic> json) => CreateDealRequest(
    title: json["title"],
    description: json["description"],
    start_date: json["start_date"],
    end_date: json["date_of_birth"],
    amount: json["instagram_link"],
    customer_bonus: json["youtube_link"],
    customer_fee: json["facebook_link"],
    is_exclusive_deal: json["tiktok_link"],
    influencer_id: json["influencer_id"],
    published: json["published"],
  );

  Map<String, dynamic> toJson() => {

    "title": title,
    "description": description,
    "start_date": start_date,
    "date_of_birth": end_date,
    "instagram_link": amount,
    "youtube_link": customer_bonus,
    "facebook_link": customer_fee,
    "tiktok_link": is_exclusive_deal,
    "influencer_id": influencer_id,
    "published": published,
  };
}
