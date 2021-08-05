// To parse this JSON data, do
//
//     final userAccount = userAccountFromMap(jsonString);

import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserAccount {
  UserAccount({
    this.availableBalance,
    this.actualBalance,
    @required this.phoneNumber,
    this.accountNumber,
    this.accountType,
    this.kycLevel,
    this.firstName,
    this.surname,
    this.token,
    this.tokenExpiry,
    this.name,
    this.isQuickAccount,
  });

  factory UserAccount.fromJson(String str) =>
      UserAccount.fromMap(json.decode(str) as Map<String, dynamic>);

  factory UserAccount.fromMap(Map<String, dynamic> json) => UserAccount(
        availableBalance: json['availableBalance'] == null
            ? null
            : json['availableBalance'] as int,
        actualBalance:
            json['actualBalance'] == null ? null : json['actualBalance'] as int,
        phoneNumber:
            json['phoneNumber'] == null ? null : json['phoneNumber'] as String,
        accountNumber: json['accountNumber'] == null
            ? null
            : json['accountNumber'] as String,
        accountType:
            json['accountType'] == null ? null : json['accountType'] as String,
        kycLevel: json['kycLevel'] == null ? null : json['kycLevel'] as String,
        firstName:
            json['firstName'] == null ? null : json['firstName'] as String,
        surname: json['surname'] == null ? null : json['surname'] as String,
        token: json['token'] == null ? null : json['token'] as String,
        tokenExpiry: json['tokenExpiry'] == null
            ? null
            : DateTime.parse(json['tokenExpiry'] as String),
        name: json['name'] == null ? null : json['name'] as String,
        isQuickAccount: json['isQuickAccount'] == null
            ? null
            : json['isQuickAccount'] as bool,
      );

  int availableBalance;
  int actualBalance;
  String phoneNumber;
  String accountNumber;
  String accountType;
  String kycLevel;
  String firstName;
  String surname;
  String token;
  DateTime tokenExpiry;
  String name;
  bool isQuickAccount;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'availableBalance': availableBalance,
        'actualBalance': actualBalance,
        'phoneNumber': phoneNumber,
        'accountNumber': accountNumber,
        'accountType': accountType,
        'kycLevel': kycLevel,
        'firstName': firstName,
        'surname': surname,
        'token': token,
        'tokenExpiry': tokenExpiry?.toIso8601String(),
        'name': name,
        'isQuickAccount': isQuickAccount,
      };
}
