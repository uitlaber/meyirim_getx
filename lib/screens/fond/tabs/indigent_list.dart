import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/screens/fond/controller/indigent_list_controller.dart';
import 'package:meyirim/screens/fond/partials/indigent_card.dart';
import 'package:meyirim/partials/custom_widgets.dart';

// ignore: must_be_immutable
class IndigentListTab extends StatelessWidget {
  final controller = Get.put(IndigentListController());
  final bool isVerifed;
  IndigentListTab({Key key, this.isVerifed}) : super(key: key);

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
                  'Не удалось загрузить нуждающих'.tr,
                  style: TextStyle(color: HexColor('#999999')),
                )
              ],
            ),
          ),
        );

      return Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 10),
        child: Stack(
          children: [
            SizedBox(
              height: 15,
            ),
            RefreshIndicator(
              onRefresh: () => controller.refreshList(),
              child: ListView.builder(
                controller: controller.scroll,
                shrinkWrap: true,
                physics: AlwaysScrollableScrollPhysics(),
                itemCount:
                    ["", null, false, 0].contains(controller.indigents?.length)
                        ? 0
                        : controller.indigents.length,
                itemBuilder: (context, index) {
                  return IndigentCard(
                      indigent: controller.indigents[index],
                      isVerifed: isVerifed);
                },
              ),
            ),
            if (controller.indigents?.length == 0)
              customCenteredMessage('Список пожертвовании пуст'),
            if (controller.isLoading.isTrue) customProgressIndicator(),
          ],
        ),
      );
    });
  }
}
