// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  bool? success;
  String? message;
  Data? data;
  int? isVerify;
  String? error;

  LoginResponse({
    this.success,
    this.message,
    this.data,
    this.isVerify,

  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    success: json["success"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
    isVerify: json["is_verify"],

  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data?.toJson(),
    "is_verify": isVerify,

  };
}

class Data {
  String? accessToken;
  User? user;

  Data({
    this.accessToken,
    this.user,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    accessToken: json["access_token"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "access_token": accessToken,
    "user": user?.toJson(),
  };
}

class User {
  int? id;
  String? firstName;
  String? lastName;
  dynamic businessName;
  dynamic image;
  String? email;
  String? userName;
  dynamic gender;
  dynamic mobile;
  dynamic businessPhoneNumber;
  dynamic bio;
  dynamic address;
  dynamic dateOfBirth;
  dynamic instagramLink;
  dynamic tiktokLink;
  dynamic youtubeLink;
  dynamic facebookLink;
  dynamic website;
  dynamic dealContract;
  String? userType;
  String? qrCode;
  String? otpCode;
  dynamic latitude;
  dynamic longitude;
  int? isVerify;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.businessName,
    this.image,
    this.email,
    this.userName,
    this.gender,
    this.mobile,
    this.businessPhoneNumber,
    this.bio,
    this.address,
    this.dateOfBirth,
    this.instagramLink,
    this.tiktokLink,
    this.youtubeLink,
    this.facebookLink,
    this.website,
    this.dealContract,
    this.userType,
    this.qrCode,
    this.otpCode,
    this.latitude,
    this.longitude,
    this.isVerify,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    businessName: json["business_name"],
    image: json["image"],
    email: json["email"],
    userName: json["user_name"],
    gender: json["gender"],
    mobile: json["mobile"],
    businessPhoneNumber: json["business_phone_number"],
    bio: json["bio"],
    address: json["address"],
    dateOfBirth: json["date_of_birth"],
    instagramLink: json["instagram_link"],
    tiktokLink: json["tiktok_link"],
    youtubeLink: json["youtube_link"],
    facebookLink: json["facebook_link"],
    website: json["website"],
    dealContract: json["deal_contract"],
    userType: json["user_type"],
    qrCode: json["qr_code"],
    otpCode: json["otp_code"],
    latitude: json["latitude"],
    longitude: json["longitude"],
    isVerify: json["is_verify"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "business_name": businessName,
    "image": image,
    "email": email,
    "user_name": userName,
    "gender": gender,
    "mobile": mobile,
    "business_phone_number": businessPhoneNumber,
    "bio": bio,
    "address": address,
    "date_of_birth": dateOfBirth,
    "instagram_link": instagramLink,
    "tiktok_link": tiktokLink,
    "youtube_link": youtubeLink,
    "facebook_link": facebookLink,
    "website": website,
    "deal_contract": dealContract,
    "user_type": userType,
    "qr_code": qrCode,
    "otp_code": otpCode,
    "latitude": latitude,
    "longitude": longitude,
    "is_verify": isVerify,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
  };
}
