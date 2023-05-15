// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/product/stock_measure_api_client.dart';
import 'package:abico_warehouse/models/dto/product/stock_measure_response_dto.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_measure_entity.dart';

class StockMeasureRepository {
  final StockMeasureApiClient stockMeasureApiClient;

  StockMeasureRepository({@required this.stockMeasureApiClient});

  Future<StockMeasureResponseDto> getStockMeasure(
      {String ip, String sessionId}) async {
    print('Stock Measure');
    StockMeasureResponseDto measureDto =
        await stockMeasureApiClient.getStockMeasure(ip, sessionId);
    if (measureDto != null) {
      await DBProvider.db.deleteStockMeasure();
      for (int i = 0; i < measureDto.results.length; i++) {
        await DBProvider.db.newStockMeasure(StockMeasureEntity(
            id: measureDto.results[i].id,
            name: measureDto.results[i].name,
            rounding: measureDto.results[i].rounding));
      }
    }
    return stockMeasureApiClient.getStockMeasure(ip, sessionId);
  }
}
