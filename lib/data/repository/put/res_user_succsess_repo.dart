// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/put/res_user_succses_client.dart';
import 'package:abico_warehouse/models/dto/put/message_response_dto.dart';

class ResUserSuccessfulPutRepository {
  final ResUserSuccessfulPutApiClient resUserSuccessfulPutApiClient;

  ResUserSuccessfulPutRepository(
      {@required this.resUserSuccessfulPutApiClient});

  Future<MessageResponseDto> getResUserSuccessfulPutList({
    String ip,
    String id,
    String time,
  }) async {
    // await DBProvider.db.deleteUserAttendOff();
    // await DBProvider.db.newUserAttendOff(
    //     UserAttendOffEntity(id: 0, sendTime: DateTime.now().toString()));

    return resUserSuccessfulPutApiClient.getResUserSuccessfulPutList(
        ip, id, time);
  }
}
