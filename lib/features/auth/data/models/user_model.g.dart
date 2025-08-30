// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
      id: json['id'] as String,
      createdAt: json['created_at'] as String,
      updatedAt: json['updated_at'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      phone: json['phone'] as String,
      role: json['role'] as String,
      isVerified: json['is_verified'] as bool?,
      isActive: json['is_active'] as bool?,
      lastLoginAt: json['last_login_at'] as String,
      merchantId: json['merchant_id'] as String,
      refreshToken: json['refresh_token'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'phone': instance.phone,
      'role': instance.role,
      'is_verified': instance.isVerified,
      'is_active': instance.isActive,
      'last_login_at': instance.lastLoginAt,
      'merchant_id': instance.merchantId,
      'refresh_token': instance.refreshToken,
      'token': instance.token,
    };
