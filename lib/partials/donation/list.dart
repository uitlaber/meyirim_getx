import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/models/donation.dart';
import 'package:meyirim/screens/profile/controller/donations_controller.dart';
import 'package:meyirim/screens/profile/views/donation_card.dart';

class DonationList extends StatelessWidget {
  final DonationsExtController controller;
  const DonationList({Key key, this.controller}) : super(key: key);
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
                  'Не удалось загрузить пожертвования'.tr,
                  style: TextStyle(color: HexColor('#999999')),
                )
              ],
            ),
          ),
        );

      if (controller.isLoading.isTrue &&
          ["", null, false, 0].contains(controller.donations?.length))
        return Container(
          child: Center(
            child: CircularProgressIndicator(),
          ),
        );

      return Stack(
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
                  ["", null, false, 0].contains(controller.donations?.length)
                      ? 0
                      : controller.donations.length,
              itemBuilder: (context, index) {
                return DonationCard(
                    donation: controller.donations[index], isReferal: false);
              },
            ),
          ),
          if (controller.donations?.length == 0)
            Container(
              child: Center(
                child: Text('Список пожертвовании пуст'.tr),
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
        ],
      );
    });
  }
}
