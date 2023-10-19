import 'dart:convert';
CompleteInfluencerProfileRequest completeInfluencerProfileRequestFromJson(String str) => CompleteInfluencerProfileRequest.fromJson(json.decode(str));

String completeInfluencerProfileRequestToJson(CompleteInfluencerProfileRequest data) => json.encode(data.toJson());

class CompleteInfluencerProfileRequest {

  String? bio;
  String? mobile;
  String? gender;
  String? dateOfBirth;
  String? instagramLink;
  String? youtubeLink;
  String? facebookLink;
  String? tiktokLink;

  CompleteInfluencerProfileRequest({
    this.bio,
    this.mobile,
    this.gender,
    this.dateOfBirth,
    this.instagramLink,
    this.youtubeLink,
    this.facebookLink,
    this.tiktokLink,
  });

  factory CompleteInfluencerProfileRequest.fromJson(Map<String, dynamic> json) => CompleteInfluencerProfileRequest(
    bio: json["bio"],
    mobile: json["mobile"],
    gender: json["gender"],
    dateOfBirth: json["date_of_birth"],
    instagramLink: json["instagram_link"],
    youtubeLink: json["youtube_link"],
    facebookLink: json["facebook_link"],
    tiktokLink: json["tiktok_link"],
  );

  Map<String, dynamic> toJson() => {

    "bio": bio,
    "mobile": mobile,
    "gender": gender,
    "date_of_birth": dateOfBirth,
    "instagram_link": instagramLink,
    "youtube_link": youtubeLink,
    "facebook_link": facebookLink,
    "tiktok_link": tiktokLink,
  };
}
