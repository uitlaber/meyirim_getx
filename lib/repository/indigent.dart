import 'package:directus/directus.dart';
import 'package:get/get.dart';
import 'package:meyirim/models/indigent.dart';

class IndigentRepository {
  final sdk = Get.find<Directus>();

  Future<DirectusListResponse> fetchIndigents(limit, offset, isVerifed,
      {filterCount: true}) async {
    DirectusListResponse result;
    try {
      result = await sdk.items('indigents').readMany(
          query: Query(
              fields: ['*.*'],
              limit: limit,
              offset: offset,
              sort: ['-date_created'],
              meta: Meta(filterCount: filterCount)),
          filters: Filters({
            // 'status': Filter.eq('published'),
            'is_verifed': Filter.eq(isVerifed),
          }));

      return result;
    } catch (e) {
      print(e);
      result = null;
    }
    return result;
  }

  Future<DirectusListResponse> searchIndigents(
      query, limit, offset, isValidated,
      {filterCount: true, totalCount: true}) async {
    DirectusListResponse result;
    try {
      result = await sdk.items('indigents').readMany(
            query: Query(
                fields: ['*.*'],
                limit: limit,
                offset: offset,
                sort: ['-date_created'],
                customParams: {'search': query.toLowerCase()},
                meta: Meta(totalCount: true, filterCount: true)),
            filters: Filters({
              // 'status': Filter.eq('published'),
            }),
          );
    } catch (e) {
      print(e);
      result = null;
    }
    return result;
  }

  Future<Indigent> findIndigent(String id) async {
    Indigent project;
    try {
      final result = await sdk
          .items('indigents')
          .readOne(id, query: Query(fields: ['*.*']));
      project = Indigent.fromJson(result.data);
    } catch (e) {
      print(e);
      project = null;
    }
    return project;
  }
}
