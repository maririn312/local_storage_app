// ignore_for_file: avoid_print, unused_import, unused_local_variable, unnecessary_brace_in_string_interps, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/exceptions/bad_response_exception.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/inventory/stock_inventory_line_response_dto.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_move_dto.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_detail_entity.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_entity.dart';

class StockInventoryLineApiClient {
  Future<StockInventoryLineResponseDto> getStockInventoryLineList(
    String ip,
  ) async {
    http.Response response;
    UserEntity user = await DBProvider.db.getUser();
    UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();

    // String url =
    //     'http://${userDetailEntity.ip}/api/stock.inventory.line?filters=[["state", "=", "confirm"]]';
    String url =
        'http://${userDetailEntity.ip}/api/stock.inventory.line?filters=[["state", "=", "confirm"]]';
    print(' url :  $url ');
    try {
      response = await http.get(Uri.parse(url), headers: {
        'Access-token': user.access_token,
      });
    } on SocketException {
      throw RequestTimeoutException(url);
    } on TimeoutException {
      throw RequestTimeoutException(url);
    }

    if (response.statusCode == 200 || response.statusCode == 202) {
      return StockInventoryLineResponseDto.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      return getStockInventoryLineList(
        ip,
      );
    }
    throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
  }
}
