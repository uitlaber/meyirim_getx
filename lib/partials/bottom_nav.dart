import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meyirim/controller/app_controller.dart';
import 'package:meyirim/core/utils.dart';
import 'package:get/get.dart';

class BottomNav extends StatelessWidget {
  final int currentPage;

  const BottomNav({Key key, @required this.currentPage}) : super(key: key);

  void _onItemTapped(int index) {
    final appController = Get.find<AppController>();
    print(appController.isLoading.isTrue);
    if (appController.isLoading.isTrue) return;

    if (currentPage == index) return;

    switch (index) {
      case 0:
        {
          Get.offNamed('/home');
        }
        break;
      case 1:
        {
          Get.offNamed('/search');
        }
        break;
      case 2:
        {
          Get.offNamed('/profile');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icon/home.svg',
              color:
                  currentPage == 0 ? HexColor('#00D7FF') : HexColor('#A5A5A5')),
          label: 'Проекты',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icon/search.svg',
              color:
                  currentPage == 1 ? HexColor('#00D7FF') : HexColor('#A5A5A5')),
          label: 'Поиск',
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset('assets/icon/user.svg',
              color:
                  currentPage == 2 ? HexColor('#00D7FF') : HexColor('#A5A5A5')),
          label: 'Профиль',
        ),
      ],
      currentIndex: currentPage,
      selectedItemColor: Colors.amber[800],
      showSelectedLabels: false,
      showUnselectedLabels: false,
      onTap: _onItemTapped,
    );
  }
}
