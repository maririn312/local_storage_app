// ignore: file_names
// ignore_for_file: avoid_print, unused_import, unused_local_variable, non_constant_identifier_names, file_names, duplicate_ignore

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/exceptions/bad_response_exception.dart';
import 'package:local_storage_app/exceptions/request_timeout_exception.dart';
import 'package:local_storage_app/language.dart';
import 'package:local_storage_app/models/dto/put/message_response_dto.dart';
import 'package:local_storage_app/models/entity/auth_entity/user_detail_entity.dart';
import 'package:local_storage_app/models/entity/auth_entity/user_entity.dart';

class StockInventoryLinePutApiClient {
  Future<MessageResponseDto> getStockInventoryLinePutList(
    String ip,
    String id,
    String time,
  ) async {
    http.Response response;
    UserEntity user = await DBProvider.db.getUser();
    UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();

    var form_id = int.parse(id);
    int too = int.parse(time);

    String url =
        'http://${userDetailEntity.ip}/api/stock.inventory.line/$form_id?product_qty=$too';
    print('end url irnee $url');
    try {
      response = await http.put(
        Uri.parse(url),
        headers: {
          'Access-token': user.access_token,
        },
      );
    } on SocketException {
      throw RequestTimeoutException(url);
    } on TimeoutException {
      throw RequestTimeoutException(url);
    }

    print('======================');
    print(id);
    print(time);
    print(response.statusCode);
    print('end id g hevlene ${user.uid}');
    print(response.body);
    print('======================');

    if (response.statusCode == 200 || response.statusCode == 202) {
      return MessageResponseDto.fromRawJson(response.body);
    }
    throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
  }
}
