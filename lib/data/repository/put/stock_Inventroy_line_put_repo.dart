// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:local_storage_app/data/service/put/stock_Inventory_line_put_api_client.dart';
import 'package:local_storage_app/models/dto/put/message_response_dto.dart';

class StockInventoryLinePutRepository {
  final StockInventoryLinePutApiClient stockInventoryLinePutApiClient;

  StockInventoryLinePutRepository(
      {@required this.stockInventoryLinePutApiClient});

  Future<MessageResponseDto> getStockInventoryLinePutList({
    String ip,
    String id,
    String time,
  }) async {
    return stockInventoryLinePutApiClient.getStockInventoryLinePutList(
        ip, id, time);
  }
}
