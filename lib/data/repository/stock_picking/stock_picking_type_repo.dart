import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_picking_type_api_client.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_picking_type_dto.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_picking_type_entity.dart';

class StockPickingTypeRepository {
  final StockPickingTypeApiClient stockPickingTypeApiClient;

  StockPickingTypeRepository({@required this.stockPickingTypeApiClient});

  Future<StockPickingTypeResponseDto> getStockPickingTypeList(
      {String ip}) async {
    StockPickingTypeResponseDto stockPickingTypeDto =
        await stockPickingTypeApiClient.getStockPickingTypeList(ip);

    if (stockPickingTypeDto != null) {
      List<StockPickingTypeEntity> stockPickingTypes =
          stockPickingTypeDto.results
              .map((result) => StockPickingTypeEntity(
                    id: result.id,
                    name: result.name,
                    code: result.code,
                  ))
              .toList();

      await DBProvider.db.batchInsertStockPickingTypes(stockPickingTypes);
    }

    return stockPickingTypeDto;
  }
}
