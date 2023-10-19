import 'dart:convert';

ValidateEmailUserName validateEmailUserNameFromJson(String str) => ValidateEmailUserName.fromJson(json.decode(str));

String validateEmailUserNameToJson(ValidateEmailUserName data) => json.encode(data.toJson());

class ValidateEmailUserName {
  String? type;
  String? value;

  ValidateEmailUserName({
    this.type,
    this.value,
  });

  factory ValidateEmailUserName.fromJson(Map<String, dynamic> json) => ValidateEmailUserName(
    type: json["type"],
    value: json["value"],
  );

  Map<String, dynamic> toJson() => {
    "type": type,
    "value": value,
  };
}
