import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/partials/project/card.dart';
import 'package:meyirim/screens/home/controller/project_list_controller.dart';

class ProjectListTab extends StatelessWidget {
  final controller = Get.put(ProjectListController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
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
                      child: Text('Нет активных проектов'.tr)),
                ),
              ),
            ),
        ],
      );
    });
  }
}
