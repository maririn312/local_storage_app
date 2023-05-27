// // ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

// import 'dart:async';
// import 'dart:io';

// import 'package:api_cache_manager/api_cache_manager.dart';
// import 'package:api_cache_manager/models/cache_db_model.dart';
// import 'package:http/http.dart' as http;
// import 'package:abico_warehouse/data/db_provider.dart';
// import 'package:abico_warehouse/exceptions/bad_response_exception.dart';
// import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
// import 'package:abico_warehouse/language.dart';
// import 'package:abico_warehouse/models/dto/category/category_response_dto.dart';
// import 'package:abico_warehouse/models/entity/auth_entity/user_detail_entity.dart';

// import '../../../models/entity/auth_entity/user_entity.dart';

// class CategoryApiClient {
//   /* ============================================================================ */
//   /* ============================================================================ */
//   Future<CategoryResponseDto> getCategoryList({
//     String ip,
//   }) async {
//     http.Response response;
//     UserEntity user = await DBProvider.db.getUser();
//     UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();

//     bool isCacheExist = await APICacheManager().isAPICacheKeyExist("category");

//     if (!isCacheExist) {
//       // String url =
//       //     'http://${ip}/api/mobile.sync.config?session_id=${AppConst.SESSION}&query=${AppQuery.category_query}';
//       String url =
//           'http://${userDetailEntity.ip}/api/mobile.sync.config?filters=[["is_warehouse", "=", True]]';
//       print('url category giin  ${url}');
//       try {
//         response = await http.get(Uri.parse(url), headers: {
//           'Access-token': user.access_token,
//         });
//       } on SocketException {
//         throw RequestTimeoutException(url);
//       } on TimeoutException {
//         throw RequestTimeoutException(url);
//       }

//       print('======================');
//       print(response.statusCode);
//       print(response.body);
//       print('======================');

//       if (response.statusCode == 200 || response.statusCode == 202) {
//         APICacheDBModel cacheDBModel =
//             APICacheDBModel(key: "category", syncData: response.body);

//         await APICacheManager().addCacheData(cacheDBModel);
//         return CategoryResponseDto.fromRawJson(response.body);
//       } else if (response.statusCode == 401) {
//         return getCategoryList(
//           ip: ip,
//         );
//       }
//       throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
//     } else {
//       var cacheData = await APICacheManager().getCacheData("category");

//       return CategoryResponseDto.fromRawJson(cacheData.syncData);
//     }
//   }
// }

// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:abico_warehouse/models/entity/auth_entity/user_detail_entity.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/exceptions/bad_response_exception.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/category/category_response_dto.dart';

import '../../../models/entity/auth_entity/user_entity.dart';

class CategoryApiClient {
  Future<CategoryResponseDto> getCategoryList({String ip}) async {
    UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();
    UserEntity user = await DBProvider.db.getUser();
    final url =
        'http://${userDetailEntity.ip}/api/mobile.sync.config?filters=[["is_warehouse", "=", True]]';

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
