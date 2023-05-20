// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/hr/hr_api_client.dart';
import 'package:abico_warehouse/models/dto/hr/hr_response_dto.dart';

class HrRepository {
  final HrApiClient hrApiClient;

  HrRepository({@required this.hrApiClient});

  Future<HrResponseDto> getHrList({
    String uid,
  }) async {
    HrResponseDto hrDto = await hrApiClient.getHrList(uid);

    return hrApiClient.getHrList(
      uid,
    );
  }
}
