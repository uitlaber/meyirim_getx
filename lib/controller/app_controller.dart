import 'package:directus/directus.dart';
import 'package:get/get.dart';
import 'package:meyirim/models/region.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';

class AppController extends GetxController {
  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    if (await checkInternet()) {
      await loadRegions();
    }
    super.onInit();
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('Есть интернет');
      return true;
    } else {
      print('Нет интернета');
      return false;
    }
  }

  Future<void> loadRegions() async {
    print('Загрузка регионов');
    final result = await Get.find<Directus>().items('regions').readMany(
          query: Query(
              sort: ['sort'],
              fields: ['id', 'name', 'parent_id', 'country_id', 'sort']),
        );

    List<Region> regions =
        List<Region>.from(result.data.map((x) => Region.fromJson(x)));
    Get.find<SharedPreferences>().setString('regions', Region.encode(regions));
    print('Загрузка регионов завершена...');
  }
}
