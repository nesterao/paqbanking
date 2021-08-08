import 'dart:convert';

import 'package:flutter/foundation.dart';

class AccountDto {
  AccountDto({
    this.token,
    this.tokenExpiry,
    this.otp,
    this.termsAndConditions,
    this.isQuickAccount,
    this.accountDetails,
  });

  factory AccountDto.fromJson(String str) =>
      AccountDto.fromMap(json.decode(str) as Map<String, dynamic>);

  factory AccountDto.fromMap(Map<String, dynamic> json) => AccountDto(
        token: json['token'] as String,
        tokenExpiry: DateTime.parse(json['tokenExpiry'] as String),
        otp: json['otp'] as String,
        termsAndConditions: json['termsAndConditions'] as String,
        isQuickAccount: json['isQuickAccount'] as bool,
        accountDetails: json['accountDetails'] as AccountDetails,
      );

  String token;
  DateTime tokenExpiry;
  String otp;
  String termsAndConditions;
  bool isQuickAccount;
  AccountDetails accountDetails;

  String toJson() => json.encode(toMap());

  // bool _intToBool(int e) {
  //   if (e == 0) {
  //     return false;
  //   } else if (e == 1) {
  //     return true;
  //   } else {
  //     throw Exception('Value must be either 0 or 1');
  //   }
  // }

  int _boolToInt(bool e) => e ? 1 : 0;

  Map<String, dynamic> toMap() => <String, dynamic>{
        'token': token,
        'tokenExpiry': tokenExpiry.toIso8601String(),
        'otp': otp,
        'termsAndConditions': termsAndConditions,
        'accountDetails': accountDetails,
        'isQuickAccount': _boolToInt(isQuickAccount),
      };
}

class AccountDetails {
  AccountDetails({
    this.name,
    this.accountType,
    this.kycLevel,
    @required this.phoneNumber,
    this.accountNumber,
  });

  factory AccountDetails.fromJson(String str) =>
      AccountDetails.fromMap(json.decode(str) as Map<String, dynamic>);

  factory AccountDetails.fromMap(Map<String, dynamic> json) => AccountDetails(
        name: json['name'] as String,
        accountType: json['accountType'] as String,
        kycLevel: json['kycLevel'] as String,
        phoneNumber: json['phoneNumber'] as String,
        accountNumber: json['accountNumber'] as String,
      );

  String name;
  String accountType;
  String kycLevel;
  String phoneNumber;
  String accountNumber;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'name': name,
        'accountType': accountType,
        'kycLevel': kycLevel,
        'phoneNumber': phoneNumber,
        'accountNumber': accountNumber,
      };
}
