import 'dart:convert';

class ValidationResponseModel {
  ValidationResponseModel({
    this.successful,
    this.msg,
    this.responseData,
  });

  factory ValidationResponseModel.fromJson(String str) =>
      ValidationResponseModel.fromMap(json.decode(str) as Map<String, dynamic>);

  factory ValidationResponseModel.fromMap(Map<String, dynamic> json) =>
      ValidationResponseModel(
        successful: json['successful'] as bool,
        msg: json['msg'] as String,
        responseData:
            ResponseData.fromMap(json['data'] as Map<String, dynamic>),
      );

  bool successful;
  String msg;
  ResponseData responseData;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'successful': successful,
        'msg': msg,
        'data': responseData.toMap(),
      };
}

class ResponseData {
  ResponseData({
    this.token,
    this.tokenExpiry,
    this.tNcs,
  });

  factory ResponseData.fromJson(String str) =>
      ResponseData.fromMap(json.decode(str) as Map<String, dynamic>);

  factory ResponseData.fromMap(Map<String, dynamic> json) => ResponseData(
        token: json['token'] as String,
        tokenExpiry: DateTime.parse(json['tokenExpiry'] as String),
        tNcs: json['termsAndConditions'] as String,
      );

  String token;
  String tNcs;
  DateTime tokenExpiry;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'token': token,
        'tokenExpiry': tokenExpiry.toIso8601String(),
        'tNcs': tNcs,
      };
}
