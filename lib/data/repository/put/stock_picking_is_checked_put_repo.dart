import 'package:flutter/cupertino.dart';
import 'package:local_storage_app/data/service/put/stock_picking_is_checked_put_api_client%20.dart';
import 'package:local_storage_app/models/dto/put/stock_picking_put_response_dto.dart';

class StockPickingIsActivePutRepository {
  final StockPickingIsActivePutApiClient stockPickingIsActivePutApiClient;

  StockPickingIsActivePutRepository(
      {@required this.stockPickingIsActivePutApiClient});

  Future<StockPickingPutResponseDto> getStockPickingIsActivePutList({
    String id,
  }) async {
    return stockPickingIsActivePutApiClient.getStockPickingIsActivePutList(
      id,
    );
  }
}
