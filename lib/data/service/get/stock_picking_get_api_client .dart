// ignore_for_file: avoid_print, unused_import, unused_local_variable, non_constant_identifier_names, file_names

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/exceptions/bad_response_exception.dart';
import 'package:local_storage_app/exceptions/request_timeout_exception.dart';
import 'package:local_storage_app/language.dart';
import 'package:local_storage_app/models/dto/get/stock_picking_get_dto_detail.dart';
import 'package:local_storage_app/models/dto/put/message_response_dto.dart';
import 'package:local_storage_app/models/entity/auth_entity/user_detail_entity.dart';
import 'package:local_storage_app/models/entity/auth_entity/user_entity.dart';

class StockPickingGetApiClient {
  Future<StockPickingGetResult> getStockPickingGetList(
    String id,
    String checkUser,
  ) async {
    http.Response response;
    UserEntity user = await DBProvider.db.getUser();
    UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();

    var form_id = int.parse(id);

    // String url = 'http://${userDetailEntity.ip}/api/stock.picking/$form_id';
    String url =
        'http://${userDetailEntity.ip}/api/stock.picking/$form_id/action_check_user_id?pick_id=$form_id&user_id=${user.uid}';
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
    print('end hevleed l bga bhda');
    print(form_id);
    print(response.statusCode);
    print('end id g hevlene ${user.uid}');
    print(response.body);
    print('======================');

    if (response.statusCode == 200 || response.statusCode == 202) {
      return StockPickingGetResult.fromRawJson(response.body);
    }
    throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
  }
}
