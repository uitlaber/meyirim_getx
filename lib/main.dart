import 'package:directus/directus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:meyirim/binding/app_binding.dart';
import 'package:meyirim/binding/home_binding.dart';
import 'package:meyirim/binding/profile_binding.dart';
import 'package:meyirim/binding/project_binding.dart';
import 'package:meyirim/core/messages.dart';
import 'package:meyirim/screens/home.dart';
import 'package:meyirim/screens/no_internet.dart';
import 'package:meyirim/screens/profile.dart';
import 'package:meyirim/screens/project.dart';
import 'package:meyirim/screens/report.dart';
import 'package:meyirim/screens/search.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'binding/search_binding.dart';
import 'core/service/directus.dart';
import 'core/ui.dart';
import 'core/utils.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initServices();
  runApp(MyApp());
}

Future<void> initServices() async {
  print('starting services ...');
  await Get.putAsync<SharedPreferences>(
      () async => await SharedPreferences.getInstance());

  await Get.putAsync<Directus>(() => DirectusAPI().init());
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

        GetPage(name: "/no_internet", page: () => NoInternetScreen()),
      ],
      initialBinding: AppBinding(),
      initialRoute: "/home",
    );
  }
}
