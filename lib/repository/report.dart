import 'package:directus/directus.dart';
import 'package:get/get.dart';

class ReportRepository {
  Future<DirectusListResponse> fetchReports(limit, offset,
      {filterCount: true}) async {
    DirectusListResponse result;
    try {
      final sdk = Get.find<Directus>();
      result = await sdk.items('reports').readMany(
          query: Query(
              fields: ['*.*', 'project.photos.*', 'project.fond.*'],
              limit: limit,
              offset: offset,
              meta: Meta(filterCount: true)),
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
