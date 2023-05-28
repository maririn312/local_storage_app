import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/data/service/product/stock_measure_api_client.dart';
import 'package:local_storage_app/models/dto/product/stock_measure_response_dto.dart';
import 'package:local_storage_app/models/entity/stock_entity/stock_measure_entity.dart';
import 'package:flutter/foundation.dart';

class StockMeasureRepository {
  final StockMeasureApiClient stockMeasureApiClient;

  StockMeasureRepository({@required this.stockMeasureApiClient});

  Future<StockMeasureResponseDto> getStockMeasure({
    String ip,
    String sessionId,
  }) async {
    if (kDebugMode) {
      print('Stock Measure');
    }
    StockMeasureResponseDto measureDto =
        await stockMeasureApiClient.getStockMeasure(ip, sessionId);
    if (measureDto != null) {
      List<StockMeasureEntity> stockMeasureEntities = measureDto.results
          .map((result) => StockMeasureEntity(
                id: result.id,
                name: result.name,
                rounding: result.rounding,
              ))
          .toList();

      await DBProvider.db.batchInsertStockMeasure(stockMeasureEntities);
    }
    return measureDto;
  }
}
