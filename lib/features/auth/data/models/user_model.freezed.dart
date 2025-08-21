// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserModel implements DiagnosticableTreeMixin {
  String get id;
  DateTime get createdAt;
  DateTime? get updatedAt;
  DateTime? get deletedAt;
  String get userName;
  String get name;
  String? get bio;
  String? get city;
  String get country;
  String? get image;
  String get phone;
  String? get cover;
  DateTime get birthdate;
  String get deviceId;
  String get deviceType;
  String get email;
  bool get online;
  bool get isPrivate;
  DateTime get lastOnline;
  String get sponsorshipCode;
  bool get sponsored;
  String get type;
  String? get firebaseToken;
  String get stripeId;
  String get stripeSellerId;
  String? get token;
  String? get refreshToken;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $UserModelCopyWith<UserModel> get copyWith =>
      _$UserModelCopyWithImpl<UserModel>(this as UserModel, _$identity);

  /// Serializes this UserModel to a JSON map.
  Map<String, dynamic> toJson();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'UserModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('deletedAt', deletedAt))
      ..add(DiagnosticsProperty('userName', userName))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('bio', bio))
      ..add(DiagnosticsProperty('city', city))
      ..add(DiagnosticsProperty('country', country))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('cover', cover))
      ..add(DiagnosticsProperty('birthdate', birthdate))
      ..add(DiagnosticsProperty('deviceId', deviceId))
      ..add(DiagnosticsProperty('deviceType', deviceType))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('online', online))
      ..add(DiagnosticsProperty('isPrivate', isPrivate))
      ..add(DiagnosticsProperty('lastOnline', lastOnline))
      ..add(DiagnosticsProperty('sponsorshipCode', sponsorshipCode))
      ..add(DiagnosticsProperty('sponsored', sponsored))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('firebaseToken', firebaseToken))
      ..add(DiagnosticsProperty('stripeId', stripeId))
      ..add(DiagnosticsProperty('stripeSellerId', stripeSellerId))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('refreshToken', refreshToken));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is UserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.lastOnline, lastOnline) ||
                other.lastOnline == lastOnline) &&
            (identical(other.sponsorshipCode, sponsorshipCode) ||
                other.sponsorshipCode == sponsorshipCode) &&
            (identical(other.sponsored, sponsored) ||
                other.sponsored == sponsored) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.firebaseToken, firebaseToken) ||
                other.firebaseToken == firebaseToken) &&
            (identical(other.stripeId, stripeId) ||
                other.stripeId == stripeId) &&
            (identical(other.stripeSellerId, stripeSellerId) ||
                other.stripeSellerId == stripeSellerId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        createdAt,
        updatedAt,
        deletedAt,
        userName,
        name,
        bio,
        city,
        country,
        image,
        phone,
        cover,
        birthdate,
        deviceId,
        deviceType,
        email,
        online,
        isPrivate,
        lastOnline,
        sponsorshipCode,
        sponsored,
        type,
        firebaseToken,
        stripeId,
        stripeSellerId,
        token,
        refreshToken
      ]);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, userName: $userName, name: $name, bio: $bio, city: $city, country: $country, image: $image, phone: $phone, cover: $cover, birthdate: $birthdate, deviceId: $deviceId, deviceType: $deviceType, email: $email, online: $online, isPrivate: $isPrivate, lastOnline: $lastOnline, sponsorshipCode: $sponsorshipCode, sponsored: $sponsored, type: $type, firebaseToken: $firebaseToken, stripeId: $stripeId, stripeSellerId: $stripeSellerId, token: $token, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class $UserModelCopyWith<$Res> {
  factory $UserModelCopyWith(UserModel value, $Res Function(UserModel) _then) =
      _$UserModelCopyWithImpl;
  @useResult
  $Res call(
      {String id,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      String userName,
      String name,
      String? bio,
      String? city,
      String country,
      String? image,
      String phone,
      String? cover,
      DateTime birthdate,
      String deviceId,
      String deviceType,
      String email,
      bool online,
      bool isPrivate,
      DateTime lastOnline,
      String sponsorshipCode,
      bool sponsored,
      String type,
      String? firebaseToken,
      String stripeId,
      String stripeSellerId,
      String? token,
      String? refreshToken});
}

