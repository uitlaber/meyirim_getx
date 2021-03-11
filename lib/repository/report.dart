import 'package:get/get.dart';
import 'package:directus/directus.dart';

class ReportRepository {
  Future<DirectusListResponse> fetchReports(limit, offset,
      {filterCount: true}) async {
    DirectusListResponse result;
    try {
      final sdk = Get.find<Directus>();
      result = await sdk.items('reports').readMany(
          query: Query(fields: [
            '*.*',
            'fond.region_id.*',
            'project.photos.*',
            'project.fond.*',
            'project.fond.region_id.*'
          ], limit: limit, offset: offset, meta: Meta(filterCount: true)),
          filters: Filters({
            'status': Filter.eq('published'),
          }));

      return result;
    } catch (e) {
      print(e);
      result = null;
    }
    return result;
  }
}
