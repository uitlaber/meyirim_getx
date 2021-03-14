import 'package:directus/directus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:connectivity/connectivity.dart';
import 'package:meyirim/core/service/auth.dart' as auth;
import 'package:meyirim/repository/project.dart';
import 'package:meyirim/repository/report.dart';

class AppController extends GetxController {
  RxBool firstStart = true.obs;
  RxBool isLogged = false.obs;
  RxBool isLoading = false.obs;
  Directus sdk = Get.find<Directus>();
  FirebaseMessaging messaging = Get.find<FirebaseMessaging>();
  DirectusUser user;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    if (await checkInternet()) {
      if (firstStart.isTrue && checkAuth()) {
        userInfo();
      }
    }
    notificationPremission();
    initMessaging();
    super.onInit();
  }

  Future<bool> checkInternet() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      print('Есть интернет');
      return true;
    } else {
      print('Нет интернета');
      return false;
    }
  }

  void initMessaging() {
    ProjectRepository projectRepository = new ProjectRepository();
    ReportRepository reportRepository = new ReportRepository();

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      if (message.data['target'] == 'project' ||
          message.data['target'] == 'report') {
        switch (message.data['target']) {
          case 'project':
            var project =
                await projectRepository.findProject(message.data['id']);
            Get.toNamed('/project', arguments: {'project': project});
            break;
          case 'report':
            var report = await reportRepository.findReport(message.data['id']);
            Get.toNamed('/report', arguments: {'report': report});
            break;
        }
      }
    });
  }

  void notificationPremission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User granted permission: ${settings.authorizationStatus}');
  }

  bool checkAuth() {
    final result = auth.isLoggedIn();
    isLogged.value = result;
    return result;
  }

  Future<void> logout() async {
    print('Logout');
    await auth.logout();
    isLogged.value = false;
  }

  Future<void> userInfo() async {
    try {
      DirectusResponse<DirectusUser> result =
          (await sdk.auth.currentUser?.read());
      print(result.data);
      user = result.data;
    } catch (e) {
      print(e);
      await logout();
    }
  }
}
