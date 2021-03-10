import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:meyirim/models/region.dart';

class RegionRepository {
  Future<Region> findRegion(int id) async {
    Region result;
    try {
      final prefs = Get.find<SharedPreferences>();
      List<Region> regions = Region.decode(prefs.get('regions'));
      result = regions.firstWhere((Region region) {
        return region.id == id;
      });
    } catch (e) {
      print(e);
      result = null;
    }
    return result;
  }
}
