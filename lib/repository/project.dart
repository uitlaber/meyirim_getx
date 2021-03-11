import 'package:directus/directus.dart';
import 'package:get/get.dart';

class ProjectRepository {
  Future<DirectusListResponse> fetchProjects(limit, offset, isFinished,
      {filterCount: true}) async {
    DirectusListResponse result;
    try {
      final sdk = Get.find<Directus>();
      result = await sdk.items('projects').readMany(
          query: Query(
              fields: ['*.*', 'fond.region_id.*'],
              limit: limit,
              offset: offset,
              meta: Meta(filterCount: filterCount)),
          filters: Filters({
            'status': Filter.eq('published'),
            'is_finished': Filter.eq(isFinished),
          }));

      return result;
    } catch (e) {
      print(e);
      result = null;
    }
    return result;
  }

  Future<DirectusListResponse> searchProjects(query, limit, offset, isFinished,
      {filterCount: true, totalCount: true}) async {
    DirectusListResponse result;
    try {
      final sdk = Get.find<Directus>();
      result = await sdk.items('projects').readMany(
            query: Query(
                fields: ['*.*', 'fond.region_id.*'],
                limit: limit,
                offset: offset,
                customParams: {'search': query.toLowerCase()},
                meta: Meta(totalCount: true, filterCount: true)),
            filters: Filters({
              'status': Filter.eq('published'),
            }),
          );
    } catch (e) {
      print(e);
      result = null;
    }
    return result;
  }
}
