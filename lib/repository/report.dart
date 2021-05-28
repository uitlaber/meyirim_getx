import 'package:get/get.dart';
import 'package:directus/directus.dart';
import 'package:meyirim/models/report.dart';

class ReportRepository {
  final sdk = Get.find<Directus>();
  Future<DirectusListResponse> fetchReports(limit, offset,
      {filterCount: true}) async {
    DirectusListResponse result;
    try {
      result = await sdk.items('reports').readMany(
          query: Query(fields: [
            '*.*',
            'translations.*',
            'fond.region_id.*',
            'project.photos.*',
            'project.fond.*',
            'project.translations.*',
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

  Future<Report> findReport(String id) async {
    Report report;
    try {
      final result = await sdk.items('reports').readOne(id,
          query: Query(
            fields: [
              '*.*',
              'translations.*',
              'fond.region_id.*',
              'project.photos.*',
              'project.fond.*',
              'project.fond.region_id.*'
            ],
          ));
      report = Report.fromJson(result.data);
    } catch (e) {
      print(e);
      report = null;
    }
    return report;
  }
}
