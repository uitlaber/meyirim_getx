import 'package:get/get.dart';
import 'dart:core';
import 'package:directus/directus.dart';
import 'package:meyirim/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

final sdk = Get.find<Directus>();

Future<void> logout() async {
  if (isLoggedIn()) {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    for (String key in preferences.getKeys()) {
      if (key.startsWith('directus__')) {
        preferences.remove(key);
      }
    }

    await sdk.auth.logout();
  }
}

Future<void> login(String email, String password) async {
  await sdk.auth.login(email: email, password: password);
}

Future<DirectusResponse<DirectusUser>> register(data) async {
  final createdUser = sdk.users.createOne(User.fromJson(data));
  return createdUser;
}

bool isLoggedIn() {
  bool result = sdk.auth.isLoggedIn;
  return result;
}

Future<User> userInfo() async {
  DirectusResponse user = (await sdk.auth.currentUser?.read());
  return User.fromJson(user.data);
}

/// Уникальный код пользователя
Future<String> userCode() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //@Todo Изменить платформу в IOS
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  return androidInfo.androidId;
}

Future<void> setReferalCode(String code) async {
  if (await referalCode() != null) return;
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString('referal_code', code);
}

/// Уникальный код пригласителя пользователя
Future<String> referalCode() async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  return preferences.get('referal_code');
}
