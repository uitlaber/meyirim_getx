import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meyirim/core/ui.dart';
import 'package:get/get.dart';
import 'controller/auth_controller.dart';

class LoginScreen extends StatelessWidget {
  final controller = Get.find<LoginController>();

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
                              decoration: uiInputDecoration(hintText: 'E-mail'),
                              validator: controller.emailValidate,
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (String value) {
                                controller.data.email = value;
                              }),
                          SizedBox(height: 30),
                          TextFormField(
                              decoration:
                                  uiInputDecoration(hintText: 'Пароль'.tr),
                              validator: controller.passwordValidate,
                              obscureText: true,
                              keyboardType: TextInputType.visiblePassword,
                              onSaved: (String value) {
                                controller.data.password = value;
                              }),
                          SizedBox(height: 30),
                          uiButton(
                              onPressed: () => controller.login(),
                              text: 'Войти'.tr),
                          SizedBox(height: 30),
                          new InkWell(
                              child: new Text('Забыли пароль'.tr,
                                  style: TextStyle(
                                      fontSize: 16.0, color: Colors.white)),
                              onTap: () => Get.offNamed('/reset')),
                          SizedBox(height: 15),
                          new InkWell(
                              child: new Text('Регистрация'.tr,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  )),
                              onTap: () => Get.offNamed('/register')),
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
