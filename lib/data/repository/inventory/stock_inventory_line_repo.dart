// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable, missing_return

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/inventory/stock_inventory_line_api_client.dart';
import 'package:abico_warehouse/models/dto/inventory/stock_inventory_line_response_dto.dart';
import 'package:abico_warehouse/models/entity/stock_entity/inventory/stock_inventory_line_entity.dart';

class StockInventoryLineRepository {
  final StockInventoryLineApiClient stockInventoryLineApiClient;

  StockInventoryLineRepository({@required this.stockInventoryLineApiClient});

  Future<StockInventoryLineResponseDto> getStockInventoryLineList({
    String ip,
  }) async {
    StockInventoryLineResponseDto stockPickingLineDto =
        await stockInventoryLineApiClient.getStockInventoryLineList(ip);

    if (stockPickingLineDto != null) {
      await DBProvider.db.deleteInventoryLine();
      for (int i = 0; i < stockPickingLineDto.results.length; i++) {
        await DBProvider.db.newInventoryLine(StockInventoryLineEntity(
          id: stockPickingLineDto.results[i].id,
          theoreticalQty:
              stockPickingLineDto.results[i].theoreticalQty.toDouble(),
          barcode: stockPickingLineDto.results[i].barcode,
          productName: stockPickingLineDto.results[i].productName,
        ));
      }
    }
    return stockInventoryLineApiClient.getStockInventoryLineList(
      ip,
    );
  }
}
