import 'package:flutter/cupertino.dart';
import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/data/service/stock_picking/stock_location_api_client.dart';
import 'package:local_storage_app/models/dto/stock_picking/stock_location_response_dto.dart';
import 'package:local_storage_app/models/entity/stock_entity/stock_location_entity.dart';

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
