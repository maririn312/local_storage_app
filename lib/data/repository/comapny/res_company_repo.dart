import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/data/service/comapny/res_company_api_client_detail.dart';
import 'package:local_storage_app/models/dto/company/res_company_dto.dart';
import 'package:local_storage_app/models/entity/company_entity/company_entity.dart';
import 'package:flutter/material.dart';

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
      for (var result in resCompanyDto.results) {
        await DBProvider.db.newCompany(
          CompanyEntity(
            id: result.id,
            name: result.name,
          ),
        );
      }
    }

    return resCompanyDto;
  }
}
