import 'dart:async';

import 'package:directus/directus.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/core/service/auth.dart' as auth;
import 'package:meyirim/controller/app_controller.dart';
import 'package:meyirim/core/ui.dart';
import 'package:meyirim/models/user.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  _LoginData data = new _LoginData();
  AppController appController = Get.find<AppController>();

  Future<void> login() async {
    if (form.currentState.validate() && isLoading.isFalse) {
      isLoading.value = true;
      form.currentState.save();
      await auth.login(data.email, data.password).then((value) async {
        await appController.userInfo();
        appController.isLogged.value = appController.checkAuth();
        isLoading.value = false;
        Get.back();
      }).catchError((e) {
        isLoading.value = false;
        switch (e.message) {
          case 'Invalid user credentials.':
            Get.snackbar('Ошибка'.tr, 'Введен неверный e-mail или пароль'.tr,
                backgroundColor: Colors.redAccent, colorText: Colors.white);
            break;
          case '"email" must be a valid email':
            Get.snackbar('Ошибка'.tr, 'Введен неверный e-mail или пароль'.tr,
                backgroundColor: Colors.redAccent, colorText: Colors.white);
            break;
          default:
            Get.snackbar('Ошибка'.tr, 'Ошибка при авторизации'.tr,
                backgroundColor: Colors.redAccent, colorText: Colors.white);
            break;
        }
      });
    }
  }
}

class _LoginData {
  String email;
  String password;

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  User data = new User();
  AppController appController = Get.find<AppController>();

  Future<void> register() async {
    if (form.currentState.validate() && isLoading.isFalse) {
      isLoading.value = true;
      form.currentState.save();
      try {
        data.userCode = await auth.userCode();
        await auth.register(data.toJson());
      } catch (e) {
        print('"${e.message}"');
        String errorMessage = '';
        switch (e.message) {
          case 'EMAIL_EXIST':
            errorMessage = 'E-mail уже зарегистрирован!';
            break;
          case 'PHONE_EXIST':
            errorMessage = 'Номер телефона уже зарегистрирован!';
            break;
          default:
            errorMessage = 'Ошибка при регистрации!';
            break;
        }
        Get.snackbar('Ошибка'.tr, errorMessage.tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
        isLoading.value = false;
        return;
      }
      await auth.login(data.email, data.password).then((value) async {
        await appController.userInfo();
        appController.isLogged.value = appController.checkAuth();
        isLoading.value = false;
        Get.back();
      }).catchError((e) {
        isLoading.value = false;
        print(e.message);
        switch (e.message) {
          case 'Invalid user credentials.':
            Get.snackbar('Ошибка'.tr, 'Введен неверный e-mail или пароль'.tr,
                backgroundColor: Colors.redAccent, colorText: Colors.white);
            break;
          case '"email" must be a valid email':
            Get.snackbar('Ошибка'.tr, 'Введен неверный e-mail или пароль'.tr,
                backgroundColor: Colors.redAccent, colorText: Colors.white);
            break;
          default:
            Get.snackbar('Ошибка'.tr, 'Ошибка при авторизации'.tr,
                backgroundColor: Colors.redAccent, colorText: Colors.white);
            break;
        }
      });
    }
  }
}

class ResetController extends GetxController {
  RxBool isLoading = false.obs;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  _ResetData data = new _ResetData();
  AppController appController = Get.find<AppController>();
  Directus sdk = Get.find<Directus>();

  Future<void> reset() async {
    if (form.currentState.validate() && isLoading.isFalse) {
      if (appController.lastReset != null) {
        var currentTime = DateTime.now().millisecondsSinceEpoch;
        var result = currentTime - appController.lastReset;

        if (result < 120000) {
          var n = ((120000 - result) / 1000).round();
          Get.snackbar(
              'Внимание'.tr,
              'Повторный сброс пароля через @second cек.'
                  .trParams({'second': n.toString()}),
              backgroundColor: Colors.redAccent,
              colorText: Colors.white);
          return;
        }
      }
      isLoading.value = true;
      form.currentState.save();
      try {
        Map<String, dynamic> sendData = {
          'phone': data.phone,
        };
        await sdk.client.post('/custom/user/reset', data: sendData);
        form.currentState?.reset();

        isLoading.value = false;

        appController.lastReset = DateTime.now().millisecondsSinceEpoch;
        Get.snackbar(
            'Сообщение системы'.tr, 'На ваш номер отправлен новый пароль'.tr,
            duration: Duration(seconds: 5),
            backgroundColor: UIColor.green,
            colorText: Colors.white);

        Timer(Duration(seconds: 5), () async {
          await Get.offNamed('/login');
        });
      } catch (e) {
        Get.snackbar('Ошибка'.tr, 'Номер не зарегистрирован.'.tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
        isLoading.value = false;
      }
    }
  }
}

class _ResetData {
  String phone;
  Map<String, dynamic> toJson() => {
        "phone": phone,
      };
}
