// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserModel _$UserModelFromJson(Map<String, dynamic> json) => _UserModel(
  id: json['id'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  deletedAt: json['deletedAt'] == null
      ? null
      : DateTime.parse(json['deletedAt'] as String),
  userName: json['userName'] as String,
  name: json['name'] as String,
  bio: json['bio'] as String?,
  city: json['city'] as String?,
  country: json['country'] as String,
  image: json['image'] as String?,
  phone: json['phone'] as String,
  cover: json['cover'] as String?,
  birthdate: DateTime.parse(json['birthdate'] as String),
  deviceId: json['deviceId'] as String,
  deviceType: json['deviceType'] as String,
  email: json['email'] as String,
  online: json['online'] as bool,
  isPrivate: json['isPrivate'] as bool,
  lastOnline: DateTime.parse(json['lastOnline'] as String),
  sponsorshipCode: json['sponsorshipCode'] as String,
  sponsored: json['sponsored'] as bool,
  type: json['type'] as String,
  firebaseToken: json['firebaseToken'] as String?,
  stripeId: json['stripeId'] as String,
  stripeSellerId: json['stripeSellerId'] as String,
  token: json['token'] as String?,
  refreshToken: json['refreshToken'] as String?,
);

Map<String, dynamic> _$UserModelToJson(_UserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'deletedAt': instance.deletedAt?.toIso8601String(),
      'userName': instance.userName,
      'name': instance.name,
      'bio': instance.bio,
      'city': instance.city,
      'country': instance.country,
      'image': instance.image,
      'phone': instance.phone,
      'cover': instance.cover,
      'birthdate': instance.birthdate.toIso8601String(),
      'deviceId': instance.deviceId,
      'deviceType': instance.deviceType,
      'email': instance.email,
      'online': instance.online,
      'isPrivate': instance.isPrivate,
      'lastOnline': instance.lastOnline.toIso8601String(),
      'sponsorshipCode': instance.sponsorshipCode,
      'sponsored': instance.sponsored,
      'type': instance.type,
      'firebaseToken': instance.firebaseToken,
      'stripeId': instance.stripeId,
      'stripeSellerId': instance.stripeSellerId,
      'token': instance.token,
      'refreshToken': instance.refreshToken,
    };
