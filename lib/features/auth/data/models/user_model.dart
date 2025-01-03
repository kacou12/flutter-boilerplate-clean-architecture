import 'package:my/features/auth/domain/entities/user.dart';

class UserModel extends User {
  const UserModel(
      {required super.id,
      required super.createdAt,
      super.updatedAt,
      super.deletedAt,
      required super.userName,
      required super.name,
      super.city,
      super.cover,
      required super.country,
      super.bio,
      super.image,
      required super.phone,
      required super.deviceId,
      required super.deviceType,
      required super.email,
      required super.online,
      required super.isPrivate,
      required super.lastOnline,
      required super.sponsorshipCode,
      required super.sponsored,
      required super.type,
      super.firebaseToken,
      required super.stripeId,
      required super.stripeSellerId,
      required super.birthdate,
      super.token,
      super.refreshToken});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
        id: map['id'],
        createdAt: map['created_at'],
        updatedAt: map['updated_at'],
        deletedAt: map['deleted_at'],
        userName: map['user_name'],
        name: map['name'],
        city: map['city'],
        bio: map['bio'],
        country: map['country'],
        image: map['image'] ?? "",
        cover: map['cover'] ?? "",
        phone: map['phone'],
        deviceId: map['device_id'],
        deviceType: map['device_type'],
        email: map['email'],
        online: map['online'],
        isPrivate: map['private'],
        lastOnline: map['last_online'],
        sponsorshipCode: map['sponsorship_code'],
        sponsored: map['sponsored'],
        type: map['type'],
        firebaseToken: map['firebase_token'],
        stripeId: map['stripe_id'],
        stripeSellerId: map['stripe_seller_id'],
        token: map['token'],
        refreshToken: map['refresh_token'],
        birthdate: map['birthdate']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'user_name': userName,
      'name': name,
      'city': city,
      'bio': bio,
      'country': country,
      'image': image,
      'cover': cover,
      'phone': phone,
      'device_id': deviceId,
      'device_type': deviceType,
      'email': email,
      'online': online,
      'private': isPrivate,
      'last_online': lastOnline,
      'sponsorship_code': sponsorshipCode,
      'sponsored': sponsored,
      'type': type,
      'firebase_token': firebaseToken,
      'stripe_id': stripeId,
      'stripe_seller_id': stripeSellerId,
      'birthdate': birthdate,
      'token': token,
      'refresh_token': refreshToken,
    };
  }

  UserModel copyWith(
      {int? id,
      String? createdAt,
      String? updatedAt,
      String? deletedAt,
      String? userName,
      String? name,
      String? city,
      String? bio,
      String? country,
      String? image,
      String? cover,
      String? phone,
      String? deviceId,
      String? deviceType,
      String? email,
      bool? online,
      bool? isPrivate,
      String? lastOnline,
      String? sponsorshipCode,
      int? sponsored,
      String? type,
      String? firebaseToken,
      String? stripeId,
      String? stripeSellerId,
      String? birthdate,
      String? token,
      String? refreshToken}) {
    return UserModel(
        id: id ?? this.id,
        createdAt: createdAt ?? this.createdAt,
        updatedAt: updatedAt ?? this.updatedAt,
        deletedAt: deletedAt ?? this.deletedAt,
        userName: userName ?? this.userName,
        name: name ?? this.name,
        city: city ?? this.city,
        bio: city ?? this.bio,
        country: country ?? this.country,
        image: image ?? this.image,
        cover: cover ?? this.cover,
        phone: phone ?? this.phone,
        deviceId: deviceId ?? this.deviceId,
        deviceType: deviceType ?? this.deviceType,
        email: email ?? this.email,
        online: online ?? this.online,
        isPrivate: isPrivate ?? this.isPrivate,
        lastOnline: lastOnline ?? this.lastOnline,
        sponsorshipCode: sponsorshipCode ?? this.sponsorshipCode,
        sponsored: sponsored ?? this.sponsored,
        type: type ?? this.type,
        firebaseToken: firebaseToken ?? this.firebaseToken,
        stripeId: stripeId ?? this.stripeId,
        stripeSellerId: stripeSellerId ?? this.stripeSellerId,
        birthdate: birthdate ?? this.birthdate,
        token: token ?? this.token,
        refreshToken: refreshToken ?? this.refreshToken);
  }
}
