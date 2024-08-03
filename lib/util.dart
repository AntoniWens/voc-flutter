import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class Util {
  static String formatMMSS(int seconds) {
    seconds = (seconds % 3600).truncate();
    int minutes = (seconds / 60).truncate();

    String minutesStr = (minutes).toString().padLeft(2, '0');
    String secondsStr = (seconds % 60).toString().padLeft(2, '0');

    return "$minutesStr:$secondsStr";
  }

  static String generateChar(int length) {
    const _chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random _rnd = Random();

    return String.fromCharCodes(Iterable.generate(
        length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
  }

  static String currentDateTime(bool isDate) {
    return DateFormat(isDate ? 'dd MMMM yyyy' : 'HH:MM').format(DateTime.now());
  }
}
