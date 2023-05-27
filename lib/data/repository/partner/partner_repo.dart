import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/partner/partner_api_client.dart';
import 'package:abico_warehouse/models/dto/partner/partner_response_dto.dart';
import 'package:abico_warehouse/models/entity/partner_entity/partner_entity.dart';
import 'package:flutter/foundation.dart';

class PartnerRepository {
  final PartnerApiClient partnerApiClient;

  PartnerRepository({@required this.partnerApiClient});

  Future<PartnerResponseDto> getPartnerList({
    String ip,
    String sessionId,
  }) async {
    if (kDebugMode) {
      print('Partner');
    }
    PartnerResponseDto partnerDto =
        await partnerApiClient.getPartnerList(ip, sessionId);

    if (partnerDto != null) {
      await DBProvider.db.deletePartner();

      List<PartnerEntity> partnerEntities = partnerDto.results
          .map((result) => PartnerEntity(
                id: result.id,
                companyId: result.companyId,
                name: result.name,
                street: result.street,
                email: result.email,
                website: result.website,
                vat: result.vat,
                companyType: result.companyType,
                propertyPaymentTermId: result.propertyPaymentTermId,
                mobile: result.mobile,
                userId: result.userId,
                phone: result.phone,
                propertyProductPricelist: result.propertyProductPricelist,
              ))
          .toList();

      await DBProvider.db.batchInsertPartner(partnerEntities);
    }

    return partnerApiClient.getPartnerList(ip, sessionId);
  }
}
