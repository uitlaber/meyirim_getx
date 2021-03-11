import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:meyirim/controller/app_controller.dart';
import 'package:meyirim/partials/bottom_nav.dart';
import 'package:meyirim/screens/home/controller/home_controller.dart';
import 'package:meyirim/screens/home/tabs/project_finished_list_tab.dart';
import 'package:meyirim/screens/home/tabs/report_list_tab.dart';
import 'package:meyirim/screens/intro.dart';

import 'home/tabs/project_list_tab.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.find<HomeController>();
  final appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() => appController.firstStart.isTrue
        ? IntroScreen()
        : Scaffold(
            body: DefaultTabController(
            length: controller.tabs.length,
            child: Scaffold(
              appBar: PreferredSize(
                preferredSize: Size.fromHeight(130.0),
                child: AppBar(
                  toolbarHeight: 130,
                  title: SvgPicture.asset(
                    'assets/images/logo.svg',
                    width: 120,
                  ),
                  centerTitle: true,
                  bottom: TabBar(
                    labelColor: Colors.white,
                    labelStyle:
                        TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                    tabs: [
                      ...controller.tabs.map((text) => Tab(
                            text: text.tr.toUpperCase(),
                          ))
                    ],
                  ),
                ),
              ),
              body: TabBarView(
                children: [
                  ProjectListTab(),
                  ProjectFinishedListTab(),
                  ReportListTab()
                ],
              ),
              bottomNavigationBar: BottomNav(currentPage: 0),
            ),
          )));
  }
}
