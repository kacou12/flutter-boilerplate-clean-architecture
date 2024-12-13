import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final int id;
  final String createdAt;
  final String? updatedAt; // Added based on JSON
  final String? deletedAt; // Added based on JSON
  final String userName;
  final String name;
  final String? city; // Added based on JSON
  final String country;
  final String? image;
  final String phone;
  final String deviceId;
  final String? bio;
  final String deviceType;
  final String email;
  final bool online;
  final bool isPrivate;
  final String lastOnline;
  final String sponsorshipCode;
  final int sponsored;
  final String type;
  final String? cover;
  final String? firebaseToken;
  final String stripeId;
  final String stripeSellerId;

  final String? token;
  final String? refreshToken;
  final String birthdate;

  const User({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    this.deletedAt,
    required this.userName,
    required this.name,
    this.bio,
    this.city,
    required this.country,
    this.image,
    required this.phone,
    this.cover,
    required this.birthdate,
    required this.deviceId,
    required this.deviceType,
    required this.email,
    required this.online,
    required this.isPrivate,
    required this.lastOnline,
    required this.sponsorshipCode,
    required this.sponsored,
    required this.type,
    this.firebaseToken,
    required this.stripeId,
    required this.stripeSellerId,
    this.token,
    this.refreshToken,
  });

  @override
  List<Object?> get props => [
        id,
        createdAt,
        updatedAt,
        deletedAt,
        userName,
        name,
        city,
        country,
        image,
        phone,
        deviceId,
        deviceType,
        email,
        online,
        isPrivate,
        lastOnline,
        sponsorshipCode,
        sponsored,
        type,
        cover,
        firebaseToken,
        stripeId,
        stripeSellerId,
        bio,
        token,
        refreshToken,
        birthdate,
      ];
}
