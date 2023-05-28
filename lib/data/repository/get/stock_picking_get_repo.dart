import 'package:local_storage_app/data/service/get/stock_picking_get_api_client%20.dart';
import 'package:local_storage_app/models/dto/get/stock_picking_get_dto_detail.dart';
import 'package:flutter/material.dart';

class StockPickingGetRepository {
  final StockPickingGetApiClient stockPickingGetApiClient;

  StockPickingGetRepository({@required this.stockPickingGetApiClient});

  Future<StockPickingGetResult> getStockPickingGetList({
    @required String id,
    @required String checkUser,
  }) async {
    StockPickingGetResult responseDto =
        await stockPickingGetApiClient.getStockPickingGetList(id, checkUser);
    return responseDto;
  }
}
