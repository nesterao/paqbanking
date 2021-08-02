import 'dart:convert';

class Account {
  Account({
    this.successful,
    this.msg,
    this.accountData,
  });

  factory Account.fromJson(String str) =>
      Account.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Account.fromMap(Map<String, dynamic> json) => Account(
        successful: json['successful'] as bool,
        msg: json['msg'] as String,
        accountData: AccountData.fromMap(json['data'] as Map<String, dynamic>),
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'successful': successful,
        'msg': msg,
        'data': accountData.toMap(),
      };

  bool successful;
  String msg;
  AccountData accountData;
}

class AccountData {
  AccountData({
    this.token,
    this.tokenExpiry,
    this.accountDetails,
    this.isQuickAccount,
    this.requestMsg,
  });

  factory AccountData.fromJson(String str) =>
      AccountData.fromMap(json.decode(str) as Map<String, dynamic>);

  factory AccountData.fromMap(Map<String, dynamic> json) => AccountData(
        token: json['token'] as String,
        tokenExpiry: DateTime.parse(json['tokenExpiry'] as String),
        accountDetails: AccountDetails.fromMap(
            json['accountDetails'] as Map<String, dynamic>),
        isQuickAccount: json['isQuickAccount'] as bool,
        requestMsg: json['requestMsg'] as String,
      );

  String token;
  DateTime tokenExpiry;
  AccountDetails accountDetails;
  bool isQuickAccount;
  String requestMsg;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'token': token,
        'tokenExpiry': tokenExpiry.toIso8601String(),
        'accountDetails': accountDetails.toMap(),
        'isQuickAccount': isQuickAccount,
        'requestMsg': requestMsg,
      };
}

class AccountDetails {
  AccountDetails({
    this.accountType,
    this.kycLevel,
    this.phoneNumber,
    this.accountNumber,
    this.firstName,
    this.surname,
    this.name,
    this.dateOfBirth,
    this.idType,
    this.idNumber,
    this.title,
    this.email,
    this.assistedByAgentCode,
    this.motherMaidenName,
    this.question1,
    this.answer1,
    this.question2,
    this.answer2,
    this.pin,
    this.otp,
    this.tNcs,
  });

  factory AccountDetails.fromJson(String str) =>
      AccountDetails.fromMap(json.decode(str) as Map<String, dynamic>);

  factory AccountDetails.fromMap(Map<String, dynamic> json) => AccountDetails(
        accountType: json['accountType'] as String,
        kycLevel: json['kycLevel'] as String,
        phoneNumber: json['phoneNumber'] as String,
        accountNumber: json['accountNumber'] as String,
        firstName: json['firstName'] as String,
        surname: json['surname'] as String,
        name: json['name'] as String,
        dateOfBirth: DateTime.parse(json['dateOfBirth'] as String),
        idType: json['idType'] as String,
        idNumber: json['idNumber'] as String,
        title: json['title'] as String,
        email: json['email'] as String,
        assistedByAgentCode: json['assistedByAgentCode'] as String,
        motherMaidenName: json['motherMaidenName'] as String,
        question1: json['question1'] as String,
        answer1: json['answer1'] as String,
        question2: json['question2'] as String,
        answer2: json['answer2'] as String,
        pin: json['pin'] as String,
        otp: json['otp'] as String,
        tNcs: json['termsAndConditions'] as String,
      );
  String accountType;
  String kycLevel;
  String phoneNumber;
  String accountNumber;
  String firstName;
  String surname;
  String name;
  DateTime dateOfBirth;
  String idType;
  String idNumber;
  String title;
  String email;
  String assistedByAgentCode;
  String motherMaidenName;
  String question1;
  String answer1;
  String question2;
  String answer2;
  String pin;
  String otp;
  String tNcs;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'accountType': accountType,
        'kycLevel': kycLevel,
        'phoneNumber': phoneNumber,
        'accountNumber': accountNumber,
        'firstName': firstName,
        'surname': surname,
        'name': name,
        'dateOfBirth': dateOfBirth.toIso8601String(),
        'idType': idType,
        'idNumber': idNumber,
        'title': title,
        'email': email,
        'assistedByAgentCode': assistedByAgentCode,
        'motherMaidenName': motherMaidenName,
        'question1': question1,
        'answer1': answer1,
        'question2': question2,
        'answer2': answer2,
        'pin': pin,
        'otp': otp,
        'tNcs': tNcs,
      };
}

