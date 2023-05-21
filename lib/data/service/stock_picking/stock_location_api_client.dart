// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/exceptions/bad_response_exception.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_location_response_dto.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_entity.dart';

class StockLocationApiClient {
  /* ============================================================================ */
  /* ============================================================================ */
  Future<StockLocationResponseDto> getStockLocation(
      String ip, String sessionId) async {
    http.Response response;

    UserEntity user = await DBProvider.db.getUser();
    // UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();

    // String url =
    //     'http://$ip/api/stock.location?session_id=${AppConst.SESSION}&query=${AppQuery.stock_location_query}';
    String url = 'http://${user.ip}/api/stock.location';
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
    print('location id irj bnu haryoo');
    print(response.statusCode);
    print(response.body);
    print('======================');

    if (response.statusCode == 200 || response.statusCode == 202) {
      return StockLocationResponseDto.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      return getStockLocation(ip, sessionId);
    }
    throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
  }
}
