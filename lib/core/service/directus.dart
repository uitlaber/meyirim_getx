import 'package:get/get.dart';
import 'package:directus/directus.dart';
import 'package:meyirim/core/config.dart' as config;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meyirim/core/service/auth.dart' as auth;

class DirectusAPI extends GetxService {
  Directus sdk;

  Future<Directus> init() async {
    try {
      sdk = await Directus(config.API_URL).init();
    } catch (e) {
      print(e);
      SharedPreferences preferences = await SharedPreferences.getInstance();
      for (String key in preferences.getKeys()) {
        if (key.startsWith('directus__')) {
          preferences.remove(key);
        }
      }
      sdk = await Directus(config.API_URL).init();
    }
    sdk.client.options.headers['device-code'] = await auth.userCode();
    var referalCode = await auth.referalCode();
    if (referalCode != null) {
      sdk.client.options.headers['referal-device-code'] = referalCode;
    }
    return this.sdk;
  }
}
