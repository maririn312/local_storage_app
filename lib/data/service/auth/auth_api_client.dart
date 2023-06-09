// ignore_for_file: lines_longer_than_80_chars, avoid_print, missing_return, unused_local_variable, unused_import, non_constant_identifier_names, deprecated_member_use

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:local_storage_app/exceptions/bad_response_exception.dart';
import 'package:local_storage_app/exceptions/request_timeout_exception.dart';
import 'package:local_storage_app/language.dart';
import 'package:local_storage_app/models/dto/auth/auth_response_dto.dart';

class AuthApiClient {
  /* ============================================================================ */
  /* ============================================================================ */
  Future<AuthResponseDto> confirm(
      {String login, String db, String password, String ip}) async {
    http.Response response;

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
    }
    throw BadResponseException(Language.EXCEPTION_BAD_RESPONSE);
  }
}
