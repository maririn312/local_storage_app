// // ignore_for_file: avoid_print

// import 'package:flutter/cupertino.dart';
// import 'package:abico_warehouse/data/db_provider.dart';
// import 'package:abico_warehouse/data/service/stock_picking/stock_picking_api_client.dart';
// import 'package:abico_warehouse/models/dto/stock_picking/stock_picking_dto.dart';
// import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_picking_entity.dart';

// class StockPickingRepository {
//   final StockPickingClient stockPickingApiClient;

//   StockPickingRepository({@required this.stockPickingApiClient});

//   Future<StockPickingResponseDto> getStockPickingList({String ip}) async {
//     StockPickingResponseDto stockPickingDto =
//         await stockPickingApiClient.getStockPickingList(ip);
//     if (stockPickingDto != null) {
//       await DBProvider.db.deleteStockPicking();
//       for (int i = 0; i < stockPickingDto.results.length; i++) {
//         await DBProvider.db.newStockPicking(StockPickingEntity(
//           id: stockPickingDto.results[i].id,
//           name: stockPickingDto.results[i].name,
//           partnerId: stockPickingDto.results[i].partnerId,
//           pickingTypeId: stockPickingDto.results[i].pickingTypeId,
//           locationId: stockPickingDto.results[i].locationId,
//           scheduledDate: stockPickingDto.results[i].scheduledDate,
//           origin: stockPickingDto.results[i].origin,
//           state: stockPickingDto.results[i].state,
//         ));
//       }
//     }
//     print('Stock Picking');

//     return stockPickingApiClient.getStockPickingList(ip);
//   }
// }
// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_picking_api_client.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_picking_dto.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_picking_entity.dart';

class StockPickingRepository {
  final StockPickingApiClient stockPickingApiClient;

  StockPickingRepository({@required this.stockPickingApiClient});

  Future<StockPickingResponseDto> getStockPickingList({
    String ip,
  }) async {
    StockPickingResponseDto stockPickingDto =
        await stockPickingApiClient.getStockPickingList(ip);

    if (stockPickingDto != null) {
      await DBProvider.db.deleteStockPicking();
      for (int i = 0; i < stockPickingDto.results.length; i++) {
        await DBProvider.db.newStockPicking(StockPickingEntity(
          id: stockPickingDto.results[i].id,
          name: stockPickingDto.results[i].name,
          partnerId: stockPickingDto.results[i].partnerId,
          pickingTypeId: stockPickingDto.results[i].pickingTypeId,
          locationId: stockPickingDto.results[i].locationId,
          scheduledDate: stockPickingDto.results[i].scheduledDate,
          origin: stockPickingDto.results[i].origin,
          state: stockPickingDto.results[i].state,
          isChecked: stockPickingDto.results[i].isChecked,
        ));
      }
    }

    return stockPickingApiClient.getStockPickingList(ip);
  }
}
