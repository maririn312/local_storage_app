// ignore_for_file: unnecessary_parenthesis, unused_local_variable, non_constant_identifier_names, avoid_print, deprecated_member_use

import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/data/service/auth/auth_api_client.dart';
import 'package:local_storage_app/models/dto/auth/auth_response_dto.dart';
import 'package:local_storage_app/models/entity/auth_entity/user_entity.dart';
import 'package:local_storage_app/utils/api_utility.dart';

class AuthRepository {
  final AuthApiClient authApiClient;

  AuthRepository({this.authApiClient});

  /* ============================================================================ */
  /* ============================================================================ */
  Future<bool> login({
    String login,
    String db,
    String password,
    String ip,
  }) async {
    AuthResponseDto tokenDto = await ApiUtility.getToken(
        ip: ip, db: db, login: login, password: password);

    if (tokenDto != null) {
      await DBProvider.db.deleteUsers();
      await DBProvider.db.newUser(UserEntity(
        id: 0,
        uid: tokenDto.uid,
        access_token: tokenDto.accessToken,
        refresh_token: tokenDto.refreshToken,
      ));
      return true;
    }
    return false;
  }
}
