// To parse this JSON data, do
//
//     final searchDealRequest = searchDealRequestFromJson(jsonString);

import 'dart:convert';

SearchDealRequest searchDealRequestFromJson(String str) => SearchDealRequest.fromJson(json.decode(str));

String searchDealRequestToJson(SearchDealRequest data) => json.encode(data.toJson());

class SearchDealRequest {
  String? search;
  String? isPublishDeal;
  String? isExclusiveDeal;
  String? userType;

  SearchDealRequest({
    this.search,
    this.isPublishDeal,
    this.isExclusiveDeal,
    this.userType,
  });

  factory SearchDealRequest.fromJson(Map<String, dynamic> json) => SearchDealRequest(
    search: json["search"],
    isPublishDeal: json["is_publish_deal"],
    isExclusiveDeal: json["is_exclusive_deal"],
    userType: json["user_type"],
  );

  Map<String, dynamic> toJson() => {
    "search": search,
    "is_publish_deal": isPublishDeal,
    "is_exclusive_deal": isExclusiveDeal,
    "user_type": userType,
  };
}
