import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meyirim/controller/app_controller.dart';
import 'dart:core';
import 'package:meyirim/core/config.dart' as config;
import 'package:directus/directus.dart';
import 'package:meyirim/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:device_info/device_info.dart';

import '../ui.dart';

final sdk = Get.find<Directus>();
final preferences = Get.find<SharedPreferences>();
final appController = Get.find<AppController>();

Future<void> logout() async {
  Get.snackbar('Сообщение системы'.tr, 'Вы вышли из системы'.tr,
      duration: Duration(seconds: 4),
      backgroundColor: UIColor.green,
      colorText: Colors.white);

  if (appController.isLogged.isTrue) {
    for (String key in preferences.getKeys()) {
      if (key.startsWith('directus')) {
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
  String userCode;
  print(appController.isLogged.isTrue);
  if (appController.isLogged.isTrue) {
    try {
      final response = await sdk.client.get(config.API_URL + "/users/me");

      print(response);
      userCode = response.data['data']['user_code'];
      print(userCode);
      final result = await sdk.items('install_codes').readOne(userCode);
      print(result.data);
      sdk.client.options.headers['device-code'] = userCode;
      print('Это из базы: $userCode');
      if (userCode != null && userCode.isNotEmpty) {
        print('Used logged user_code: $userCode');
        return userCode;
      }
    } catch (e) {
      userCode = '';
      print(DirectusError.fromDio(e).message);
    }
  }
  userCode = preferences.getString('user_code');

  if (userCode != null && userCode.isNotEmpty) {
    try {
      final result = await sdk.items('install_codes').readOne(userCode);
      print(result.data);
      print('Used storage user_code: $userCode');
      sdk.client.options.headers['device-code'] = userCode;
      if (appController.isLogged.isTrue) {
        try {
          await sdk.client
              .patch('users/me', data: json.encode({'user_code': userCode}));
        } catch (e) {
          print(DirectusError.fromDio(e).message);
        }
      }
      print(userCode);
      return userCode;
    } catch (e) {
      userCode = '';
      print(DirectusError.fromDio(e).message);
    }
  }
  try {
    //@Todo Изменить платформу в IOS
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    final result = await sdk
        .items('install_codes')
        .createOne({'device_info': androidInfo.model});
    userCode = result.data['id'];
    preferences.setString('user_code', userCode);
    print('Used new user_code: $userCode');
    sdk.client.options.headers['device-code'] = userCode;
  } catch (e) {
    print(DirectusError.fromDio(e).message);
  }
  return userCode;
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