/// @nodoc
class _$UserModelCopyWithImpl<$Res> implements $UserModelCopyWith<$Res> {
  _$UserModelCopyWithImpl(this._self, this._then);

  final UserModel _self;
  final $Res Function(UserModel) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? userName = null,
    Object? name = null,
    Object? bio = freezed,
    Object? city = freezed,
    Object? country = null,
    Object? image = freezed,
    Object? phone = null,
    Object? cover = freezed,
    Object? birthdate = null,
    Object? deviceId = null,
    Object? deviceType = null,
    Object? email = null,
    Object? online = null,
    Object? isPrivate = null,
    Object? lastOnline = null,
    Object? sponsorshipCode = null,
    Object? sponsored = null,
    Object? type = null,
    Object? firebaseToken = freezed,
    Object? stripeId = null,
    Object? stripeSellerId = null,
    Object? token = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_self.copyWith(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: null == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      cover: freezed == cover
          ? _self.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: null == birthdate
          ? _self.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deviceId: null == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceType: null == deviceType
          ? _self.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      online: null == online
          ? _self.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrivate: null == isPrivate
          ? _self.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      lastOnline: null == lastOnline
          ? _self.lastOnline
          : lastOnline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sponsorshipCode: null == sponsorshipCode
          ? _self.sponsorshipCode
          : sponsorshipCode // ignore: cast_nullable_to_non_nullable
              as String,
      sponsored: null == sponsored
          ? _self.sponsored
          : sponsored // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      firebaseToken: freezed == firebaseToken
          ? _self.firebaseToken
          : firebaseToken // ignore: cast_nullable_to_non_nullable
              as String?,
      stripeId: null == stripeId
          ? _self.stripeId
          : stripeId // ignore: cast_nullable_to_non_nullable
              as String,
      stripeSellerId: null == stripeSellerId
          ? _self.stripeSellerId
          : stripeSellerId // ignore: cast_nullable_to_non_nullable
              as String,
      token: freezed == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// Adds pattern-matching-related methods to [UserModel].
extension UserModelPatterns on UserModel {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_UserModel value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserModel() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_UserModel value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserModel():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_UserModel value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserModel() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            String id,
            DateTime createdAt,
            DateTime? updatedAt,
            DateTime? deletedAt,
            String userName,
            String name,
            String? bio,
            String? city,
            String country,
            String? image,
            String phone,
            String? cover,
            DateTime birthdate,
            String deviceId,
            String deviceType,
            String email,
            bool online,
            bool isPrivate,
            DateTime lastOnline,
            String sponsorshipCode,
            bool sponsored,
            String type,
            String? firebaseToken,
            String stripeId,
            String stripeSellerId,
            String? token,
            String? refreshToken)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _UserModel() when $default != null:
        return $default(
            _that.id,
            _that.createdAt,
            _that.updatedAt,
            _that.deletedAt,
            _that.userName,
            _that.name,
            _that.bio,
            _that.city,
            _that.country,
            _that.image,
            _that.phone,
            _that.cover,
            _that.birthdate,
            _that.deviceId,
            _that.deviceType,
            _that.email,
            _that.online,
            _that.isPrivate,
            _that.lastOnline,
            _that.sponsorshipCode,
            _that.sponsored,
            _that.type,
            _that.firebaseToken,
            _that.stripeId,
            _that.stripeSellerId,
            _that.token,
            _that.refreshToken);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            String id,
            DateTime createdAt,
            DateTime? updatedAt,
            DateTime? deletedAt,
            String userName,
            String name,
            String? bio,
            String? city,
            String country,
            String? image,
            String phone,
            String? cover,
            DateTime birthdate,
            String deviceId,
            String deviceType,
            String email,
            bool online,
            bool isPrivate,
            DateTime lastOnline,
            String sponsorshipCode,
            bool sponsored,
            String type,
            String? firebaseToken,
            String stripeId,
            String stripeSellerId,
            String? token,
            String? refreshToken)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserModel():
        return $default(
            _that.id,
            _that.createdAt,
            _that.updatedAt,
            _that.deletedAt,
            _that.userName,
            _that.name,
            _that.bio,
            _that.city,
            _that.country,
            _that.image,
            _that.phone,
            _that.cover,
            _that.birthdate,
            _that.deviceId,
            _that.deviceType,
            _that.email,
            _that.online,
            _that.isPrivate,
            _that.lastOnline,
            _that.sponsorshipCode,
            _that.sponsored,
            _that.type,
            _that.firebaseToken,
            _that.stripeId,
            _that.stripeSellerId,
            _that.token,
            _that.refreshToken);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            String id,
            DateTime createdAt,
            DateTime? updatedAt,
            DateTime? deletedAt,
            String userName,
            String name,
            String? bio,
            String? city,
            String country,
            String? image,
            String phone,
            String? cover,
            DateTime birthdate,
            String deviceId,
            String deviceType,
            String email,
            bool online,
            bool isPrivate,
            DateTime lastOnline,
            String sponsorshipCode,
            bool sponsored,
            String type,
            String? firebaseToken,
            String stripeId,
            String stripeSellerId,
            String? token,
            String? refreshToken)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _UserModel() when $default != null:
        return $default(
            _that.id,
            _that.createdAt,
            _that.updatedAt,
            _that.deletedAt,
            _that.userName,
            _that.name,
            _that.bio,
            _that.city,
            _that.country,
            _that.image,
            _that.phone,
            _that.cover,
            _that.birthdate,
            _that.deviceId,
            _that.deviceType,
            _that.email,
            _that.online,
            _that.isPrivate,
            _that.lastOnline,
            _that.sponsorshipCode,
            _that.sponsored,
            _that.type,
            _that.firebaseToken,
            _that.stripeId,
            _that.stripeSellerId,
            _that.token,
            _that.refreshToken);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _UserModel with DiagnosticableTreeMixin implements UserModel {
  const _UserModel(
      {required this.id,
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
      this.refreshToken});
  factory _UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  @override
  final String id;
  @override
  final DateTime createdAt;
  @override
  final DateTime? updatedAt;
  @override
  final DateTime? deletedAt;
  @override
  final String userName;
  @override
  final String name;
  @override
  final String? bio;
  @override
  final String? city;
  @override
  final String country;
  @override
  final String? image;
  @override
  final String phone;
  @override
  final String? cover;
  @override
  final DateTime birthdate;
  @override
  final String deviceId;
  @override
  final String deviceType;
  @override
  final String email;
  @override
  final bool online;
  @override
  final bool isPrivate;
  @override
  final DateTime lastOnline;
  @override
  final String sponsorshipCode;
  @override
  final bool sponsored;
  @override
  final String type;
  @override
  final String? firebaseToken;
  @override
  final String stripeId;
  @override
  final String stripeSellerId;
  @override
  final String? token;
  @override
  final String? refreshToken;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$UserModelCopyWith<_UserModel> get copyWith =>
      __$UserModelCopyWithImpl<_UserModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$UserModelToJson(
      this,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    properties
      ..add(DiagnosticsProperty('type', 'UserModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('updatedAt', updatedAt))
      ..add(DiagnosticsProperty('deletedAt', deletedAt))
      ..add(DiagnosticsProperty('userName', userName))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('bio', bio))
      ..add(DiagnosticsProperty('city', city))
      ..add(DiagnosticsProperty('country', country))
      ..add(DiagnosticsProperty('image', image))
      ..add(DiagnosticsProperty('phone', phone))
      ..add(DiagnosticsProperty('cover', cover))
      ..add(DiagnosticsProperty('birthdate', birthdate))
      ..add(DiagnosticsProperty('deviceId', deviceId))
      ..add(DiagnosticsProperty('deviceType', deviceType))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('online', online))
      ..add(DiagnosticsProperty('isPrivate', isPrivate))
      ..add(DiagnosticsProperty('lastOnline', lastOnline))
      ..add(DiagnosticsProperty('sponsorshipCode', sponsorshipCode))
      ..add(DiagnosticsProperty('sponsored', sponsored))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('firebaseToken', firebaseToken))
      ..add(DiagnosticsProperty('stripeId', stripeId))
      ..add(DiagnosticsProperty('stripeSellerId', stripeSellerId))
      ..add(DiagnosticsProperty('token', token))
      ..add(DiagnosticsProperty('refreshToken', refreshToken));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _UserModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.deletedAt, deletedAt) ||
                other.deletedAt == deletedAt) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.image, image) || other.image == image) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.cover, cover) || other.cover == cover) &&
            (identical(other.birthdate, birthdate) ||
                other.birthdate == birthdate) &&
            (identical(other.deviceId, deviceId) ||
                other.deviceId == deviceId) &&
            (identical(other.deviceType, deviceType) ||
                other.deviceType == deviceType) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.online, online) || other.online == online) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.lastOnline, lastOnline) ||
                other.lastOnline == lastOnline) &&
            (identical(other.sponsorshipCode, sponsorshipCode) ||
                other.sponsorshipCode == sponsorshipCode) &&
            (identical(other.sponsored, sponsored) ||
                other.sponsored == sponsored) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.firebaseToken, firebaseToken) ||
                other.firebaseToken == firebaseToken) &&
            (identical(other.stripeId, stripeId) ||
                other.stripeId == stripeId) &&
            (identical(other.stripeSellerId, stripeSellerId) ||
                other.stripeSellerId == stripeSellerId) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.refreshToken, refreshToken) ||
                other.refreshToken == refreshToken));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        createdAt,
        updatedAt,
        deletedAt,
        userName,
        name,
        bio,
        city,
        country,
        image,
        phone,
        cover,
        birthdate,
        deviceId,
        deviceType,
        email,
        online,
        isPrivate,
        lastOnline,
        sponsorshipCode,
        sponsored,
        type,
        firebaseToken,
        stripeId,
        stripeSellerId,
        token,
        refreshToken
      ]);

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'UserModel(id: $id, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, userName: $userName, name: $name, bio: $bio, city: $city, country: $country, image: $image, phone: $phone, cover: $cover, birthdate: $birthdate, deviceId: $deviceId, deviceType: $deviceType, email: $email, online: $online, isPrivate: $isPrivate, lastOnline: $lastOnline, sponsorshipCode: $sponsorshipCode, sponsored: $sponsored, type: $type, firebaseToken: $firebaseToken, stripeId: $stripeId, stripeSellerId: $stripeSellerId, token: $token, refreshToken: $refreshToken)';
  }
}

