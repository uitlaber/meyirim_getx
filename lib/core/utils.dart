import 'dart:ui';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart' hide MultipartFile, FormData;
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:meyirim/controller/app_controller.dart';
import 'package:meyirim/core/config.dart' as config;
import 'package:meyirim/core/service/auth.dart' as auth;
import 'package:meyirim/models/project.dart';
import 'package:meyirim/models/report.dart';
import 'package:meyirim/repository/project.dart';
import 'package:meyirim/repository/report.dart';
import 'package:share/share.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:shared_preferences/shared_preferences.dart';

import 'my_app_browser.dart';

SharedPreferences prefs = Get.find<SharedPreferences>();
final appController = Get.find<AppController>();

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  strengths.forEach((strength) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  });
  return MaterialColor(color.value, swatch);
}

/// Форматирование суммы
String formatCur(dynamic amount) {
  if (amount.runtimeType == RxDouble && amount == 0.0) {
    return '0 ₸';
  }
  return new NumberFormat.currency(symbol: '₸', decimalDigits: 0, locale: 'kk')
      .format(amount);
}

String formatDate(DateTime date, {String format: 'dd.MM.yyyy'}) {
  final DateFormat formatter = DateFormat(format);
  return formatter.format(date);
}

String timeAgo(DateTime date) {
  if (date == null) return '';
  // timeago.setLocaleMessages('ru', timeago.RuMessages());
  timeago.setLocaleMessages('ru_short', timeago.RuShortMessages());
  return timeago.format(date, locale: 'ru_short');
}

/// Форматирование цифр
String formatNum(dynamic amount) {
  return new NumberFormat.compact(locale: 'kk').format(amount);
}

void showPayBottomSheet(BuildContext context, Project project) async {
  final ChromeSafariBrowser browser =
      new MyChromeSafariBrowser(new MyInAppBrowser());

  var userCode = await auth.userCode();
  var referalCode = await auth.referalCode();
  var locale = appController.getLocale();

  await browser.open(
      url: Uri.parse(
          'https://meyirim.com/custom/payform/form?user_code=$userCode&referal_code=$referalCode&project_id=${project.id}&locale=$locale'),
      options: ChromeSafariBrowserClassOptions(
          android:
              AndroidChromeCustomTabsOptions(addDefaultShareMenuItem: false),
          ios: IOSSafariOptions(barCollapsingEnabled: true)));
  // showModalBottomSheet(
  //     context: context,
  //     backgroundColor: Colors.transparent,
  //     builder: (ctx) {
  //       return PayModal(project: project);
  //     });
}

class Rules {
  static final emailValidate = ValidationBuilder()
      .email('Введите E-mail'.tr)
      .maxLength(50, 'Неверный E-mail'.tr)
      .build();

  static final phoneValidate = ValidationBuilder()
      .required('Введите номер телефона'.tr)
      .regExp(RegExp(r'^\+7 \(([0-9]{3})\) ([0-9]{3})-([0-9]{2})-([0-9]{2})$'),
          'Неверный формат номера'.tr)
      .build();

  static final passwordValidate = ValidationBuilder()
      .required('Введите пароль'.tr)
      .minLength(6, 'Минимум 6 символов'.tr)
      .build();

  static final fullnameValidate =
      ValidationBuilder().minLength(1, 'Введите фамилию'.tr).build();

  static final messageValidate =
      ValidationBuilder().minLength(50, 'Минимум 50 символов'.tr).build();

  static final phoneFormatter = new MaskTextInputFormatter(
      mask: '+7 (###) ###-##-##', filter: {"#": RegExp(r'[0-9]')});
}

/// Share data
Future<String> makeReportUrl(report) async {
  var userCode = await auth.userCode();
  String url = await _createDynamicLink(
      config.SHARE_URL + '/?target=report&id=${report.id}&user_code=$userCode',
      true);
  return url;
}

Future<String> makeProjectUrl(project) async {
  var userCode = await auth.userCode();
  String url = await _createDynamicLink(
      config.SHARE_URL +
          '/?target=project&id=${project.id}&user_code=$userCode',
      true);
  return url;
}

Future shareReport(Report report) async {
  Get.snackbar('Загрузка'.tr, 'Пожалуйста подождите'.tr,
      backgroundColor: Colors.white);
  var link = await makeReportUrl(report);
  var title = report.getTranslated('title');
  await Share.share('$title $link');
}

