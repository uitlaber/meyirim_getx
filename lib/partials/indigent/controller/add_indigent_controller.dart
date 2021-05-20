import 'dart:io';
import 'package:directus/directus.dart';
import 'package:meyirim/core/ui.dart';
import 'package:meyirim/models/file.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meyirim/models/indigent.dart';
import 'package:meyirim/repository/file.dart';
import 'package:meyirim/repository/region.dart';
import 'package:smart_select/smart_select.dart';
import 'package:meyirim/models/region.dart';

class AddIndigentController extends GetxController {
  GlobalKey<FormState> form = GlobalKey<FormState>();
  Indigent data = new Indigent();
  RxBool isLoading = false.obs;
  RxInt value = 0.obs;
  RxList<S2Choice<int>> regionOptions = <S2Choice<int>>[].obs;
  RxList<File> images = <File>[].obs;
  final picker = ImagePicker();
  ScrollController scrollController = new ScrollController();
  RegionRepository regionRepository = new RegionRepository();
  FileRepository fileRepository = new FileRepository();
  Directus sdk = Get.find<Directus>();

  @override
  Future<void> onInit() async {
    List<Region> regions = await regionRepository.fetchRegion(1);
    regions.forEach((region) {
      regionOptions.add(S2Choice<int>(value: region.id, title: region.name));
    });
    super.onInit();
  }

  send() async {
    if (form.currentState.validate() && isLoading.isFalse) {
      isLoading.value = true;
      form.currentState.save();

      try {
        Map<String, dynamic> newData = {
          'fullname': data.fullname,
          'region_id': data.region,
          'address': data.address,
          'phone': data.phone,
          'note': data.note,
          'photos': images != null
              ? Iterable<dynamic>.generate(images.length)?.toList()
              : null,
        };

        if (images != null) {
          for (var i = 0; i < images.length; i++) {
            if (images.length > 0 && images[i] is File) {
              FileModel photo = await fileRepository.uploadFile(images[i].path);
              newData['photos'][i] = {'directus_files_id': photo.id};
            }
          }
        }

        await sdk.client.post('/items/indigents', data: newData);
        form.currentState?.reset();
        images.clear();
        isLoading.value = false;
        Get.snackbar(
            'Спасибо, ваша заявка отправлена'.tr,
            'Ваша заявка успешно отправлена и будет обработана фондами в ближайшее время'
                .tr,
            duration: Duration(seconds: 5),
            backgroundColor: UIColor.green,
            colorText: Colors.white);
      } catch (e) {
        print(e.message);
        isLoading.value = false;
        Get.snackbar('Сообщение системы'.tr, 'Ошибка при отправке данных'.tr,
            duration: Duration(seconds: 5),
            backgroundColor: Colors.redAccent,
            colorText: Colors.white);
      }
    }
  }

  void showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Из галереи'.tr),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Сфотографировать'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.camera, imageQuality: 70);
    if (pickedFile != null) {
      images.add(File(pickedFile.path));
    } else {
      print('No image selected.');
    }
  }

  _imgFromGallery() async {
    final pickedFile =
        await picker.getImage(source: ImageSource.gallery, imageQuality: 70);
    if (pickedFile != null) {
      images.add(File(pickedFile.path));
    } else {
      print('No image selected.');
    }
  }
}
