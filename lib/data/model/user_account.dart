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
    this.isQuickAccount,
    this.transactions,
  });

  factory UserAccount.fromJson(String str) =>
      UserAccount.fromMap(json.decode(str) as Map<String, dynamic>);

  factory UserAccount.fromMap(Map<String, dynamic> json) => UserAccount(
        availableBalance: json['availableBalance'] == null
            ? null
            : json['availableBalance'] as double,
        actualBalance: json['actualBalance'] == null
            ? null
            : json['actualBalance'] as double,
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
        isQuickAccount: json['isQuickAccount'] == null
            ? null
            : json['isQuickAccount'] as bool,
        transactions: json['transactions'] == null
            ? null
            : json['transactions'] as List<Transaction>,
      );

  double availableBalance;
  double actualBalance;
  String phoneNumber;
  String accountNumber;
  String accountType;
  String kycLevel;
  String firstName;
  String surname;
  String token;
  DateTime tokenExpiry;
  bool isQuickAccount;
  List<Transaction> transactions;

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
        'availableBalance': availableBalance,
        'actualBalance': actualBalance,
        'phoneNumber': phoneNumber,
        'accountNumber': accountNumber,
        'accountType': accountType,
        'kycLevel': kycLevel,
        'firstName': firstName,
        'surname': surname,
        'token': token,
        'tokenExpiry': tokenExpiry.toIso8601String(),
        'isQuickAccount': _boolToInt(isQuickAccount),
        // 'transactions': transactions,
      };
}

class User {
  User({
    this.firstName,
    this.surname,
  });

  factory User.fromJson(String str) =>
      User.fromMap(json.decode(str) as Map<String, dynamic>);

  factory User.fromMap(Map<String, dynamic> json) => User(
        firstName: json['firstName'] as String,
        surname: json['surname'] as String,
      );

  String firstName;
  String surname;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'firstName': firstName,
        'surname': surname,
      };
}

class Transaction {
  Transaction({
    this.id,
    this.createdAt,
    this.description,
    this.amount,
    this.charge,
  });

  factory Transaction.fromJson(String str) =>
      Transaction.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Transaction.fromMap(Map<String, dynamic> json) => Transaction(
        id: json['id'] as int,
        createdAt: DateTime.parse(json['createdAt'] as String),
        description: json['description'] as String,
        amount: json['amount'] as num,
        charge: json['charge'] as num,
      );

  int id;
  DateTime createdAt;
  String description;
  num amount;
  num charge;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'description': description,
        'amount': amount,
        'charge': charge,
      };
}
