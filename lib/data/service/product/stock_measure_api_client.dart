// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:api_cache_manager/api_cache_manager.dart';
import 'package:api_cache_manager/models/cache_db_model.dart';
import 'package:http/http.dart' as http;
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/exceptions/bad_response_exception.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/product/stock_measure_response_dto.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_detail_entity.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_entity.dart';

class StockMeasureApiClient {
  /* ============================================================================ */
  /* ============================================================================ */
  Future<StockMeasureResponseDto> getStockMeasure(
      String ip, String sessionId) async {
    http.Response response;
    UserEntity user = await DBProvider.db.getUser();
    UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();

    bool isCacheExist =
        await APICacheManager().isAPICacheKeyExist("stockMeasure");

    if (!isCacheExist) {
      // String url =
      //     'http://$ip/api/uom.uom?session_id=${AppConst.SESSION}&query=${AppQuery.stock_measure_query}';
      String url = 'http://${userDetailEntity.ip}/api/uom.uom';
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
            APICacheDBModel(key: "stockMeasure", syncData: response.body);

        await APICacheManager().addCacheData(cacheDBModel);
        return StockMeasureResponseDto.fromRawJson(response.body);
      } else if (response.statusCode == 401) {
        return getStockMeasure(ip, sessionId);
      }
      throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
    } else {
      var cacheData = await APICacheManager().getCacheData("stockMeasure");

      return StockMeasureResponseDto.fromRawJson(cacheData.syncData);
    }
  }
}
