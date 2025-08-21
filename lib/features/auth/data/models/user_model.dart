import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required String id,
    required DateTime createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    required String userName,
    required String name,
    String? bio,
    String? city,
    required String country,
    String? image,
    required String phone,
    String? cover,
    required DateTime birthdate,
    required String deviceId,
    required String deviceType,
    required String email,
    required bool online,
    required bool isPrivate,
    required DateTime lastOnline,
    required String sponsorshipCode,
    required bool sponsored,
    required String type,
    String? firebaseToken,
    required String stripeId,
    required String stripeSellerId,
    String? token,
    String? refreshToken,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
