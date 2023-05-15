// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/hr/hr_api_client.dart';
import 'package:abico_warehouse/models/dto/hr/hr_response_dto.dart';

class HrRepository {
  final HrApiClient hrApiClient;

  HrRepository({@required this.hrApiClient});

  Future<HrResponseDto> getHrList({
    String ip,
    String uid,
  }) async {
    HrResponseDto hrDto = await hrApiClient.getHrList(ip, uid);

    // await DBProvider.db.deleteHr();
    // if (hrDto != null) {
    //   await DBProvider.db.deleteHr();
    //   for (int i = 0; i < hrDto.count; i++) {
    //     await DBProvider.db.newHr(HrEntity(
    //         id: hrDto.result[i].id,
    //         userId: hrDto.result[i].userId,
    //         name: hrDto.result[i].name));
    //   }
    // }
    return hrApiClient.getHrList(
      ip,
      uid,
    );
  }
}
