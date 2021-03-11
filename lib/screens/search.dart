import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/partials/bottom_nav.dart';
import 'package:meyirim/partials/project/card.dart';
import 'package:meyirim/screens/search/controller/search_controller.dart';

class SearchScreen extends StatelessWidget {
  final controller = Get.find<SearchController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          leading: null,
          toolbarHeight: 80,
          title: Container(
            child: TextField(
                controller: controller.searchController,
                cursorHeight: 3.2,
                onSubmitted: (String value) {
                  controller.projects.clear();
                  controller.query.value = value;
                  controller.searchProjects();
                },
                decoration: InputDecoration(
                  hintText: 'Поиск проектов',
                  fillColor: Colors.white,
                  filled: true,
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.query.value = '';
                      controller.searchController.clear();
                      controller.refreshList();
                    },
                    icon: Icon(Icons.clear),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                )),
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
                    'Не удалось загрузить проекты \nВозможно нет интернета',
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
            if (controller.isLoading.isFalse && controller.projects.length == 0)
              InkWell(
                onTap: () => controller.refreshList(),
                child: Container(
                  child: Center(
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                            'Введите наименование проекта,\n или текст'.tr,
                            textAlign: TextAlign.center)),
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
