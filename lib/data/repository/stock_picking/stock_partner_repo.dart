// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_partner_api_client.dart';

import '../../../models/dto/stock_picking/stock_partner_response_dto.dart';

class StockPartnerRepository {
  final StockPartnerApiClient stockPartnerApiClient;

  StockPartnerRepository({@required this.stockPartnerApiClient});

  Future<StockPartnerResponseDto> getPartnerList() async {
    return stockPartnerApiClient.getPartnerList();
  }
}
