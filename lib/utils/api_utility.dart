// ignore_for_file: avoid_print, depend_on_referenced_packages

import 'dart:async';
import 'dart:io';

import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/exceptions/bad_response_exception.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/models/dto/auth/auth_response_dto.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_entity.dart';
import 'package:http/http.dart' as http;

import '../language.dart';

class ApiUtility {
  /* ============================================================================ */
  /* ============================================================================ */
  static Future<AuthResponseDto> getToken(
      {String login, String password, String ip}) async {
    http.Response response;
    UserEntity user = await DBProvider.db.getUser();
    String url = 'http://${user.ip}/api/auth/get_tokens';
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
              'http://${user.ip}/api/auth/refresh_token?refresh_token=${user.refresh_token}'),
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
