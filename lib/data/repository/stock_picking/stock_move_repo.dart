import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_move_api_client.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_move_dto.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_move_entity.dart';
import 'package:flutter/cupertino.dart';

class StockMoveLineRepository {
  final StockMoveLineApiClient stockMoveLineApiClient;

  StockMoveLineRepository({@required this.stockMoveLineApiClient});

  Future<StockMoveLineResponseDto> getStockMoveLineList({String ip}) async {
    StockMoveLineResponseDto stockPickingLineDto =
        await stockMoveLineApiClient.getStockMoveLineList(ip);

    if (stockPickingLineDto != null) {
      final stockMoveLines = stockPickingLineDto.results.map((result) {
        return StockMoveLineEntity(
          id: result.id,
          productId: result.productId,
          descriptionPicking: result.descriptionPicking,
          dateExpected: result.dateExpected,
          quantityDone: result.quantityDone.toDouble(),
          productUom: result.productUom,
          productUomQty: result.productUomQty,
          pickingId: result.pickingId,
          checkQty: result.checkQty,
          diffQty: result.diffQty,
          barcode: result.barcode,
          productName: result.productName,
        );
      }).toList();

      await DBProvider.db.deleteStockMoveLine();
      await DBProvider.db.batchInsertStockMoveLines(stockMoveLines);
    }

    return stockPickingLineDto;
  }
}
