import 'dart:convert';

import 'package:flutter/foundation.dart';

class LoginDto {
  LoginDto({
    @required this.phoneNumber,
    this.pin,
    this.token,
    this.tokenExpiry,
    this.otp,
    this.accountNumber,
  });

  factory LoginDto.fromJson(String str) =>
      LoginDto.fromMap(json.decode(str) as Map<String, dynamic>);

  factory LoginDto.fromMap(Map<String, dynamic> json) => LoginDto(
        phoneNumber: json['phoneNumber'] as String,
        pin: json['pin'] as String,
        token: json['token'] as String,
        tokenExpiry: DateTime.parse(json['tokenExpiry'] as String),
        otp: json['otp'] as String,
        accountNumber: json['accountNumber'] as String,
      );

  String phoneNumber;
  String pin;
  String token;
  DateTime tokenExpiry;
  String otp;
  String accountNumber;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'phoneNumber': phoneNumber,
        'pin': pin,
        'token': token,
        'tokenExpiry': tokenExpiry.toIso8601String(),
        'otp': otp,
        'accountNumber': accountNumber,
      };
}
