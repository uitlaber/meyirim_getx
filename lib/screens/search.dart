import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:meyirim/core/ui.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/partials/bottom_nav.dart';
import 'package:meyirim/partials/project/card.dart';
import 'package:meyirim/screens/search/controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  final controller = Get.find<SearchController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColor.gray,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          leading: null,
          toolbarHeight: 80,
          title: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    height: 45,
                    child: TextField(
                        controller: controller.searchController,
                        onSubmitted: (String value) {
                          controller.projects.clear();
                          controller.query.value = value;
                          controller.searchProjects();
                        },
                        decoration: InputDecoration(
                          hintText: 'Поиск проектов'.tr,
                          fillColor: Colors.white,
                          filled: true,
                          prefixIcon: Icon(Icons.search, size: 30),
                          contentPadding: EdgeInsets.all(4),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: new BorderSide(color: Colors.white)),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30.0),
                              borderSide: new BorderSide(color: Colors.white)),
                        )),
                  ),
                ),
                SizedBox(width: 10),
                InkWell(
                  onTap: () {
                    controller.projects.clear();
                    controller.query.value = '';
                    controller.searchController.clear();
                  },
                  child: SvgPicture.asset('assets/icon/clear.svg',
                      width: 40, height: 40),
                )
              ],
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.hasError.isTrue)
          return Container(
            padding: EdgeInsets.all(15),
            child: Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Icon(
                    Icons.wifi_off,
                    color: HexColor('#999999'),
                    size: 39,
                  ),
                  SizedBox(width: 10),
                  Text(
                    'Не удалось загрузить проекты'.tr,
                    style: TextStyle(color: HexColor('#999999')),
                  )
                ],
              ),
            ),
          );

        return Stack(
          children: [
            RefreshIndicator(
              onRefresh: () => controller.refreshList(),
              child: ListView.builder(
                controller: controller.scroll,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount:
                    ["", null, false, 0].contains(controller.projects?.length)
                        ? 0
                        : controller.projects.length,
                itemBuilder: (context, index) {
                  return ProjectCard(project: controller.projects[index]);
                },
              ),
            ),
            if (controller.isLoading.isTrue)
              Container(
                child: Center(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: CircularProgressIndicator()),
                ),
              ),
            if (controller.isLoading.isFalse &&
                controller.query.isEmpty &&
                controller.projects.length == 0)
              InkWell(
                onTap: () => controller.refreshList(),
                child: Container(
                  child: Center(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text('Введите наименование проекта или текст'.tr,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: UIColor.textGray))),
                  ),
                ),
              ),
            if (controller.isLoading.isFalse &&
                controller.query.isNotEmpty &&
                controller.projects.length == 0)
              InkWell(
                onTap: () => controller.refreshList(),
                child: Container(
                  child: Center(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text('Ничего не найдено'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: UIColor.textGray)),
                            SizedBox(height: 10),
                            Text('Попробуйте изменить условия поиска'.tr,
                                style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: UIColor.textGray))
                          ],
                        )),
                  ),
                ),
              ),
          ],
        );
      }),
      bottomNavigationBar: BottomNav(currentPage: 1),
    );
  }
}
