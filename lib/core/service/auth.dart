import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meyirim/controller/app_controller.dart';
import 'dart:core';
import 'package:meyirim/core/config.dart' as config;
import 'package:directus/directus.dart';
import 'package:meyirim/models/user.dart';
import 'dart:io';
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
  if (appController.isLogged.isTrue) {
    try {
      final response = await sdk.client.get(config.API_URL + "/users/me");
      userCode = response.data['data']['user_code'];
      final result = await sdk.items('install_codes').readOne(userCode);
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

    var model = '';
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if (Platform.isAndroid) {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      model = androidInfo.model;
    } else if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      model = iosInfo.model;
    }

    final result =
        await sdk.items('install_codes').createOne({'device_info': model});
    userCode = result.data['id'];
    preferences.setString('user_code', userCode);
    print('Used new user_code: $userCode');
    sdk.client.options.headers['device-code'] = userCode;
  } catch (e) {
    print(DirectusError.fromDio(e).message);
  }
  return userCode;
}

Future<void> updatePushToken(token) async {
  final user_code = await userCode();
  await sdk
      .items('install_codes')
      .updateOne(data: {'token': token}, id: user_code.toString());
}

Future<void> setReferalCode(String code) async {
  if (await referalCode() != null) return;
  preferences.setString('referal_code', code);
  print('REFERAL_CODE set' + code);
}

/// Уникальный код пригласителя пользователя
Future<String> referalCode() async {
  return preferences.getString('referal_code');
}
