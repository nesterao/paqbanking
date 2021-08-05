import 'dart:convert';

class SecurityDto {
  SecurityDto({
    this.accountType,
    this.firstName,
    this.surname,
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
  });

  factory SecurityDto.fromJson(String str) =>
      SecurityDto.fromMap(json.decode(str) as Map<String, dynamic>);

  factory SecurityDto.fromMap(Map<String, dynamic> json) => SecurityDto(
        accountType: json['accountType'] as String,
        firstName: json['firstName'] as String,
        surname: json['surname'] as String,
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
      );

  String accountType;
  String firstName;
  String surname;
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

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => {
        'accountType': accountType,
        'firstName': firstName,
        'surname': surname,
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
      };
}
