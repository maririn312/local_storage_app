// ignore_for_file: avoid_print, unused_import, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:local_storage_app/models/dto/stock_picking/stock_picking_dto.dart';
import 'package:http/http.dart' as http;

import '../../../exceptions/bad_response_exception.dart';
import '../../../exceptions/request_timeout_exception.dart';
import '../../../language.dart';
import '../../../models/entity/auth_entity/user_detail_entity.dart';
import '../../../models/entity/auth_entity/user_entity.dart';
import '../../db_provider.dart';

class StockPickingApiClient {
  Future<StockPickingResponseDto> getStockPickingList(
    String ip,
  ) async {
    http.Response response;

    UserEntity user = await DBProvider.db.getUser();
    UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();

    String url =
        'http://${userDetailEntity.ip}/api/stock.picking?filters=[["state", "=", "assigned"],["is_checked","!=","checked"],["partner_id","!=",False]]';

    // String url =
    //     'http://${userDetailEntity.ip}/api/stock.picking?filters=[["state", "=", "assigned"],["is_checked","!=","checked"],["picking_type_id","=",2]]';
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
      return StockPickingResponseDto.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      return getStockPickingList(ip);
    }
    throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
  }
}
