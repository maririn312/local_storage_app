import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/data/service/partner/res_user_api_client.dart';
import 'package:local_storage_app/models/dto/partner/res_user_dto.dart';
import 'package:local_storage_app/models/entity/res_entity/res_user_entity.dart';
import 'package:flutter/foundation.dart';

class ResUserRepository {
  final ResUserApiClient resUserApiClient;

  ResUserRepository({@required this.resUserApiClient});

  Future<ResUserResponseDto> getResUserList(
      {String ip, String sessionId}) async {
    if (kDebugMode) {
      print('ResUser');
    }
    ResUserResponseDto resUserDto =
        await resUserApiClient.getResUserList(ip, sessionId);

    if (resUserDto != null) {
      List<ResUserEntity> resUserEntities = resUserDto.results
          .map((resUser) => ResUserEntity(
                id: resUser.id,
                name: resUser.name,
              ))
          .toList();

      await DBProvider.db.batchInsertResUser(resUserEntities);
    }

    return resUserApiClient.getResUserList(ip, sessionId);
  }
}
