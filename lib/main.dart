import 'package:directus/directus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meyirim/binding/app_binding.dart';
import 'package:meyirim/binding/home_binding.dart';
import 'package:meyirim/binding/profile_binding.dart';
import 'package:meyirim/binding/project_binding.dart';
import 'package:meyirim/core/messages.dart';
import 'package:meyirim/screens/auth/login.dart';
import 'package:meyirim/screens/auth/register.dart';
import 'package:meyirim/screens/auth/reset.dart';
import 'package:meyirim/screens/home.dart';
import 'package:meyirim/screens/no_internet.dart';
import 'package:meyirim/screens/payment/fail.dart';
import 'package:meyirim/screens/payment/success.dart';
import 'package:meyirim/screens/profile.dart';
import 'package:meyirim/screens/project.dart';
import 'package:meyirim/screens/report.dart';
import 'package:meyirim/screens/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'binding/auth_binding.dart';
import 'binding/search_binding.dart';
import 'core/service/directus.dart';
import 'core/ui.dart';
import 'core/utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initServices();
  runApp(MyApp());
}

Future<void> initServices() async {
  print('starting services ...');
  await Firebase.initializeApp();
  await Get.putAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());
  print('SharedPreferences initialed...');

  await Get.putAsync<Directus>(() async => await DirectusAPI().init());
  print('Directus initialed...');

  await Get.putAsync<FirebaseMessaging>(() async => FirebaseMessaging.instance);
  print('FirebaseMessaging initialed...');

  print('All services started...');
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Meyirim',
      theme: ThemeData(
        primarySwatch: createMaterialColor(UIColor.blue),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      translations: Messages(), // your translations
      locale:
          Locale('ru', 'RU'), // translations will be displayed in that locale
      fallbackLocale: Locale('ru', 'RU'),
      defaultTransition: null,
      getPages: [
        // //Главная
        // GetPage(
        //     name: "/fond/home",
        //     page: () => FondHomeScreen(),
        //     transition: Transition.noTransition,
        //     binding: FondHomeBinding()),

        //Главная
        GetPage(
            name: "/home",
            page: () => HomeScreen(),
            transition: Transition.noTransition,
            binding: HomeBinding()),

        //Страница поиска
        GetPage(
            name: "/search",
            transition: Transition.noTransition,
            page: () => SearchScreen(),
            binding: SearchBinding()),

        //Страница профиля
        GetPage(
            name: "/profile",
            transition: Transition.noTransition,
            page: () => ProfileScreen(),
            binding: ProfileBinding()),

        //Страница проекта
        GetPage(
            name: "/project",
            page: () => ProjectScreen(),
            transition: Transition.downToUp,
            transitionDuration: Duration(milliseconds: 300),
            binding: ProjectBinding()),

        //Страница отчета
        GetPage(
          name: "/report",
          transition: Transition.downToUp,
          transitionDuration: Duration(milliseconds: 300),
          page: () => ReportScreen(),
        ),

        //Страница входа
        GetPage(
            name: "/login",
            transition: Transition.noTransition,
            page: () => LoginScreen(),
            binding: AuthBinding()),

        //Страница регистация
        GetPage(
            name: "/register",
            transition: Transition.noTransition,
            page: () => RegisterScreen(),
            binding: AuthBinding()),

        //Страница восстановление пароля
        GetPage(
            name: "/reset",
            transition: Transition.noTransition,
            page: () => ResetScreen(),
            binding: AuthBinding()),

        //Страница восстановление пароля
        GetPage(
          name: "/payment/success",
          transition: Transition.noTransition,
          page: () => PaymentSuccessScreen(),
        ),

        //Страница восстановление пароля
        GetPage(
          name: "/payment/fail",
          transition: Transition.noTransition,
          page: () => PaymentFailScreen(),
        ),

        GetPage(name: "/no_internet", page: () => NoInternetScreen()),
      ],
      initialBinding: AppBinding(),
      initialRoute: "/home",
    );
  }
}
