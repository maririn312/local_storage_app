import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_picking_api_client.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_picking_dto.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_picking_entity.dart';

class StockPickingRepository {
  final StockPickingApiClient stockPickingApiClient;

  StockPickingRepository({@required this.stockPickingApiClient});

  Future<StockPickingResponseDto> getStockPickingList({String ip}) async {
    StockPickingResponseDto stockPickingDto =
        await stockPickingApiClient.getStockPickingList(ip);

    if (stockPickingDto != null) {
      List<StockPickingEntity> stockPickings = stockPickingDto.results
          .map((result) => StockPickingEntity(
                id: result.id,
                name: result.name,
                partnerId: result.partnerId,
                pickingTypeId: result.pickingTypeId,
                locationId: result.locationId,
                scheduledDate: result.scheduledDate,
                origin: result.origin,
                state: result.state,
                isChecked: result.isChecked,
              ))
          .toList();

      await DBProvider.db.batchInsertStockPickings(stockPickings);
    }

    return stockPickingDto;
  }
}
