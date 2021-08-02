import 'dart:convert';

class LoginAccountModel {
  LoginAccountModel({
    this.phoneNumber,
    this.accountNumber,
    this.pin,
    this.otpToken,
    this.tokenExpiry,
    this.otp,
  });

  factory LoginAccountModel.fromJson(String str) =>
      LoginAccountModel.fromMap(json.decode(str) as Map<String, String>);

  factory LoginAccountModel.fromMap(Map<String, dynamic> json) =>
      LoginAccountModel(
        phoneNumber: json['phoneNumber'] as String,
        accountNumber: json['accountNumber'] as String,
        tokenExpiry: json['tokenExpiry'] as DateTime,
        otpToken: json['otpToken'] as String,
      );

  String toJson() => json.encode(toMap());

  String phoneNumber;
  String accountNumber;
  String pin;
  String otpToken;
  DateTime tokenExpiry;
  String otp;

  Map<String, String> toMap() => <String, String>{
        'phoneNumber': phoneNumber,
        'accountNumber': accountNumber,
        'pin': pin,
        'otp': pin,
        'otpToken': pin,
      };
}
