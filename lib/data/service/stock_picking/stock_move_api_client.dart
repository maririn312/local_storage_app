// ignore_for_file: avoid_print, unused_import, unused_local_variable, unnecessary_brace_in_string_interps

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/exceptions/bad_response_exception.dart';
import 'package:local_storage_app/exceptions/request_timeout_exception.dart';
import 'package:local_storage_app/language.dart';
import 'package:local_storage_app/models/dto/stock_picking/stock_move_dto.dart';
import 'package:local_storage_app/models/entity/auth_entity/user_detail_entity.dart';
import 'package:local_storage_app/models/entity/auth_entity/user_entity.dart';

class StockMoveLineApiClient {
  Future<StockMoveLineResponseDto> getStockMoveLineList(
    String ip,
  ) async {
    http.Response response;
    UserEntity user = await DBProvider.db.getUser();
    UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();

    String url =
        'http://${userDetailEntity.ip}/api/stock.move?filters=[["picking_id", "!=", False],["state", "not in", ["cancel","done"]]]';
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
      return StockMoveLineResponseDto.fromRawJson(response.body);
    } else if (response.statusCode == 401) {
      return getStockMoveLineList(
        ip,
      );
    }
    throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
  }
}
