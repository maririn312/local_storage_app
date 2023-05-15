// ignore_for_file: lines_longer_than_80_chars, avoid_print, missing_return, unused_local_variable, unused_import, non_constant_identifier_names, deprecated_member_use, depend_on_referenced_packages

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:abico_warehouse/exceptions/bad_response_exception.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/auth/auth_response_dto.dart';

class AuthApiClient {
  /* ============================================================================ */
  /* ============================================================================ */
  Future<AuthResponseDto> confirm(
      {String login, String password, String ip}) async {
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
