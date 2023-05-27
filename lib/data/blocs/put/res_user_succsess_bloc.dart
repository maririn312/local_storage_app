import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/put/res_user_succsess_repo.dart';
import 'package:abico_warehouse/data/service/put/res_user_succses_client.dart';
import 'package:abico_warehouse/models/dto/put/message_response_dto.dart';

import '../../../exceptions/exception_manager.dart';

abstract class ResUserSuccessfulPutEvent extends Equatable {}

// ====================== ResUserSuccessful EVENT ========================= //
class ResUserSuccessfulPut extends ResUserSuccessfulPutEvent {
  final String ip;
  final String id;
  final String time;
  ResUserSuccessfulPut({this.ip, this.id, this.time});

  @override
  List<Object> get props => [ip, id, time];
}

// ====================== ResUserSuccessful STATE ========================= //
abstract class ResUserSuccessfulPutState extends Equatable {}

class ResUserSuccessfulPutEmpty extends ResUserSuccessfulPutState {
  @override
  List<Object> get props => [];
}

class ResUserSuccessfulPutLoading extends ResUserSuccessfulPutState {
  @override
  List<Object> get props => [];
}

class ResUserSuccessfulPutLoaded extends ResUserSuccessfulPutState {
  final MessageResponseDto responseDto;
  ResUserSuccessfulPutLoaded(this.responseDto);

  @override
  List<Object> get props => [responseDto];
}

class ResUserSuccessfulPutError extends ResUserSuccessfulPutState {
  final String error;

  ResUserSuccessfulPutError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== ResUserSuccessful BLOC ========================= //
class ResUserSuccessfulPutListBloc
    extends Bloc<ResUserSuccessfulPutEvent, ResUserSuccessfulPutState> {
  final ResUserSuccessfulPutRepository resUserSuccessfulPutRepository =
      ResUserSuccessfulPutRepository(
          resUserSuccessfulPutApiClient: ResUserSuccessfulPutApiClient());

  ResUserSuccessfulPutListBloc() : super(ResUserSuccessfulPutEmpty());

  @override
  Stream<ResUserSuccessfulPutState> mapEventToState(
      ResUserSuccessfulPutEvent event) async* {
    if (event is ResUserSuccessfulPut) {
      yield ResUserSuccessfulPutLoading();
      try {
        MessageResponseDto responseDto =
            await resUserSuccessfulPutRepository.getResUserSuccessfulPutList(
                ip: event.ip, id: event.id, time: event.time);
        yield ResUserSuccessfulPutLoaded(responseDto);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield ResUserSuccessfulPutError(ex.toString());
      }
    }
  }
}
