import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/partials/report/card.dart';
import 'package:meyirim/screens/home/controller/report_list_controller.dart';

class ReportListTab extends StatelessWidget {
  final controller = Get.put(ReportListController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.hasError.isTrue)
        return Container(
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
                  'Не удалось загрузить отчеты \nВозможно нет интернета',
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
                  ["", null, false, 0].contains(controller.reports?.length)
                      ? 0
                      : controller.reports.length,
              itemBuilder: (context, index) {
                return ReportCard(report: controller.reports[index]);
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
          if (!controller.isLoading.isTrue && controller.reports.length == 0)
            InkWell(
              onTap: () => controller.refreshList(),
              child: Container(
                child: Center(
                  child: Container(
                      padding: EdgeInsets.all(10),
                      child: Text('Пока нет отчетов')),
                ),
              ),
            ),
        ],
      );
    });
  }
}
