import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/controller/app_controller.dart';
import 'package:meyirim/core/ui.dart';
import 'package:meyirim/partials/bottom_nav.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/partials/lang_modal.dart';
import 'package:meyirim/screens/profile/controller/profile_controller.dart';
import 'package:meyirim/screens/profile/views/donations.dart';
import 'package:meyirim/screens/profile/views/donations_referal.dart';
import 'package:meyirim/screens/profile/views/contacts.dart';

// ignore: must_be_immutable
class ProfileScreen extends StatelessWidget {
  ProfileController controller = Get.find<ProfileController>();
  AppController appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        backgroundColor: UIColor.gray,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(75.0),
          child: AppBar(
            toolbarHeight: 75,
            title: appController.isLogged.isTrue
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Профиль'.tr,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.white)),
                            Text(appController.user.email,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 12))
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     appController.logout();
                      //   },
                      //   child: Icon(Icons.more_vert, color: Colors.white),
                      // )
                    ],
                  )
                : InkWell(
                    onTap: () => Get.toNamed('/register'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icon/profile-user.svg',
                            width: 40, height: 40),
                        SizedBox(width: 10),
                        Flexible(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Войдите или создайте аккаунт'.tr,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14)),
                              SizedBox(height: 5),
                              Text('Чтобы не терять свои пожертвование'.tr,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.normal,
                                      fontSize: 13))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
            actions: [
              PopupMenuButton<String>(
                icon: Icon(Icons.more_vert, color: Colors.white),
                onSelected: onSelectedUserMenu,
                itemBuilder: (BuildContext context) {
                  if (appController.isLogged.isTrue) {
                    return [
                      PopupMenuItem(
                        value: 'logout',
                        child: Text('Выход'.tr),
                      )
                    ];
                  } else {
                    return [
                      PopupMenuItem(
                        value: 'login',
                        child: Text('Войти'.tr),
                      ),
                      PopupMenuItem(
                        value: 'register',
                        child: Text('Регистрация'.tr),
                      )
                    ];
                  }
                },
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                userDonations(),
                SizedBox(height: 15),
                feedbackLinks(),
                SizedBox(height: 15),
                localeButton()
                // if (appController.isLogged.isTrue) SizedBox(height: 200),
                // if (appController.isLogged.isTrue) forLogged(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNav(currentPage: 2),
      );
    });
  }

  Widget localeButton() {
    return Container(
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(10.0))),
        child: InkWell(
          onTap: () => Get.dialog(LangModal()),
          child: Row(children: [
            Icon(Icons.language_sharp, color: UIColor.blue, size: 40),
            SizedBox(
              width: 10,
            ),
            Text('Язык приложения'.tr,
                style: TextStyle(
                    color: UIColor.blue,
                    fontSize: 15,
                    fontWeight: FontWeight.w500)),
          ]),
        ));
  }

  Widget feedbackLinks() {
    return Container(
      child: InkWell(
          onTap: () => Get.dialog(Contacts()),
          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(children: [
                Icon(Icons.message_outlined, color: UIColor.blue, size: 40),
                SizedBox(
                  width: 10,
                ),
                Text('Написать нам'.tr,
                    style: TextStyle(
                        color: UIColor.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ]))),
    );
  }

  Widget userDonations() {
    return Obx(() {
      return Column(
        children: [
          InkWell(
            onTap: () => Get.dialog(new DonationsScreen()),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Мои пожертвование'.tr,
                            style: TextStyle(
                                color: UIColor.green,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Text(formatCur(controller.amount),
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: UIColor.green,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          )),
                      child: Icon(Icons.chevron_right, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 15),
          InkWell(
            onTap: () => Get.dialog(new DonationsReferalScreen()),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Помогли через меня'.tr,
                            style: TextStyle(
                                color: UIColor.red,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 10),
                          Text(formatCur(controller.referalAmount),
                              style: TextStyle(
                                  fontSize: 21, fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: UIColor.red,
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          )),
                      child: Icon(Icons.chevron_right, color: Colors.white),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

  Widget forLogged() {
    return Column(
      children: [
        // InkWell(
        //   onTap: () => Get.dialog(IndigentAddScreen()),
        //   child: Container(
        //       padding: EdgeInsets.all(10),
        //       decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.all(Radius.circular(10.0))),
        //       child: Row(children: [
        //         Icon(Icons.add_circle_outline, color: UIColor.blue, size: 44),
        //         SizedBox(
        //           width: 10,
        //         ),
        //         Text('Добавить нуждающегося'.tr,
        //             style: TextStyle(
        //                 color: UIColor.blue,
        //                 fontSize: 15,
        //                 fontWeight: FontWeight.w500)),
        //       ])),
        // ),
        // SizedBox(
        //   height: 15,
        // ),
        // appController.isFond() == true
        //     ? InkWell(
        //         onTap: () => Get.offNamed('/fond/home'),
        //         child: Container(
        //             padding: EdgeInsets.all(10),
        //             decoration: BoxDecoration(
        //                 color: UIColor.red,
        //                 borderRadius: BorderRadius.all(Radius.circular(10.0))),
        //             child: Row(children: [
        //               Icon(Icons.account_circle, color: Colors.white, size: 40),
        //               SizedBox(
        //                 width: 10,
        //               ),
        //               Text('Панель управления фондом'.tr,
        //                   style: TextStyle(
        //                       color: Colors.white,
        //                       fontSize: 15,
        //                       fontWeight: FontWeight.w500)),
        //             ])))
        //     : Container(),
        // SizedBox(
        //   height: 15,
        // ),
      ],
    );
  }

  void onSelectedUserMenu(String choice) async {
    switch (choice) {
      case 'logout':
        {
          appController.logout();
        }
        break;

      case 'login':
        {
          Get.toNamed('/login');
        }
        break;

      case 'register':
        {
          Get.toNamed('/register');
        }
        break;
    }
  }
}
