// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:local_storage_app/data/service/post/stock_inventory_line_history_post_client.dart';
import 'package:local_storage_app/models/dto/put/message_response_dto.dart';

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
    return stockInventoryLineHistoryPostApiClient
        .getStockInventoryLineHistoryPostList(ip, id, time);
  }
}
