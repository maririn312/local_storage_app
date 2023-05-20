// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/exceptions/bad_response_exception.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/category/category_response_dto.dart';

class CategoryApiClient {
  Future<CategoryResponseDto> getCategoryList({String ip}) async {
    final user = await DBProvider.db.getUser();
    final url =
        'http://${user.ip}/api/mobile.sync.config?filters=[["is_warehouse", "=", True]]';

    if (kDebugMode) {
      print('url category: $url');
    }

    try {
      final response = await http.get(Uri.parse(url), headers: {
        'Access-token': user.access_token,
      });

      if (kDebugMode) {
        print('======================');
        print(response.statusCode);
        print(response.body);
        print('======================');
      }

      if (response.statusCode == 200 || response.statusCode == 202) {
        return CategoryResponseDto.fromRawJson(response.body);
      } else if (response.statusCode == 401) {
        return getCategoryList(ip: ip);
      }
    } on SocketException {
      throw RequestTimeoutException(url);
    } on TimeoutException {
      throw RequestTimeoutException(url);
    }

    throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
  }
}
