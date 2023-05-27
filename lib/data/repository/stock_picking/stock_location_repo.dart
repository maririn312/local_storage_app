import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_location_api_client.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_location_response_dto.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_location_entity.dart';

class StockLocationRepository {
  final StockLocationApiClient stockLocationApiClient;

  StockLocationRepository({@required this.stockLocationApiClient});

  Future<StockLocationResponseDto> getStockLocation(
      {String ip, String sessionId}) async {
    StockLocationResponseDto locationDto =
        await stockLocationApiClient.getStockLocation(ip, sessionId);

    if (locationDto != null) {
      final stockLocations = locationDto.results.map((result) {
        return StockLocationEntity(
          id: result.id,
          name: result.name,
          completeName: result.completeName,
          companyId: result.companyId,
          locationId: result.locationId,
          usage: result.usage,
        );
      }).toList();

      await DBProvider.db.batchUpsertStockLocations(stockLocations);
    }

    return locationDto;
  }
}
