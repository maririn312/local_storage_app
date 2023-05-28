import 'package:flutter/cupertino.dart';
import 'package:local_storage_app/data/service/put/stock_move_put_api_client.dart';
import 'package:local_storage_app/models/dto/put/message_response_dto.dart';

class StockMovePutRepository {
  final StockMovePutApiClient stockMovePutApiClient;

  StockMovePutRepository({@required this.stockMovePutApiClient});

  Future<MessageResponseDto> getStockMovePutList({
    String ip,
    String id,
    String time,
  }) async {
    return stockMovePutApiClient.getStockMovePutList(ip, id, time);
  }
}
