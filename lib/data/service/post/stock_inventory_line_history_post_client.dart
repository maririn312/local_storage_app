// ignore: file_names
// ignore_for_file: avoid_print, unused_import, unused_local_variable, non_constant_identifier_names, file_names, duplicate_ignore, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/exceptions/bad_response_exception.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/put/message_response_dto.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_detail_entity.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_entity.dart';

class StockInventoryLineHistoryPostApiClient {
  Future<MessageResponseDto> getStockInventoryLineHistoryPostList(
    String ip,
    String id,
    String time,
  ) async {
    http.Response response;
    UserEntity user = await DBProvider.db.getUser();
    UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();
    int lineId = int.parse(ip);
    int qty = int.parse(time);
    String url = 'http://${user.ip}/api/stock.inventory.line.history';
    print('end url irnee $url');
    try {
      response = await http.post(Uri.parse(url), headers: {
        'Access-token': user.access_token,
        'Content-Type': 'text/plain'
      }, body: '''{\n
               "user_id":${user.uid},\n
               "qty":$qty,\n
               "inventory_line_id":$lineId
               \n}\n''');
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
