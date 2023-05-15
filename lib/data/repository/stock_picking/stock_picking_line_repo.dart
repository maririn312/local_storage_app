// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_picking_line_api_client.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_picking_line_dto.dart';

class StockPickingLineRepository {
  final StockPickingLineApiClient stockPickingLineApiClient;

  StockPickingLineRepository({@required this.stockPickingLineApiClient});

  Future<StockPickingLineResponseDto> getStockPickingLineList({
    String ip,
  }) async {
    StockPickingLineResponseDto stockPickingLineDto =
        await stockPickingLineApiClient.getStockPickingLineList(ip);
    return stockPickingLineApiClient.getStockPickingLineList(
      ip,
    );
  }
}
