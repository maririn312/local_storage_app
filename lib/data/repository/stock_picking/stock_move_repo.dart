// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable, missing_return

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_move_api_client.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_move_dto.dart';
// import 'package:abico_warehouse/models/entity/note.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_move_entity.dart';

class StockMoveLineRepository {
  final StockMoveLineApiClient stockMoveLineApiClient;

  StockMoveLineRepository({@required this.stockMoveLineApiClient});

  Future<StockMoveLineResponseDto> getStockMoveLineList({
    String ip,
  }) async {
    StockMoveLineResponseDto stockPickingLineDto =
        await stockMoveLineApiClient.getStockMoveLineList(ip);

    if (stockPickingLineDto != null) {
      await DBProvider.db.deleteStockMoveLine();
      for (int i = 0; i < stockPickingLineDto.results.length; i++) {
        await DBProvider.db.newStockMoveLine(StockMoveLineEntity(
          id: stockPickingLineDto.results[i].id,
          productId: stockPickingLineDto.results[i].productId,
          descriptionPicking: stockPickingLineDto.results[i].descriptionPicking,
          dateExpected: stockPickingLineDto.results[i].dateExpected,
          quantityDone: stockPickingLineDto.results[i].quantityDone.toDouble(),
          productUom: stockPickingLineDto.results[i].productUom,
          productUomQty: stockPickingLineDto.results[i].productUomQty,
          pickingId: stockPickingLineDto.results[i].pickingId,
          checkQty: stockPickingLineDto.results[i].checkQty,
          diffQty: stockPickingLineDto.results[i].diffQty,
          barcode: stockPickingLineDto.results[i].barcode,
          productName: stockPickingLineDto.results[i].productName,
        ));
      }
      // await DBProvider.db.deleteStockNote();
      // for (int i = 0; i < stockPickingLineDto.results.length; i++) {
      //   final note = Note(
      //     id: stockPickingLineDto.results[i].id,
      //     productId: stockPickingLineDto.results[i].productId,
      //     descriptionPicking: stockPickingLineDto.results[i].descriptionPicking,
      //     dateExpected: stockPickingLineDto.results[i].dateExpected,
      //     quantityDone: stockPickingLineDto.results[i].quantityDone.toDouble(),
      //     productUom: stockPickingLineDto.results[i].productUom,
      //     pickingId: stockPickingLineDto.results[i].pickingId,
      //     checkQty: stockPickingLineDto.results[i].checkQty,
      //     diffQty: stockPickingLineDto.results[i].diffQty,
      //   );
      //   await DBProvider.db.create(note);
      // }

      return stockMoveLineApiClient.getStockMoveLineList(
        ip,
      );
    }
  }
}
