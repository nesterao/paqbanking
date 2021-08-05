import 'dart:convert';

class FormContent {
  List<IdType> idTypes;
  List<String> titles;
  List<Question> questions;
}

class Question {
  Question({
    this.text,
    this.answerType,
  });

  factory Question.fromJson(String str) =>
      Question.fromMap(json.decode(str) as Map<String, dynamic>);

  factory Question.fromMap(Map<String, dynamic> json) => Question(
        text: json['text'] as String,
        answerType: json['answerType'] as String,
      );

  String text;
  String answerType;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'text': text,
        'answerType': answerType,
      };
}

class IdType {
  IdType({
    this.name,
    this.canValidate,
  });

  factory IdType.fromJson(String str) =>
      IdType.fromMap(json.decode(str) as Map<String, dynamic>);

  factory IdType.fromMap(Map<String, dynamic> json) => IdType(
        name: json['name'] as String,
        canValidate: json['canValidate'] as bool,
      );

  String name;
  bool canValidate;

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() => <String, dynamic>{
        'name': name,
        'canValidate': canValidate,
      };
}
