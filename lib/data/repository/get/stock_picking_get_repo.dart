import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/get/stock_picking_get_api_client%20.dart';
import 'package:abico_warehouse/models/dto/get/stock_picking_get_dto_detail.dart';

class StockPickingGetRepository {
  final StockPickingGetApiClient stockPickingGetApiClient;

  StockPickingGetRepository({@required this.stockPickingGetApiClient});

  Future<StockPickingGetResult> getStockPickingGetList({
    String id,
    String checkUser,
  }) async {
    StockPickingGetResult responseDto =
        await stockPickingGetApiClient.getStockPickingGetList(id, checkUser);
    if (responseDto != null) {}
    return stockPickingGetApiClient.getStockPickingGetList(
      id,
      checkUser,
    );
  }
}
