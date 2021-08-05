import 'dart:convert';

import 'package:flutter/foundation.dart';

class AccountDto {
  AccountDto({
    @required this.phoneNumber,
    this.accountNumber,
    this.token,
    this.tokenExpiry,
    this.otp,
    this.termsAndConditions,
  });

  factory AccountDto.fromJson(String str) =>
      AccountDto.fromMap(json.decode(str) as Map<String, dynamic>);

  factory AccountDto.fromMap(Map<String, dynamic> json) => AccountDto(
        phoneNumber: json['phoneNumber'] as String,
        accountNumber: json['accountNumber'] as String,
        token: json['token'] as String,
        tokenExpiry: DateTime.parse(json['tokenExpiry'] as String),
        otp: json['otp'] as String,
        termsAndConditions: json['termsAndConditions'] as String,
      );

  String phoneNumber;
  String accountNumber;
  String token;
  DateTime tokenExpiry;
  String otp;
  String termsAndConditions;
  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'phoneNumber': phoneNumber,
        'accountNumber': accountNumber,
        'token': token,
        'tokenExpiry': tokenExpiry.toIso8601String(),
        'otp': otp,
        'termsAndConditions': termsAndConditions,
      };
}
