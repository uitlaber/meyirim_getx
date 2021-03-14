import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/core/service/auth.dart' as auth;
import 'package:meyirim/controller/app_controller.dart';

class LoginController extends GetxController {
  RxBool isLoading = false.obs;
  GlobalKey<FormState> form = GlobalKey<FormState>();
  _LoginData data = new _LoginData();
  AppController appController = Get.find<AppController>();

  final emailValidate = ValidationBuilder()
      .email('Введите E-mail'.tr)
      .maxLength(50, 'Неправильный E-mail'.tr)
      .build();

  final passwordValidate = ValidationBuilder()
      .required('Введите пароль'.tr)
      .minLength(6, 'Введите пароль минимум 6 символов'.tr)
      .build();

  Future<void> login() async {
    if (form.currentState.validate() && isLoading.isFalse) {
      isLoading.value = true;
      form.currentState.save();
      await auth.login(data.email, data.password).then((value) async {
        await appController.userInfo();
        appController.isLogged.value = appController.checkAuth();
        Get.back();
      }).catchError((e) {
        isLoading.value = false;
        switch (e.message) {
          case 'Invalid user credentials.':
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
}

class ResetController extends GetxController {
  RxBool isLoading = false.obs;
  GlobalKey<FormState> form = GlobalKey<FormState>();
}
