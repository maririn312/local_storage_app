import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/put/stock_picking_is_checked_put_api_client%20.dart';
import 'package:abico_warehouse/models/dto/put/stock_picking_put_response_dto.dart';

class StockPickingIsActivePutRepository {
  final StockPickingIsActivePutApiClient stockPickingIsActivePutApiClient;

  StockPickingIsActivePutRepository(
      {@required this.stockPickingIsActivePutApiClient});

  Future<StockPickingPutResponseDto> getStockPickingIsActivePutList({
    String id,
  }) async {
    // await DBProvider.db.deleteUserAttendOff();
    // await DBProvider.db.newUserAttendOff(
    //     UserAttendOffEntity(id: 0, sendTime: DateTime.now().toString()));

    return stockPickingIsActivePutApiClient.getStockPickingIsActivePutList(
      id,
    );
  }
}
