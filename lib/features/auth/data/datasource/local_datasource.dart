
// // ignore_for_file: constant_identifier_names

// import 'dart:convert';

// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:real_estaye_app/core/failures/excemption.dart';
// import 'package:real_estaye_app/features/auth/data/model/user.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// abstract class AuthLocalDataSource {
//   Future<UserModel> getCurrentUser();
//   Future<bool> logOut();
//   Future<void> saveUser(UserModel userToCache);
// }

// const _flutterSecureStorage = FlutterSecureStorage();
// const CACHED_USER = 'CACHED_USER';

// class AuthLocalDataSourceImpl implements AuthLocalDataSource {
//   final SharedPreferences sharedPreferences;
//   AuthLocalDataSourceImpl({
//     required this.sharedPreferences,
//   });

//   @override
//   Future<UserModel> getCurrentUser() {
//     final jsonString = sharedPreferences.getString(CACHED_USER);
//     if (jsonString != null) {
//       return Future.value(UserModel.fromJson(json.decode(jsonString)));
//     } else {
//       throw CacheException();
//     }
//   }

//   @override
//   Future<void> saveUser(UserModel userToCache) {
//     return sharedPreferences.setString(
//       CACHED_USER,
//       json.encode(userToCache.toJson()),
//     );
//   }



//   @override
//   Future<bool> logOut() async {
//     final isDone = sharedPreferences.remove(CACHED_USER);

// ignore_for_file: constant_identifier_names

//     return isDone;  }
// }
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:real_estaye_app/core/failures/excemption.dart';
import 'package:real_estaye_app/features/auth/data/model/user.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> getCurrentUser();
  Future<void> logOut();
  Future<void> saveUser(UserModel userToCache);
}

const _flutterSecureStorage = FlutterSecureStorage();
const CACHED_USER = 'CACHED_USER';

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<UserModel> getCurrentUser() async {
    final jsonString = await _flutterSecureStorage.read(key: CACHED_USER);
    if (jsonString != null) {
      return UserModel.fromJson(json.decode(jsonString));
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> saveUser(UserModel userToCache) async {
    await _flutterSecureStorage.write(
      key: CACHED_USER,
      value: json.encode(userToCache.toJson()),
    );
  }

  @override
  Future<void> logOut() async {
    final isDone = await _flutterSecureStorage.delete(key: CACHED_USER);
    return isDone;
  }
}
