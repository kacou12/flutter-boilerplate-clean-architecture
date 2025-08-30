import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    @JsonKey(name: 'id') required String id,
    @JsonKey(name: 'created_at') required String createdAt,
    @JsonKey(name: 'updated_at') required String updatedAt,
    @JsonKey(name: 'email') required String email,
    @JsonKey(name: 'first_name') required String firstName,
    @JsonKey(name: 'last_name') required String lastName,
    @JsonKey(name: 'phone') required String phone,
    @JsonKey(name: 'role') required String role,
    @JsonKey(name: 'is_verified') required bool? isVerified,
    @JsonKey(name: 'is_active') required bool? isActive,
    @JsonKey(name: 'last_login_at') required String lastLoginAt,
    @JsonKey(name: 'merchant_id') required String merchantId,
    @JsonKey(name: 'refresh_token') String? refreshToken,
    String? token,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
