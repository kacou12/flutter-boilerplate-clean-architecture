import 'package:equatable/equatable.dart';

class RequestLogin extends Equatable {
  final String userName;
  final String password;

  const RequestLogin({required this.userName, required this.password});

  Map<String, dynamic> toJson() =>
      {'user_name': userName, 'password': password};

  @override
  List<Object?> get props => [userName, password];
}

class RequestRegister extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;

  const RequestRegister({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
  });

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'password': password,
        'email': email,
        'phone': phone,
      };

  @override
  List<Object?> get props => [
        password,
        email,
        phone,
        firstName,
        lastName,
      ];
}
