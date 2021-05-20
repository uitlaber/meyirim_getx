import 'package:directus/directus.dart';
import 'package:get/get.dart';
import 'package:meyirim/models/region.dart';

class RegionRepository {
  final sdk = Get.find<Directus>();

  Future<List<Region>> fetchRegion(int countryId) async {
    List<Region> result = [];
    try {
      DirectusListResponse response = await sdk.items('regions').readMany(
          query: Query(
            fields: [
              '*',
            ],
          ),
          filters: Filters({'country_id': Filter.eq(countryId)}));

      result = List<Region>.from(response.data.map((x) {
        return Region.fromJson(x);
      }));
    } catch (e) {
      print(e);
      result = [];
    }
    return result;
  }
}
