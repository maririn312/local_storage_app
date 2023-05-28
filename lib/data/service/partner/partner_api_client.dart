// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:http/http.dart' as http;
import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/exceptions/bad_response_exception.dart';
import 'package:local_storage_app/exceptions/request_timeout_exception.dart';
import 'package:local_storage_app/language.dart';
import 'package:local_storage_app/models/dto/partner/partner_response_dto.dart';
import 'package:local_storage_app/models/entity/auth_entity/user_detail_entity.dart';
import 'package:local_storage_app/models/entity/auth_entity/user_entity.dart';

class PartnerApiClient {
  /* ============================================================================ */
  /* ============================================================================ */
  Future<PartnerResponseDto> getPartnerList(String ip, String sessionId) async {
    http.Response response;
    UserEntity user = await DBProvider.db.getUser();
    UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();

    bool isCacheExist =
        await APICacheManager().isAPICacheKeyExist("partnerList");

    if (!isCacheExist) {
      // String url =
      //     'http://$ip/api/res.partner?session_id=${AppConst.SESSION}&query=${AppQuery.partner_query}';
      String url = 'http://${userDetailEntity.ip}/api/res.partner';
      print(url);
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
        APICacheDBModel cacheDBModel =
            APICacheDBModel(key: "partnerList", syncData: response.body);

        await APICacheManager().addCacheData(cacheDBModel);
        return PartnerResponseDto.fromRawJson(response.body);
      } else if (response.statusCode == 401) {
        return getPartnerList(ip, sessionId);
      }
      throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
    } else {
      var cacheData = await APICacheManager().getCacheData("partnerList");

      return PartnerResponseDto.fromRawJson(cacheData.syncData);
    }
  }
}
