// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/put/stock_Inventory_line_put_api_client.dart';
import 'package:abico_warehouse/models/dto/put/message_response_dto.dart';

class StockInventoryLinePutRepository {
  final StockInventoryLinePutApiClient stockInventoryLinePutApiClient;

  StockInventoryLinePutRepository(
      {@required this.stockInventoryLinePutApiClient});

  Future<MessageResponseDto> getStockInventoryLinePutList({
    String ip,
    String id,
    String time,
  }) async {
    // await DBProvider.db.deleteUserAttendOff();
    // await DBProvider.db.newUserAttendOff(
    //     UserAttendOffEntity(id: 0, sendTime: DateTime.now().toString()));

    return stockInventoryLinePutApiClient.getStockInventoryLinePutList(
        ip, id, time);
  }
}
