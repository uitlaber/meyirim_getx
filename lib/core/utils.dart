import 'dart:ui';

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:meyirim/core/config.dart' as config;
import 'package:meyirim/core/service/auth.dart' as auth;
import 'package:meyirim/models/project.dart';
import 'package:meyirim/models/report.dart';
import 'package:share/share.dart';

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
  return new NumberFormat.currency(symbol: '₸', decimalDigits: 0, locale: 'kk')
      .format(amount);
}

String formatDate(DateTime date, {String format: 'dd.MM.yyyy'}) {
  final DateFormat formatter = DateFormat(format);
  return formatter.format(date);
}

/// Форматирование цифр
String formatNum(dynamic amount) {
  return new NumberFormat.compact(locale: 'kk').format(amount);
}

void showPayBottomSheet(context, project) {}

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
  var link = await makeReportUrl(report);
  var title = report.title;
  await Share.share('$title $link');
}

Future shareProject(Project project) async {
  var link = await makeProjectUrl(project);
  var title = project.title;
  await Share.share('$title $link');
}

Future<String> _createDynamicLink(String link, bool short) async {
  final DynamicLinkParameters parameters = DynamicLinkParameters(
    uriPrefix: 'https://meyirim.page.link',
    link: Uri.parse(link),
    androidParameters: AndroidParameters(
      packageName: 'com.beyit.meyirim',
      minimumVersion: 0,
    ),
    dynamicLinkParametersOptions: DynamicLinkParametersOptions(
      shortDynamicLinkPathLength: ShortDynamicLinkPathLength.short,
    ),
    iosParameters: IosParameters(
      bundleId: 'com.beyit.meyirim',
      minimumVersion: '0',
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
