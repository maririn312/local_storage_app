// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/exceptions/bad_response_exception.dart';
import 'package:local_storage_app/exceptions/request_timeout_exception.dart';
import 'package:local_storage_app/models/dto/auth/auth_response_dto.dart';
import 'package:local_storage_app/models/entity/auth_entity/user_entity.dart';

import '../language.dart';

class ApiUtility {
  /* ============================================================================ */
  /* ============================================================================ */
  static Future<AuthResponseDto> getToken(
      {String login, String db, String password, String ip}) async {
    http.Response response;
    UserEntity user = await DBProvider.db.getUser();
    String url = 'http://$ip/api/auth/get_tokens';
    print('ip bn uu $url');

    try {
      response = await http.post(
        Uri.parse('$url?username=$login&password=$password'),
      );
    } on SocketException {
      throw RequestTimeoutException(url);
    } on TimeoutException {
      throw RequestTimeoutException(url);
    }
    print('end api result irnee');
    print(response.statusCode);
    print(response.body);
    print(response.body);
    print(response.statusCode);
    print('url hit');
    if (response.statusCode == 200 || response.statusCode == 202) {
      print('fuck response');
      print(response.body);
      return AuthResponseDto.fromRawJson(response.body);
    } else if (response.statusCode == 400 || response.statusCode == 404) {
      try {
        response = await http.post(
          Uri.parse(
              'http://49.0.129.18:9393/api/auth/refresh_token?refresh_token=${user.refresh_token}'),
        );
      } on SocketException {
        throw RequestTimeoutException(url);
      } on TimeoutException {
        throw RequestTimeoutException(url);
      }
    }
    throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
  }
}
