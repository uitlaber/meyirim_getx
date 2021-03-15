import 'package:dio/dio.dart';
import 'package:directus/directus.dart';
import 'package:get/get.dart' hide FormData, MultipartFile;
import 'package:meyirim/models/file.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class FileRepository {
  final sdk = Get.find<Directus>();

  Future<FileModel> uploadFile(String path) async {
    final mimeTypeData =
        lookupMimeType(path, headerBytes: [0xFF, 0xD8]).split('/');
    Map<String, dynamic> data = {
      'file': await MultipartFile.fromFile(path,
          contentType: MediaType(mimeTypeData[0], mimeTypeData[1]))
    };
    print(data);
    FormData formData = FormData.fromMap(data);
    final result = await sdk.client.post('/files', data: formData);
    return FileModel.fromJson(result.data['data']);
  }
}
