// ignore_for_file: avoid_print

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
    print('Stock Location');
    StockLocationResponseDto locationDto =
        await stockLocationApiClient.getStockLocation(ip, sessionId);
    if (locationDto != null) {
      await DBProvider.db.deleteStockLocation();
      for (int i = 0; i < locationDto.results.length; i++) {
        await DBProvider.db.newStockLocation(StockLocationEntity(
            id: locationDto.results[i].id,
            name: locationDto.results[i].name,
            completeName: locationDto.results[i].completeName,
            companyId: locationDto.results[i].companyId,
            locationId: locationDto.results[i].locationId,
            usage: locationDto.results[i].usage));
      }
    }
    return stockLocationApiClient.getStockLocation(ip, sessionId);
  }
}
