import 'dart:convert';

import 'package:equatable/equatable.dart';

class ValidField extends Equatable {
  final String? message;

  ValidField({this.message});

  @override
  List<Object?> get props => [];

  @override
  bool get stringify => true;

  factory ValidField.fromJson(Map<String, dynamic> jsonData) {
    final String message = jsonData['message'] ?? jsonData['text'];
    return ValidField(message: message);
  }
}

class ValidFieldModel extends ValidField {}

extension ValidFieldFutureExtension<T extends String> on Future<T> {
  Future<ValidField> parseValidField() async {
    return this.then((data) async {
      try {
        final jsonData = jsonDecode(data) as Map<String, dynamic>;
        return ValidField.fromJson(jsonData);
      } catch (e) {
        return ValidField();
      }
    });
  }
}
