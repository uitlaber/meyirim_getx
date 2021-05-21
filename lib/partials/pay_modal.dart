import 'dart:ui';
import 'package:get/get.dart';
import 'package:directus/directus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:meyirim/controller/app_controller.dart';
import 'package:meyirim/core/my_app_browser.dart';
import 'package:meyirim/core/ui.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/models/project.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:meyirim/core/config.dart' as config;
import 'package:meyirim/partials/project/fond_card.dart';

class PayModal extends StatefulWidget {
  final Project project;

  const PayModal({Key key, this.project}) : super(key: key);

  @override
  _PayModalState createState() => _PayModalState();
}

class _PayModalState extends State<PayModal> {
  int amount = 100;
  final amountTextController = TextEditingController();
  final appController = Get.find<AppController>();
  bool _isLoading;

  @override
  void dispose() {
    amountTextController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _isLoading = false;
    amountTextController.text = '100';
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      child: SingleChildScrollView(
        child: _isLoading
            ? Container(
                color: Colors.white,
                height: 100,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : Container(
                color: Colors.white,
                padding:
                    EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 30),
                child: Column(
                  children: [
                    FondCard(
                      fond: widget.project.fond,
                      padding: EdgeInsets.only(bottom: 10),
                      actions: [
                        IconButton(
                            icon: Icon(Icons.close),
                            onPressed: () => Navigator.pop(context))
                      ],
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: Text(
                        widget.project.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 15),
                    Container(
                      child: TextFormField(
                        controller: amountTextController,
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        inputFormatters: <TextInputFormatter>[
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(10.0),
                            suffixText: '₸',
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            fillColor: HexColor('#F0F0F7'),
                            filled: true),
                      ),
                    ),
                    SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                              child: Text('100₸'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[300],
                                onPrimary: Colors.black,
                                shadowColor: Colors.white,
                                elevation: 0,
                              ),
                              onPressed: () {
                                amountTextController.text = '100';
                              }),
                        ),
                        Expanded(
                          flex: 1,
                          child: Padding(
                            padding: EdgeInsets.only(left: 5.0, right: 5.0),
                            child: ElevatedButton(
                                child: Text('500₸'),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.grey[300],
                                  onPrimary: Colors.black,
                                  shadowColor: Colors.white,
                                  elevation: 0,
                                ),
                                onPressed: () {
                                  amountTextController.text = '500';
                                }),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: ElevatedButton(
                              child: Text('1000₸'),
                              style: ElevatedButton.styleFrom(
                                primary: Colors.grey[300],
                                onPrimary: Colors.black,
                                shadowColor: Colors.white,
                                elevation: 0,
                              ),
                              onPressed: () {
                                amountTextController.text = '1000';
                              }),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    SizedBox(
                      width: double.infinity,
                      height: 50.0,
                      child: ElevatedButton(
                        onPressed: () => payCard(),
                        style: ElevatedButton.styleFrom(
                          primary: UIColor.green,
                          onPrimary: Colors.white,
                          shadowColor: Colors.white,
                          elevation: 0,
                        ),
                        child: Text(
                          "Оплатить банковской картой".tr,
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  void payCard() async {
    if (!mounted) return;
    if (appController.isLoading.isFalse) {
      appController.isLoading.value = true;
      Get.snackbar('Загрузка'.tr, 'Пожалуйста подаждите'.tr);
    }
    setState(() {
      _isLoading = true;
    });
    final sdk = Get.find<Directus>();
    final response = await sdk.client.post(
        config.API_URL + "/custom/payment/pay",
        data: {"id": widget.project.id, "amount": amountTextController.text});

    final ChromeSafariBrowser browser =
        new MyChromeSafariBrowser(new MyInAppBrowser());
    await browser.open(
        url: Uri.parse(response.data['url']),
        options: ChromeSafariBrowserClassOptions(
            android:
                AndroidChromeCustomTabsOptions(addDefaultShareMenuItem: false),
            ios: IOSSafariOptions(barCollapsingEnabled: true)));
    if (!mounted) return;
    setState(() {
      _isLoading = false;
    });
    Navigator.pop(context);
  }
}
