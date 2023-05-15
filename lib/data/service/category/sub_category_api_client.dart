// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/exceptions/bad_response_exception.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/category/sub_category_response_dto.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_detail_entity.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_entity.dart';

class SubCategoryApiClient {
  /* ============================================================================ */
  /* ============================================================================ */
  Future<SubCategoryResponseDto> getSubCategoryList(
    String ip,
  ) async {
    http.Response response;
    UserEntity user = await DBProvider.db.getUser();
    UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();

    String url = 'http://${userDetailEntity.ip}/api/mobile.sync.config';

    // String url =
    //     'http://49.0.129.18:9393/api/mobile.sync.config?filters=[["id","=",15]]';
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
      return SubCategoryResponseDto.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      return getSubCategoryList(ip);
    }
    throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
  }
}
