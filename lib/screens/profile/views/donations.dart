import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:meyirim/partials/donation/list.dart';
import 'package:meyirim/screens/profile/controller/donations_controller.dart';

// ignore: must_be_immutable
class DonationsScreen extends StatelessWidget {
  DonationsController controller = Get.put(DonationsController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: Text('Мои пожертвования '.tr,
              style: TextStyle(color: Colors.white))),
      body: DonationList(controller: controller),
    );
  }
}