Future shareProject(Project project) async {
  Get.snackbar('Загрузка'.tr, 'Пожалуйста подождите'.tr,
      backgroundColor: Colors.white);
  var link = await makeProjectUrl(project);
  var title = project.getTranslated('title');
  await Share.share('$title $link');
}

Future<String> _createDynamicLink(String link, bool short) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: config.DEEPLINK_PREFIX,
    link: Uri.parse(link),
    androidParameters: AndroidParameters(
      packageName: config.PACKAGE_NAME,
      minimumVersion: 0,
    ),
    dynamicLinkParametersOptions: DynamicLinkParametersOptions(
      shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
    ),
    iosParameters: IosParameters(
      bundleId: config.PACKAGE_NAME,
      minimumVersion: '0',
      appStoreId: config.APPSTORE_ID,
    ),
  );

  Uri url;
  if (short) {
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    url = shortLink.shortUrl;
  } else {
    url = await parameters.buildUrl();
  }

  return url.toString();
}

void initDynamicLinks() async {
  ProjectRepository projectRepository = new ProjectRepository();
  ReportRepository reportRepository = new ReportRepository();

  FirebaseDynamicLinks.instance.onLink(
      onSuccess: (PendingDynamicLinkData dynamicLink) async {
    final Uri deepLink = dynamicLink.link;

    if (deepLink != null) {
      if (deepLink.queryParameters.containsKey('target')) {
        switch (deepLink.queryParameters['target']) {
          case 'project':
            if (deepLink.queryParameters.containsKey('id') &&
                deepLink.queryParameters['id'] != null) {
              try {
                var project = await projectRepository
                    .findProject(deepLink.queryParameters['id']);
                var userCode = await auth.userCode();
                if (deepLink.queryParameters.containsKey('user_code') &&
                    deepLink.queryParameters['user_code'] != userCode) {
                  await auth
                      .setReferalCode(deepLink.queryParameters['user_code']);
                }
                Get.toNamed('/project', arguments: {'project': project});
              } catch (e) {
                print(e);
              }
            }
            break;

          case 'report':
            if (deepLink.queryParameters.containsKey('id') &&
                deepLink.queryParameters['id'] != null) {
              try {
                var report = await reportRepository
                    .findReport(deepLink.queryParameters['id']);
                var userCode = await auth.userCode();
                if (deepLink.queryParameters['user_code'] != null &&
                    deepLink.queryParameters['user_code'] != userCode) {
                  await auth
                      .setReferalCode(deepLink.queryParameters['user_code']);
                }
                Get.toNamed('/project', arguments: {'report': report});
              } catch (e) {
                print(e);
              }
            }
            break;
        }
      }

      if (deepLink.queryParameters['page'] != null) {
        print(deepLink.queryParameters);
        Get.toNamed(deepLink.queryParameters['page']);
      }
    }
  }, onError: (OnLinkErrorException e) async {
    print('onLinkError');
    print(e.message);
  });

  final PendingDynamicLinkData data =
      await FirebaseDynamicLinks.instance.getInitialLink();
  final Uri deepLink = data.link;

  if (deepLink != null) {
    if (deepLink.queryParameters.containsKey('target')) {
      switch (deepLink.queryParameters['target']) {
        case 'project':
          if (deepLink.queryParameters.containsKey('id') &&
              deepLink.queryParameters['id'] != null) {
            try {
              var project =
              await projectRepository.findProject(deepLink.queryParameters['id']);
              var userCode = await auth.userCode();
              if (deepLink.queryParameters.containsKey('user_code') &&
                  deepLink.queryParameters['user_code'] != userCode) {
                await auth
                    .setReferalCode(deepLink.queryParameters['user_code']);
              }
              Get.toNamed('/project', arguments: {'project': project});
            } catch (e) {
              print(e);
            }
          }
          break;

        case 'report':
          if (deepLink.queryParameters.containsKey('id') &&
              deepLink.queryParameters['id'] != null) {
            try {
              var report = await reportRepository
                  .findReport(deepLink.queryParameters['id']);
              var userCode = await auth.userCode();
              if (deepLink.queryParameters['user_code'] != null &&
                  deepLink.queryParameters['user_code'] != userCode) {
                await auth
                    .setReferalCode(deepLink.queryParameters['user_code']);
              }
              Get.toNamed('/project', arguments: {'report': report});
            } catch (e) {
              print(e);
            }
          }
          break;
      }
    }

    if (deepLink.queryParameters.containsKey('page') &&
        deepLink.queryParameters['page'] != null) {
      Get.toNamed(deepLink.queryParameters['page']);
    }
  }
}
