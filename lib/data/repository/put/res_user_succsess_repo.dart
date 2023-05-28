// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:local_storage_app/data/service/put/res_user_succses_client.dart';
import 'package:local_storage_app/models/dto/put/message_response_dto.dart';

class ResUserSuccessfulPutRepository {
  final ResUserSuccessfulPutApiClient resUserSuccessfulPutApiClient;

  ResUserSuccessfulPutRepository(
      {@required this.resUserSuccessfulPutApiClient});

  Future<MessageResponseDto> getResUserSuccessfulPutList({
    String ip,
    String id,
    String time,
  }) async {
    return resUserSuccessfulPutApiClient.getResUserSuccessfulPutList(
        ip, id, time);
  }
}
