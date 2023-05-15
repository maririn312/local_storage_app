import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/put/stock_picking_put_api_client.dart';
import 'package:abico_warehouse/models/dto/put/message_response_dto.dart';

class StockPickingPutRepository {
  final StockPickingPutApiClient stockPickingPutApiClient;

  StockPickingPutRepository({@required this.stockPickingPutApiClient});

  Future<MessageResponseDto> getStockPickingPutList({
    String ip,
    String id,
    String time,
  }) async {
    // await DBProvider.db.deleteUserAttendOff();
    // await DBProvider.db.newUserAttendOff(
    //     UserAttendOffEntity(id: 0, sendTime: DateTime.now().toString()));

    return stockPickingPutApiClient.getStockPickingPutList(ip, id, time);
  }
}
