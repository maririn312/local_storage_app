// ignore_for_file: avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/comapny/res_company_api_client_detail.dart';
import 'package:abico_warehouse/models/dto/company/res_company_dto.dart';
import 'package:abico_warehouse/models/entity/company_entity/company_entity.dart';

class ResCompanyRepository {
  final ResCompanyApiClient resCompanyApiClient;

  ResCompanyRepository({@required this.resCompanyApiClient});

  Future<ResCompanyResponseDto> getResCompanyList({
    String ip,
  }) async {
    ResCompanyResponseDto resCompanyDto =
        await resCompanyApiClient.getResCompanyList(ip);

    if (resCompanyDto != null) {
      await DBProvider.db.deleteCompany();
      for (int i = 0; i < resCompanyDto.results.length; i++) {
        await DBProvider.db.newCompany(CompanyEntity(
          id: resCompanyDto.results[i].id,
          name: resCompanyDto.results[i].name,
        ));
      }
    }

    return resCompanyApiClient.getResCompanyList(ip);
  }
}
