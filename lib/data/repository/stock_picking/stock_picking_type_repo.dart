import 'package:flutter/cupertino.dart';
import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/data/service/stock_picking/stock_picking_type_api_client.dart';
import 'package:local_storage_app/models/dto/stock_picking/stock_picking_type_dto.dart';
import 'package:local_storage_app/models/entity/stock_entity/stock_picking_entity/stock_picking_type_entity.dart';

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
