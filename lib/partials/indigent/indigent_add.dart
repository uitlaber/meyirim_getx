import 'package:flutter/material.dart';
import 'package:meyirim/core/ui.dart';
import 'package:get/get.dart';
import 'package:meyirim/core/utils.dart';
import 'package:meyirim/partials/indigent/controller/add_indigent_controller.dart';
import 'package:smart_select/smart_select.dart';

class IndigentAddScreen extends StatelessWidget {
  final controller = Get.put(AddIndigentController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UIColor.gray,
      appBar: AppBar(
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        title:
            Text('Регистрация нужды'.tr, style: TextStyle(color: Colors.white)),
      ),
      body: Obx(
        () => Stack(
          children: [
            Container(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Form(
                    key: controller.form,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        SizedBox(height: 20),
                        Obx(
                          () => Container(
                            height: 150,
                            child: ListView.builder(
                              controller: controller.scrollController,
                              shrinkWrap: true,
                              itemCount: controller.images?.length == null
                                  ? 1
                                  : controller.images.length + 1,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                if (controller.images
                                    .asMap()
                                    .containsKey(index)) {
                                  return Stack(
                                    children: [
                                      Container(
                                        width: 150,
                                        height: 150,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                        margin: EdgeInsets.only(right: 10),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: Image.file(
                                              controller.images[index],
                                              width: 150,
                                              height: 150,
                                              fit: BoxFit.cover),
                                        ),
                                      ),
                                      Positioned(
                                        top: 10.0,
                                        right: 20.0,
                                        child: InkWell(
                                          onTap: () {
                                            controller.images.removeAt(index);
                                          },
                                          child: Container(
                                            child: Center(
                                              child: Icon(Icons.clear,
                                                  color: UIColor.red, size: 32),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return InkWell(
                                    onTap: () => controller.showPicker(context),
                                    child: Container(
                                      width: 150,
                                      height: 150,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      margin: EdgeInsets.only(right: 10),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Icon(Icons.add_a_photo,
                                              size: 42, color: UIColor.blue),
                                          SizedBox(height: 10),
                                          Text('Добавить фото'.tr,
                                              textAlign: TextAlign.center,
                                              style: TextStyle(
                                                  color: UIColor.blue)),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                            decoration: uiInputDecoration(
                                hintText: 'Имя нуждающегося'.tr),
                            validator: Rules.fullnameValidate,
                            onSaved: (String value) {
                              controller.data.fullname = value;
                            }),
                        SizedBox(height: 30),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(
                                const Radius.circular(30.0),
                              )),
                          child: SmartSelect<int>.single(
                              placeholder: '',
                              title: controller.value != null
                                  ? 'Регион выбран'.tr
                                  : 'Выберите регион нуждающегося'.tr,
                              modalType: S2ModalType.bottomSheet,
                              tileBuilder: (context, state) {
                                return S2Tile.fromState(
                                  state,
                                  title: Text(
                                      controller.value?.value != null
                                          ? 'Регион выбран'.tr
                                          : 'Выберите регион нуждающегося'.tr,
                                      style: TextStyle(
                                          color: HexColor('#6B6B6B'))),
                                );
                              },
                              value: controller.value?.value,
                              choiceItems: controller.regionOptions,
                              onChange: (state) {
                                controller.data.id = state.value;
                              }),
                        ),
                        SizedBox(height: 30),
                        TextFormField(
                            decoration: uiInputDecoration(
                                hintText: 'Адрес нуждающегося'),
                            onSaved: (String value) {
                              controller.data.address = value;
                            }),
                        SizedBox(height: 30),
                        TextFormField(
                            maxLines: 4,
                            decoration: uiInputDecoration(
                                hintText: 'Дополнительная информация'.tr,
                                padding: EdgeInsets.only(
                                    top: 20,
                                    bottom: 20,
                                    left: 20.0,
                                    right: 20.0)),
                            onSaved: (String value) {
                              controller.data.note = value;
                            }),
                        SizedBox(height: 30),
                        TextFormField(
                            decoration:
                                uiInputDecoration(hintText: 'Ваш номер'.tr),
                            validator: Rules.phoneValidate,
                            inputFormatters: [Rules.phoneFormatter],
                            keyboardType: TextInputType.phone,
                            onSaved: (String value) {
                              controller.data.phone = value;
                            }),
                        SizedBox(height: 30),
                        uiButton(
                            onPressed: () async => await controller.send(),
                            text: 'Отправить в фонды'.tr),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ),
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
        ),
      ),
    );
  }
}
