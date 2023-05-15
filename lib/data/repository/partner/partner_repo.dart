// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/partner/partner_api_client.dart';
import 'package:abico_warehouse/models/dto/partner/partner_response_dto.dart';
import 'package:abico_warehouse/models/entity/partner_entity/partner_entity.dart';

class PartnerRepository {
  final PartnerApiClient partnerApiClient;

  PartnerRepository({@required this.partnerApiClient});

  Future<PartnerResponseDto> getPartnerList(
      {String ip, String sessionId}) async {
    print('Partner');
    PartnerResponseDto partnerDto =
        await partnerApiClient.getPartnerList(ip, sessionId);

    if (partnerDto != null) {
      await DBProvider.db.deletePartner();
      for (int i = 0; i < partnerDto.results.length; i++) {
        await DBProvider.db.newPartner(PartnerEntity(
          id: partnerDto.results[i].id,
          // isSendData: partnerDto.result[i].isSendData,
          companyId: partnerDto.results[i].companyId,
          name: partnerDto.results[i].name,
          street: partnerDto.results[i].street,
          email: partnerDto.results[i].email,
          website: partnerDto.results[i].website,
          // function: partnerDto.results[i].function,
          vat: partnerDto.results[i].vat,
          companyType: partnerDto.results[i].companyType,
          propertyPaymentTermId: partnerDto.results[i].propertyPaymentTermId,
          mobile: partnerDto.results[i].mobile,
          userId: partnerDto.results[i].userId,
          // categoryId: partnerDto.results[i].categoryId,
          phone: partnerDto.results[i].phone,
          propertyProductPricelist:
              partnerDto.results[i].propertyProductPricelist,
        ));
      }
    }
    return partnerApiClient.getPartnerList(ip, sessionId);
  }
}
