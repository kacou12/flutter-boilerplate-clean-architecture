import 'package:equatable/equatable.dart';

class RequestParamsLoginPayload extends Equatable {
  const RequestParamsLoginPayload({
    required this.email,
    required this.password,
  });
  final String email;
  final String password;

  @override
  List<Object> get props => [email, password];
}
