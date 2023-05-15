// // ignore_for_file: avoid_print

// import 'package:flutter/cupertino.dart';
// import 'package:abico_warehouse/data/db_provider.dart';
// import 'package:abico_warehouse/data/service/product/stock_product_register_api_client.dart';
// import 'package:abico_warehouse/models/dto/product/stock_product_register_response_dto.dart';
// import 'package:abico_warehouse/models/entity/stock_entity/product_entity/stock_product_register_entity.dart';

// class StockProductRegisterListRepository {
//   final StockProductRegisterListApiClient stockProductRegisterListApiClient;

//   StockProductRegisterListRepository(
//       {@required this.stockProductRegisterListApiClient});

//   Future<StockProductRegisterResponseDto> getStockProductRegisterList(
//       {String ip, String sessionId}) async {
//     print('Product Register List');
//     StockProductRegisterResponseDto productRegisterListDto =
//         await stockProductRegisterListApiClient.getStockProductRegisterList(
//             ip, sessionId);
//     if (productRegisterListDto != null) {
//       await DBProvider.db.deleteProductRegister();
//       for (int i = 0; i < productRegisterListDto.results.length; i++) {
//         await DBProvider.db.newProductRegister(StockProductRegisterEntity(
//           id: productRegisterListDto.results[i].id,
//           name: productRegisterListDto.results[i].name,
//           barcode: productRegisterListDto.results[i].barcode,
//           categId: productRegisterListDto.results[i].categId,
//           // isSendData: productRegisterListDto.results[i].isSendData,
//           weight: productRegisterListDto.results[i].weight,
//           companyId: productRegisterListDto.results[i].companyId,
//           defaultCode: productRegisterListDto.results[i].defaultCode,
//           responsibleId: productRegisterListDto.results[i].responsibleId,
//           volume: productRegisterListDto.results[i].volume.toDouble(),
//           type: productRegisterListDto.results[i].type.toString(),
//           uomId: productRegisterListDto.results[i].uomId,
//           listPrice: productRegisterListDto.results[i].listPrice.toDouble(),
//           image1920: productRegisterListDto.results[i].image1920,
//           // taxesId: productRegisterListDto.results[i].taxesId,
//         ));
//       }
//     }
//     return stockProductRegisterListApiClient.getStockProductRegisterList(
//         ip, sessionId);
//   }
// }

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/product/stock_product_register_api_client.dart';
import 'package:abico_warehouse/models/dto/product/stock_product_register_response_dto.dart';
// import 'package:abico_warehouse/models/entity/stock_entity/product_entity/product_register_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/product_entity/stock_product_register_entity.dart';

class StockProductRegisterRepository {
  final StockProductRegisterApiClient stockProductRegisterApiClient;

  StockProductRegisterRepository(
      {@required this.stockProductRegisterApiClient});

  Future<StockProductRegisterResponseDto> getStockProductRegisterList({
    String ip,
  }) async {
    StockProductRegisterResponseDto stockProductRegisterDto =
        await stockProductRegisterApiClient.getStockProductRegisterList(ip);

    if (stockProductRegisterDto != null) {
      // await DBProvider.db.deleteProduct();
      // for (int i = 0; i < stockProductRegisterDto.results.length; i++) {
      //   final product = Product(
      //     id: stockProductRegisterDto.results[i].id,
      //     name: stockProductRegisterDto.results[i].name,
      //     barcode: stockProductRegisterDto.results[i].barcode,
      //     categId: stockProductRegisterDto.results[i].categId,
      //     weight: stockProductRegisterDto.results[i].weight,
      //     companyId: stockProductRegisterDto.results[i].companyId,
      //     defaultCode: stockProductRegisterDto.results[i].defaultCode,
      //     responsibleId: stockProductRegisterDto.results[i].responsibleId,
      //     volume: stockProductRegisterDto.results[i].volume.toDouble(),
      //     // type: stockProductRegisterDto.results[i].type.toString(),
      //     uomId: stockProductRegisterDto.results[i].uomId,
      //     listPrice: stockProductRegisterDto.results[i].listPrice.toDouble(),
      //     image1920: stockProductRegisterDto.results[i].image1920,
      //   );
      //   await DBProvider.db.createProduct(product);
      // }
      await DBProvider.db.deleteProductRegister();
      for (int i = 0; i < stockProductRegisterDto.results.length; i++) {
        await DBProvider.db.newProductRegister(StockProductRegisterEntity(
          id: stockProductRegisterDto.results[i].id,
          name: stockProductRegisterDto.results[i].name,
          barcode: stockProductRegisterDto.results[i].barcode,
          categId: stockProductRegisterDto.results[i].categId,
          weight: stockProductRegisterDto.results[i].weight,
          companyId: stockProductRegisterDto.results[i].companyId,
          defaultCode: stockProductRegisterDto.results[i].defaultCode,
          responsibleId: stockProductRegisterDto.results[i].responsibleId,
          volume: stockProductRegisterDto.results[i].volume.toDouble(),
          type: stockProductRegisterDto.results[i].type.toString(),
          uomId: stockProductRegisterDto.results[i].uomId,
          listPrice: stockProductRegisterDto.results[i].listPrice.toDouble(),
          image128: stockProductRegisterDto.results[i].image128,
        ));
      }
    }

    return stockProductRegisterApiClient.getStockProductRegisterList(ip);
  }
}
