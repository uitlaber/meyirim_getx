import 'package:directus/directus.dart';
import 'package:get/get.dart';
import 'package:meyirim/core/service/auth.dart' as auth;

class DonationRepository {
  Future<DirectusListResponse> fetchDonations(
      bool isReferal, int limit, int offset,
      {filterCount: true}) async {
    DirectusListResponse result;
    try {
      final sdk = Get.find<Directus>();
      var filter;
      if (!isReferal) {
        filter = {
          'paid_at': Filter.notNull(),
          'device_code': Filter.eq(await auth.userCode())
        };
      } else {
        filter = {
          'paid_at': Filter.notNull(),
          'referal_device_code': Filter.eq(await auth.userCode())
        };
      }

      result = await sdk.items('donations').readMany(
          query: Query(
              fields: [
                '*',
                'project_id.*',
                'project_id.photos.*',
                'project_id.translations.*',
                'project_id.fond.*',
                'project_id.fond.region_id.*'
              ],
              limit: limit,
              offset: offset,
              meta: Meta(filterCount: filterCount)),
          filters: Filters(filter));
    } catch (e) {
      print(e);
      result = null;
    }
    return result;
  }
}
