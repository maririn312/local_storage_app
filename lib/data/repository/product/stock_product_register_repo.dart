import 'package:flutter/cupertino.dart';
import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/data/service/product/stock_product_register_api_client.dart';
import 'package:local_storage_app/models/dto/product/stock_product_register_response_dto.dart';
import 'package:local_storage_app/models/entity/stock_entity/product_entity/stock_product_register_entity.dart';

class StockProductRegisterRepository {
  final StockProductRegisterApiClient stockProductRegisterApiClient;

  StockProductRegisterRepository({
    @required this.stockProductRegisterApiClient,
  });

  Future<StockProductRegisterResponseDto> getStockProductRegisterList({
    String ip,
  }) async {
    StockProductRegisterResponseDto stockProductRegisterDto =
        await stockProductRegisterApiClient.getStockProductRegisterList(ip);

    if (stockProductRegisterDto != null) {
      final entities = stockProductRegisterDto.results
          .map((result) => StockProductRegisterEntity(
                id: result.id,
                name: result.name,
                barcode: result.barcode,
                categId: result.categId,
                weight: result.weight,
                companyId: result.companyId,
                defaultCode: result.defaultCode,
                responsibleId: result.responsibleId,
                volume: result.volume.toDouble(),
                type: result.type.toString(),
                uomId: result.uomId,
                listPrice: result.listPrice.toDouble(),
                image128: result.image128,
              ))
          .toList();

      await DBProvider.db.batchInsertProductRegister(entities);
    }

    return stockProductRegisterApiClient.getStockProductRegisterList(ip);
  }
}
