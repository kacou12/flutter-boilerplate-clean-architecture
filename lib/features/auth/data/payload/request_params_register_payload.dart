import 'dart:convert';
import 'package:equatable/equatable.dart';

class RequestParamsRegisterPayload extends Equatable {
  const RequestParamsRegisterPayload({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
  });
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;

  @override
  List<Object> get props {
    return [
      firstName,
      lastName,
      email,
      password,
      phone,
    ];
  }

  RequestParamsRegisterPayload copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? phone,
  }) {
    return RequestParamsRegisterPayload(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      password: password ?? this.password,
      phone: phone ?? this.phone,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'firstName': firstName});
    result.addAll({'lastName': lastName});
    result.addAll({'email': email});
    result.addAll({'password': password});
    result.addAll({'phone': phone});

    return result;
  }

  factory RequestParamsRegisterPayload.fromMap(Map<String, dynamic> map) {
    return RequestParamsRegisterPayload(
      firstName: map['firstName'] ?? '',
      lastName: map['lastName'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      phone: map['phone'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestParamsRegisterPayload.fromJson(String source) =>
      RequestParamsRegisterPayload.fromMap(json.decode(source));

  @override
  String toString() {
    return 'RequestParamsRegisterPayload(firstName: $firstName, lastName: $lastName, email: $email, password: $password, phone: $phone)';
  }
}
