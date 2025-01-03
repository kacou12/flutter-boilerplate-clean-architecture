import 'package:my/core/errors/exceptions.dart';
import 'package:my/core/services/hive/main_box.dart';
import 'package:my/features/auth/data/models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel?> loadData();
  Future<void> saveData(UserModel value);
  Future<void> deleteData();
}

const cacheUser = 'cached_user';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl();

  @override
  Future<void> saveData(UserModel value) async {
    final local = MainBoxStorage<UserModel>(
      fromJson: UserModel.fromJson,
      toJson: (data) => data.toJson(),
    );

    try {
      await local.saveMapData(data: value, key: cacheUser);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> loadData() async {
    final local = MainBoxStorage<UserModel>(
      fromJson: UserModel.fromJson,
      toJson: (data) => data.toJson(),
    );

    try {
      return (await local.loadMapData(cacheUser))!;
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> deleteData() async {
    final local = MainBoxStorage<UserModel>(
      fromJson: UserModel.fromJson,
      toJson: (data) => data.toJson(),
    );
    await local.clearData(cacheUser);
  }
}
