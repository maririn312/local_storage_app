// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/partner/res_user_api_client.dart';
import 'package:abico_warehouse/models/dto/partner/res_user_dto.dart';
import 'package:abico_warehouse/models/entity/res_entity/res_user_entity.dart';

class ResUserRepository {
  final ResUserApiClient resUserApiClient;

  ResUserRepository({@required this.resUserApiClient});

  Future<ResUserResponseDto> getResUserList(
      {String ip, String sessionId}) async {
    print('ResUser');
    ResUserResponseDto resUserDto =
        await resUserApiClient.getResUserList(ip, sessionId);

    if (resUserDto != null) {
      await DBProvider.db.deleteResUser();
      for (int i = 0; i < resUserDto.results.length; i++) {
        await DBProvider.db.newResUser(ResUserEntity(
          id: resUserDto.results[i].id,
          name: resUserDto.results[i].name,
        ));
      }
    }
    return resUserApiClient.getResUserList(ip, sessionId);
  }
}