// class AccountDetails {
//   AccountDetails({
//     this.name,
//     this.accountType,
//     this.kycLevel,
//     this.phoneNumber,
//     this.accountNumber,
//     this.pin,
//     this.otp,
//   });
//   factory AccountDetails.fromJson(String str) =>
//       AccountDetails.fromMap(json.decode(str) as Map<String, dynamic>);
//
//   factory AccountDetails.fromMap(Map<String, dynamic> json) => AccountDetails(
//         name: json['name'] as String,
//         accountType: json['accountType'] as String,
//         kycLevel: json['kycLevel'] as String,
//         phoneNumber: json['phoneNumber'] as String,
//         accountNumber: json['accountNumber'] as String,
//         pin: json['pin'] as String,
//         otp: json['otp'] as String,
//       );
//
//   String name;
//   String accountType;
//   String kycLevel;
//   String phoneNumber;
//   String accountNumber;
//   String pin;
//   String otp;
//
//   String toJson() => json.encode(toMap());
//
//   Map<String, dynamic> toMap() => <String, dynamic>{
//         'name': name,
//         'accountType': accountType,
//         'kycLevel': kycLevel,
//         'phoneNumber': phoneNumber,
//         'accountNumber': accountNumber,
//         'pin': pin,
//         'otp': otp,
//       };
// }

class AccountInDB {
  AccountInDB({
    this.token,
    this.tokenExpiry,
    this.name,
    this.accountType,
    this.kycLevel,
    this.phoneNumber,
    this.accountNumber,
  });

  factory AccountInDB.fromJson(String str) =>
      AccountInDB.fromMap(json.decode(str) as Map<String, String>);

  factory AccountInDB.fromMap(Map<String, dynamic> json) => AccountInDB(
        token: json['token'] as String,
        tokenExpiry: DateTime.parse(json['tokenExpiry'] as String),
        name: json['name'] as String,
        accountType: json['accountType'] as String,
        kycLevel: json['kycLevel'] as String,
        phoneNumber: json['phoneNumber'] as String,
        accountNumber: json['accountNumber'] as String,
      );

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'token': token,
        'tokenExpiry': tokenExpiry.toIso8601String(),
        'name': name,
        'accountType': accountType,
        'kycLevel': kycLevel,
        'phoneNumber': phoneNumber,
        'accountNumber': accountNumber,
      };

  String token;
  DateTime tokenExpiry;
  String name;
  String accountType;
  String kycLevel;
  String phoneNumber;
  String accountNumber;
}

class CheckLinkAccountModel {
  CheckLinkAccountModel({
    this.phoneNumber,
    this.accountNumber,
  });

  factory CheckLinkAccountModel.fromJson(String str) =>
      CheckLinkAccountModel.fromMap(json.decode(str) as Map<String, String>);

  factory CheckLinkAccountModel.fromMap(Map<String, String> json) =>
      CheckLinkAccountModel(
        phoneNumber: json['phoneNumber'],
        accountNumber: json['accountNumber'],
      );

  String toJson() => json.encode(toMap());

  Map<String, String> toMap() => <String, String>{
        'phoneNumber': phoneNumber,
        'accountNumber': accountNumber,
      };

  String phoneNumber;
  String accountNumber;
}

class ValidatePinModel {
  ValidatePinModel({
    this.otp,
    this.pin,
  });

  factory ValidatePinModel.fromJson(String str) =>
      ValidatePinModel.fromMap(json.decode(str) as Map<String, String>);

  factory ValidatePinModel.fromMap(Map<String, String> json) =>
      ValidatePinModel(
        otp: json['otp'],
        pin: json['pin'],
      );

  String toJson() => json.encode(toMap());

  Map<String, String> toMap() => <String, String>{
        'otp': otp,
        'pin': pin,
      };

  String otp;
  String pin;
}
