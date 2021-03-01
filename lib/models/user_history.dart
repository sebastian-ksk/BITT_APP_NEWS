import 'package:flutter/material.dart';

//==================historial de ususario=======================================
class UserHistory {
  final int id;
  final String name;
  final int email;

  UserHistory({this.id, this.name, this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }

  @override
  String toString() {
    return 'Dog{id: $id, name: $name, age: $email}';
  }
}
