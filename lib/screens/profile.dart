import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/controller/app_controller.dart';
import 'package:meyirim/core/ui.dart';
import 'package:meyirim/partials/bottom_nav.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/screens/profile/controller/profile_controller.dart';
import 'package:meyirim/screens/profile/views/donations.dart';
import 'package:meyirim/screens/profile/views/donations_referal.dart';

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
            title: appController.isLogged()
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Профиль',
                              style: TextStyle(color: Colors.white)),
                          Text(appController.user.email,
                              style:
                                  TextStyle(color: Colors.white, fontSize: 12))
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      InkWell(
                        onTap: () {
                          appController.logout();
                        },
                        child:
                            SvgPicture.asset('assets/icon/edit.svg', width: 31),
                      )
                    ],
                  )
                : InkWell(
                    onTap: () => appController.login(), //Get.to('/register'),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/icon/profile-user.svg',
                            width: 45, height: 45),
                        SizedBox(width: 10),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Войдите или создайте аккаунт'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16)),
                            SizedBox(height: 5),
                            Text('Чтобы не терять свои пожертвование'.tr,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14))
                          ],
                        )
                      ],
                    ),
                  ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                userDonations(),
                SizedBox(height: 50),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNav(currentPage: 2),
      );
    });
  }

  Widget userDonations() {
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
                              color: UIColor.red, fontWeight: FontWeight.w500),
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
  }

  Widget forLogged() {
    return Column(
      children: [
        InkWell(
          onTap: () => Get.toNamed('/add-indigent'),
          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10.0))),
              child: Row(children: [
                Icon(Icons.add_circle_outline, color: UIColor.blue, size: 44),
                SizedBox(
                  width: 10,
                ),
                Text('Добавить нуждающегося'.tr,
                    style: TextStyle(
                        color: UIColor.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
              ])),
        ),
        SizedBox(
          height: 15,
        ),
        InkWell(
            onTap: () => Get.to('/add-feedback'),
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
                  Text('Написать сообщение'.tr,
                      style: TextStyle(
                          color: UIColor.blue,
                          fontSize: 15,
                          fontWeight: FontWeight.w500)),
                ]))),
        SizedBox(
          height: 15,
        ),
      ],
    );
  }
}
