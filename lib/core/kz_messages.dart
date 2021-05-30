import 'package:timeago/src/messages/lookupmessages.dart';

/// Kazakh messages
class KzMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => 'бұрын';
  @override
  String suffixFromNow() => 'соң';
  @override
  String lessThanOneMinute(int seconds) => 'минутан';
  @override
  String aboutAMinute(int minutes) => 'минут';
  @override
  String minutes(int minutes) => '$minutes ${_convert(minutes, 'minutes')}';
  @override
  String aboutAnHour(int minutes) => 'сағат';
  @override
  String hours(int hours) => '$hours ${_convert(hours, 'hours')}';
  @override
  String aDay(int hours) => 'күн';
  @override
  String days(int days) => '$days ${_convert(days, 'days')}';
  @override
  String aboutAMonth(int days) => 'ай';
  @override
  String months(int months) => '$months ${_convert(months, 'months')}';
  @override
  String aboutAYear(int year) => 'жыл';
  @override
  String years(int years) => '$years ${_convert(years, 'years')}';
  @override
  String wordSeparator() => ' ';

  String _convert(int number, String type) {
    var mod = number % 10;
    var modH = number % 100;

    if (mod == 1 && modH != 11) {
      switch (type) {
        case 'minutes':
          return 'минуттан';
        case 'hours':
          return 'час';
        case 'days':
          return 'күн';
        case 'months':
          return 'ай';
        case 'years':
          return 'жыл';
        default:
          return '';
      }
    } else if (<int>[2, 3, 4].contains(mod) &&
        !<int>[12, 13, 14].contains(modH)) {
      switch (type) {
        case 'minutes':
          return 'минут';
        case 'hours':
          return 'сағат';
        case 'days':
          return 'күн';
        case 'months':
          return 'ай';
        case 'years':
          return 'жыл';
        default:
          return '';
      }
    }
    switch (type) {
      case 'minutes':
        return 'минут';
      case 'hours':
        return 'сағат';
      case 'days':
        return 'күн';
      case 'months':
        return 'ай';
      case 'years':
        return 'жыл';
      default:
        return '';
    }
  }
}

class KzShortMessages implements LookupMessages {
  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => '';
  @override
  String suffixFromNow() => '';
  @override
  String lessThanOneMinute(int seconds) => 'қазір ғана';
  @override
  String aboutAMinute(int minutes) => '1 мин.';
  @override
  String minutes(int minutes) => '$minutes мин.';
  @override
  String aboutAnHour(int minutes) => '~1 с.';
  @override
  String hours(int hours) => '$hours с.';
  @override
  String aDay(int hours) => '~1 к.';
  @override
  String days(int days) => '$days к.';
  @override
  String aboutAMonth(int days) => '~1 ай.';
  @override
  String months(int months) => '$months ай.';
  @override
  String aboutAYear(int year) => '~1 ж.';
  @override
  String years(int years) => '$years ж.';
  @override
  String wordSeparator() => ' ';
}
