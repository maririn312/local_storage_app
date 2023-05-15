// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/post/stock_inventory_line_history_post_client.dart';
import 'package:abico_warehouse/models/dto/put/message_response_dto.dart';

class StockInventoryLineHistoryPostRepository {
  final StockInventoryLineHistoryPostApiClient
      stockInventoryLineHistoryPostApiClient;

  StockInventoryLineHistoryPostRepository(
      {@required this.stockInventoryLineHistoryPostApiClient});

  Future<MessageResponseDto> getStockInventoryLineHistoryPostList({
    String ip,
    String id,
    String time,
  }) async {
    // await DBProvider.db.deleteUserAttendOff();
    // await DBProvider.db.newUserAttendOff(
    //     UserAttendOffEntity(id: 0, sendTime: DateTime.now().toString()));

    return stockInventoryLineHistoryPostApiClient
        .getStockInventoryLineHistoryPostList(ip, id, time);
  }
}
