// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/exceptions/bad_response_exception.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/hr/hr_response_dto.dart';

class HrApiClient {
  Future<HrResponseDto> getHrList(String uid) async {
    final user = await DBProvider.db.getUser();

    final url =
        'http://${user.ip}/api/hr.employee?filters=[["user_id","=",${user.uid}]]';

    if (kDebugMode) {
      print('uid hed irj bn hary $uid');
      print('url: $url');
    }

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Access-token': user.access_token,
      });

      if (response.statusCode == 200 || response.statusCode == 202) {
        return HrResponseDto.fromRawJson(response.body);
      } else if (response.statusCode == 401) {
        return getHrList(uid);
      } else {
        throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
      }
    } on SocketException {
      throw RequestTimeoutException(url);
    } on TimeoutException {
      throw RequestTimeoutException(url);
    }
  }
}