/// @nodoc
abstract mixin class _$UserModelCopyWith<$Res>
    implements $UserModelCopyWith<$Res> {
  factory _$UserModelCopyWith(
          _UserModel value, $Res Function(_UserModel) _then) =
      __$UserModelCopyWithImpl;
  @override
  @useResult
  $Res call(
      {String id,
      DateTime createdAt,
      DateTime? updatedAt,
      DateTime? deletedAt,
      String userName,
      String name,
      String? bio,
      String? city,
      String country,
      String? image,
      String phone,
      String? cover,
      DateTime birthdate,
      String deviceId,
      String deviceType,
      String email,
      bool online,
      bool isPrivate,
      DateTime lastOnline,
      String sponsorshipCode,
      bool sponsored,
      String type,
      String? firebaseToken,
      String stripeId,
      String stripeSellerId,
      String? token,
      String? refreshToken});
}

/// @nodoc
class __$UserModelCopyWithImpl<$Res> implements _$UserModelCopyWith<$Res> {
  __$UserModelCopyWithImpl(this._self, this._then);

  final _UserModel _self;
  final $Res Function(_UserModel) _then;

  /// Create a copy of UserModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? id = null,
    Object? createdAt = null,
    Object? updatedAt = freezed,
    Object? deletedAt = freezed,
    Object? userName = null,
    Object? name = null,
    Object? bio = freezed,
    Object? city = freezed,
    Object? country = null,
    Object? image = freezed,
    Object? phone = null,
    Object? cover = freezed,
    Object? birthdate = null,
    Object? deviceId = null,
    Object? deviceType = null,
    Object? email = null,
    Object? online = null,
    Object? isPrivate = null,
    Object? lastOnline = null,
    Object? sponsorshipCode = null,
    Object? sponsored = null,
    Object? type = null,
    Object? firebaseToken = freezed,
    Object? stripeId = null,
    Object? stripeSellerId = null,
    Object? token = freezed,
    Object? refreshToken = freezed,
  }) {
    return _then(_UserModel(
      id: null == id
          ? _self.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _self.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: freezed == updatedAt
          ? _self.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      deletedAt: freezed == deletedAt
          ? _self.deletedAt
          : deletedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      userName: null == userName
          ? _self.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _self.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      bio: freezed == bio
          ? _self.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      city: freezed == city
          ? _self.city
          : city // ignore: cast_nullable_to_non_nullable
              as String?,
      country: null == country
          ? _self.country
          : country // ignore: cast_nullable_to_non_nullable
              as String,
      image: freezed == image
          ? _self.image
          : image // ignore: cast_nullable_to_non_nullable
              as String?,
      phone: null == phone
          ? _self.phone
          : phone // ignore: cast_nullable_to_non_nullable
              as String,
      cover: freezed == cover
          ? _self.cover
          : cover // ignore: cast_nullable_to_non_nullable
              as String?,
      birthdate: null == birthdate
          ? _self.birthdate
          : birthdate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      deviceId: null == deviceId
          ? _self.deviceId
          : deviceId // ignore: cast_nullable_to_non_nullable
              as String,
      deviceType: null == deviceType
          ? _self.deviceType
          : deviceType // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _self.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      online: null == online
          ? _self.online
          : online // ignore: cast_nullable_to_non_nullable
              as bool,
      isPrivate: null == isPrivate
          ? _self.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool,
      lastOnline: null == lastOnline
          ? _self.lastOnline
          : lastOnline // ignore: cast_nullable_to_non_nullable
              as DateTime,
      sponsorshipCode: null == sponsorshipCode
          ? _self.sponsorshipCode
          : sponsorshipCode // ignore: cast_nullable_to_non_nullable
              as String,
      sponsored: null == sponsored
          ? _self.sponsored
          : sponsored // ignore: cast_nullable_to_non_nullable
              as bool,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      firebaseToken: freezed == firebaseToken
          ? _self.firebaseToken
          : firebaseToken // ignore: cast_nullable_to_non_nullable
              as String?,
      stripeId: null == stripeId
          ? _self.stripeId
          : stripeId // ignore: cast_nullable_to_non_nullable
              as String,
      stripeSellerId: null == stripeSellerId
          ? _self.stripeSellerId
          : stripeSellerId // ignore: cast_nullable_to_non_nullable
              as String,
      token: freezed == token
          ? _self.token
          : token // ignore: cast_nullable_to_non_nullable
              as String?,
      refreshToken: freezed == refreshToken
          ? _self.refreshToken
          : refreshToken // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

// dart format on
