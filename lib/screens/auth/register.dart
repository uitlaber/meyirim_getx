import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meyirim/core/ui.dart';
import 'package:get/get.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/screens/auth/controller/auth_controller.dart';

class RegisterScreen extends StatelessWidget {
  final controller = Get.find<RegisterController>();

  @override
  Widget build(BuildContext context) {
    var logoPath = 'assets/images/logo.svg';
    return Scaffold(
      backgroundColor: UIColor.blue,
      appBar: AppBar(
        leading: new Container(),
        elevation: 0,
        actions: [
          IconButton(
              icon: Icon(Icons.close, size: 32),
              color: Colors.white,
              onPressed: () => Get.back())
        ],
      ),
      body: SafeArea(
        child: Center(
          child: controller.isLoading.isTrue
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: SvgPicture.asset(
                      logoPath,
                      height: 70,
                    )),
                    SizedBox(height: 25),
                    CircularProgressIndicator(
                      valueColor:
                          new AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ],
                )
              : Padding(
                  padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                  child: Form(
                    key: controller.form,
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Center(
                              child: SvgPicture.asset(
                            logoPath,
                            height: 70,
                          )),
                          SizedBox(height: 35),
                          TextFormField(
                              decoration: uiInputDecoration(
                                  hintText: 'Введите ваш номер'.tr),
                              validator: Rules.phoneValidate,
                              inputFormatters: [Rules.phoneFormatter],
                              keyboardType: TextInputType.phone,
                              onSaved: (String value) {
                                controller.data.phone = value;
                              }),
                          SizedBox(height: 30),
                          TextFormField(
                              decoration: uiInputDecoration(hintText: 'E-mail'),
                              validator: Rules.emailValidate,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String value) {
                                controller.data.email = value;
                              }),
                          SizedBox(height: 30),
                          TextFormField(
                              decoration:
                                  uiInputDecoration(hintText: 'Пароль'.tr),
                              validator: Rules.passwordValidate,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              onSaved: (String value) {
                                controller.data.password = value;
                              }),
                          SizedBox(height: 30),
                          Obx(
                            () => controller.isLoading.isTrue
                                ? Center(
                                    child: CircularProgressIndicator(
                                      valueColor:
                                          new AlwaysStoppedAnimation<Color>(
                                              Colors.white),
                                    ),
                                  )
                                : uiButton(
                                    onPressed: () => controller.register(),
                                    text: 'Регистрация'),
                          ),
                          SizedBox(height: 30),
                          new InkWell(
                              child: new Text('Уже есть аккаунт? Войдите'.tr,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onTap: () => Get.offNamed('/login')),
                        ],
                      ),
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
