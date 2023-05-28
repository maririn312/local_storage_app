// ignore_for_file: unnecessary_null_comparison, lines_longer_than_80_chars, unused_import, avoid_print, prefer_is_empty, directives_ordering

import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_storage_app/exceptions/exception_manager.dart';

import '../language.dart';

class TengerUtility {
  /* ================================================================================== */
  /* ================================================================================== */
  static bool checkVersion(String version, String miminumVersion) {
    try {
      List<String> versionNums = version.split('.');
      List<String> minimumNums = miminumVersion.split('.');

      int versionNum = 0;
      int minimumNum = 0;

      versionNum += 1000000 * int.parse(versionNums[0]);
      versionNum += 1000 * int.parse(versionNums[1]);
      versionNum += 1 * int.parse(versionNums[2]);

      minimumNum += 1000000 * int.parse(minimumNums[0]);
      minimumNum += 1000 * int.parse(minimumNums[1]);
      minimumNum += 1 * int.parse(minimumNums[2]);

      return minimumNum <= versionNum;
    } catch (ex, stacktrace) {
      ExceptionManager.xMan.captureException(ex, stacktrace);
      return false;
    }
  }

  /* ================================================================================== */
  /* ================================================================================== */
  static String mnNameFormat(String lastName, String firstName) {
    StringBuffer stringBuffer = StringBuffer();
    if (lastName.length < 1) {
      stringBuffer.write('н.');
    } else {
      stringBuffer.write('${lastName[0]}.');
    }
    if (firstName.length < 1) {
      stringBuffer.write('хэрэглэгч');
    } else {
      stringBuffer.write(firstName);
    }
    return stringBuffer.toString();
  }

  static String removeZero(String str) {
    int i = 0;
    for (; i < str.length; i++) {
      if (str[i] != '0') break;
    }
    return str.substring(i, str.length);
  }

  static String putZero(int time) => (time < 10) ? '0$time' : time.toString();

  /* ================================================================================== */
  /* ================================================================================== */
  static String getDateAsLocal(
    String date, {
    bool hasTime = false,
    bool onlyTime = false,
    bool withoutYear = false,
  }) {
    DateTime dateTime = DateTime.parse(date).toLocal();
    String dateTimeStr;

    if (withoutYear) {
      dateTimeStr = '${putZero(dateTime.month)}-${putZero(dateTime.day)}';
    } else {
      dateTimeStr =
          '${dateTime.year}-${putZero(dateTime.month)}-${putZero(dateTime.day)}';
    }

    if (hasTime) {
      String time = '${putZero(dateTime.hour)}:${putZero(dateTime.minute)}';
      if (onlyTime) {
        return time;
      } else {
        dateTimeStr += ' $time';
        return dateTimeStr;
      }
    }
    return dateTimeStr;
  }

  /* ================================================================================== */
  /* ================================================================================== */
  static bool isNumeric(String s) {
    if (s != null) {
      return true;
    }
    return double.tryParse(s) == null;
  }

  static final RegExp nameRegExp = RegExp('[a-zA-Z0-9]');

  static RegExp isValidIp(String ip) => RegExp(
      r'^[[0-9]{0,8}(\.[0-9]{1,4})?$|^[[0-9]{0,9}(\.[0-9]{1,3})?$|^[[0-9]{0,10}(\.[0-9]{1,2})?$|^[[0-9]{0,11}(\.[0-9]{1})?$|^[0-9]{0,12}');

  /* ================================================================================== */
  /* ================================================================================== */
  static bool isValidEmail(String email) => RegExp(
          r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
      .hasMatch(email);

  // static getHdr() => Hdr(appVersion: AppConst.APP_VERSION, deviceId: RainGlobal.DEVICE_ID);

  /* ================================================================================== */
  /* ================================================================================== */
  static showDialog(text) {
    // Fluttertoast.showToast(
    //     msg: text,
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.CENTER,
    //     backgroundColor: const Color(0xff4dd8f8),
    //     textColor: Colors.white,
    //     fontSize: 16.0);
  }

  /* ================================================================================== */
  /* ================================================================================== */
  static List<String> splitStringByLength(String str, int length) {
    int trimStart = 0;
    int trimEnd = length;
    List<String> list = [];

    while (str.length > 0) {
      if (str.length < trimEnd) {
        trimEnd = str.length;
        String a = str.substring(trimStart, trimEnd);
        list.add(a);
        break;
      }
      String a = str.substring(trimStart, trimEnd);
      list.add(a);
      trimStart = trimEnd - 1;
      trimEnd += length;
    }

    return list;
  }

  /* ================================================================================== */
  /* ================================================================================== */
  static Color hexToColor(String code) =>
      Color(int.parse(code, radix: 16) + 0xFF000000);

  /* ================================================================================== */
  /* ================================================================================== */
  static List<String> extractNickname(String nickname) {
    if (nickname == null) return ['_', '000'];
    return nickname.split("@");
  }
}
