import 'dart:math';

import 'package:flutter/cupertino.dart';
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

  static Map<String, dynamic> currentDateTime() {
    DateTime dateTime = DateTime.now();
    String date = DateFormat('dd MMMM yy').format(dateTime);
    String time = DateFormat('HH:mm').format(dateTime);
    String timeStamp = DateFormat('yyyy-mm-dd HH:mm').format(dateTime);
    return {
      'date': date,
      'time': time,
      'time_stamp': timeStamp
    };
  }

  static Map<String, double> queryImageSize(BuildContext context, double width, double height) {
    double fullWidth = MediaQuery.sizeOf(context).width - (MediaQuery.sizeOf(context).width * 0.4);
    double realWidth = width > fullWidth ? fullWidth : width;
    double realHeight = (width == height) ? realWidth : (height < 260) ? height : 260;
    return {'width': realWidth, 'height': realHeight};
  }
}
