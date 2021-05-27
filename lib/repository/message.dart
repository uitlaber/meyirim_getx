import 'package:get/get.dart';
import 'package:directus/directus.dart';
import 'package:meyirim/core/config.dart' as config;
import 'package:meyirim/core/messages.dart';
import 'package:meyirim/models/message.dart';

class MessageRepository {
  static Future fetchMessages() async {
    final messages = Map<String, Map<String, String>>();
    try {
      final sdk = Get.find<Directus>();
      final resultMessages =
          await sdk.client.get(config.API_URL + '/items/messages');
      var messagesList = List<Message>.from(
          resultMessages.data['data']['text'].map((e) => Message.fromJson(e)));

      messages['kk_KZ'] = {for (var msg in messagesList) msg.key: msg.kkKz};
      messages['ru_RU'] = {for (var msg in messagesList) msg.key: msg.ruRu};
    } catch (e) {
      print(e.message);
    }
    Get.find<Messages>().map = messages;
  }
}
