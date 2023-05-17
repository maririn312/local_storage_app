// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/exceptions/bad_response_exception.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/category/category_response_dto.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_detail_entity.dart';

import '../../../models/entity/auth_entity/user_entity.dart';

class CategoryApiClient {
  /* ============================================================================ */
  /* ============================================================================ */
  Future<CategoryResponseDto> getCategoryList({
    String ip,
  }) async {
    http.Response response;
    UserEntity user = await DBProvider.db.getUser();

    String url =
        'http://${user.ip}/api/mobile.sync.config?filters=[["parent_id", "=", False]]';
    print('url category giin  ${url}');
    try {
      response = await http.get(Uri.parse(url), headers: {
        'Access-token': user.access_token,
      });
    } on SocketException {
      throw RequestTimeoutException(url);
    } on TimeoutException {
      throw RequestTimeoutException(url);
    }

    print('======================');
    print(response.statusCode);
    print(response.body);
    print('======================');

    if (response.statusCode == 200 || response.statusCode == 202) {
      return CategoryResponseDto.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      return getCategoryList(
        ip: ip,
      );
    }
    throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
  }
}
