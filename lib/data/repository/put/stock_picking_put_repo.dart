import 'package:flutter/cupertino.dart';
import 'package:local_storage_app/data/service/put/stock_picking_put_api_client.dart';
import 'package:local_storage_app/models/dto/put/message_response_dto.dart';

class StockPickingPutRepository {
  final StockPickingPutApiClient stockPickingPutApiClient;

  StockPickingPutRepository({@required this.stockPickingPutApiClient});

  Future<MessageResponseDto> getStockPickingPutList({
    String ip,
    String id,
    String time,
  }) async {
    return stockPickingPutApiClient.getStockPickingPutList(ip, id, time);
  }
}
