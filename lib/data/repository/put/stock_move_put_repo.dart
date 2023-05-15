import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/put/stock_move_put_api_client.dart';
import 'package:abico_warehouse/models/dto/put/message_response_dto.dart';

class StockMovePutRepository {
  final StockMovePutApiClient stockMovePutApiClient;

  StockMovePutRepository({@required this.stockMovePutApiClient});

  Future<MessageResponseDto> getStockMovePutList({
    String ip,
    String id,
    String time,
  }) async {
    // await DBProvider.db.deleteUserAttendOff();
    // await DBProvider.db.newUserAttendOff(
    //     UserAttendOffEntity(id: 0, sendTime: DateTime.now().toString()));

    return stockMovePutApiClient.getStockMovePutList(ip, id, time);
  }
}
