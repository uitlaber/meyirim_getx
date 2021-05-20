import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/controller/app_controller.dart';
import 'package:meyirim/core/ui.dart';
import 'package:meyirim/screens/fond/partials/bottom_nav.dart';
import 'package:meyirim/screens/fond/tabs/indigent_list.dart';
import 'package:meyirim/screens/fond/tabs/project_list.dart';

import 'controller/fond_home_controller.dart';

class FondHomeScreen extends StatelessWidget {
  final controller = Get.find<FondHomeController>();
  final appController = Get.find<AppController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: controller.tabs.length,
      child: Scaffold(
        backgroundColor: UIColor.gray,
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
              isScrollable: true,
              labelColor: Colors.white,
              labelStyle: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
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
            IndigentListTab(isVerifed: false),
            IndigentListTab(isVerifed: false),
            ProjectListTab(),
            ProjectListTab(),
          ],
        ),
        bottomNavigationBar: FondBottomNav(currentPage: 0),
      ),
    ));
  }
}
