// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_picking_type_api_client.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_picking_type_dto.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_picking_type_entity.dart';

class StockPickingTypeRepository {
  final StockPickingTypeApiClient stockPickingTypeApiClient;

  StockPickingTypeRepository({@required this.stockPickingTypeApiClient});

  Future<StockPickingTypeResponseDto> getStockPickingTypeList({
    String ip,
  }) async {
    StockPickingTypeResponseDto stockPickingLineDto =
        await stockPickingTypeApiClient.getStockPickingTypeList(ip);

    if (stockPickingLineDto != null) {
      await DBProvider.db.deleteStockPickingType();
      for (int i = 0; i < stockPickingLineDto.results.length; i++) {
        await DBProvider.db.newStockPickingType(StockPickingTypeEntity(
          id: stockPickingLineDto.results[i].id,
          name: stockPickingLineDto.results[i].name,
          code: stockPickingLineDto.results[i].code,
        ));
      }
    }
    return stockPickingTypeApiClient.getStockPickingTypeList(
      ip,
    );
  }
}
