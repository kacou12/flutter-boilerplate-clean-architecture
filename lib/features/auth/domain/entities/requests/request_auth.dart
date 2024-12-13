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
  final String userName;
  final String name;
  final String email;
  final String password;
  final String sponsor;
  final String country;
  final String city;
  final String phone;
  final String deviceId;
  final String deviceType;

  const RequestRegister({
    required this.userName,
    required this.name,
    required this.email,
    required this.password,
    required this.sponsor,
    required this.country,
    required this.city,
    required this.phone,
    required this.deviceId,
    required this.deviceType,
  });

  Map<String, dynamic> toJson() => {
        'user_name': userName,
        'password': password,
        'email': email,
        'name': name,
        'sponsor': sponsor,
        'country': country,
        'city': city,
        'phone': phone,
        'device_id': deviceId,
        'device_type': deviceType
      };

  @override
  List<Object?> get props => [
        userName,
        password,
        email,
        name,
        sponsor,
        country,
        city,
        phone,
        deviceId,
        deviceType
      ];
}
