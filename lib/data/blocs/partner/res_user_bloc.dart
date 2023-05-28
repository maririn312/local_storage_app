import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_app/data/repository/partner/res_user_repo.dart';
import 'package:local_storage_app/data/service/partner/res_user_api_client.dart';
import 'package:local_storage_app/exceptions/exception_manager.dart';
import 'package:local_storage_app/exceptions/request_timeout_exception.dart';
import 'package:local_storage_app/language.dart';
import 'package:local_storage_app/models/dto/partner/res_user_dto.dart';

// ====================== ResUser EVENT ========================= //
abstract class ResUserEvent extends Equatable {}

class ResUserList extends ResUserEvent {
  final String ip;
  final String sessionId;
  ResUserList({this.ip, this.sessionId});

  @override
  List<Object> get props => [ip, sessionId];
}

// ====================== ResUser STATE ========================= //
abstract class ResUserState extends Equatable {}

class ResUserListEmpty extends ResUserState {
  @override
  List<Object> get props => [];
}

class ResUserListLoading extends ResUserState {
  @override
  List<Object> get props => [];
}

class ResUserListLoaded extends ResUserState {
  final List<ResUserResult> resUserResult;

  ResUserListLoaded({this.resUserResult});

  @override
  List<Object> get props => [resUserResult];
}

class ResUserListError extends ResUserState {
  final String error;

  ResUserListError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== ResUser BLOC ========================= //
class ResUserBloc extends Bloc<ResUserEvent, ResUserState> {
  final ResUserRepository resUserRepository =
      ResUserRepository(resUserApiClient: ResUserApiClient());

  ResUserBloc() : super(ResUserListEmpty());

  @override
  Stream<ResUserState> mapEventToState(ResUserEvent event) async* {
    if (event is ResUserList) {
      yield ResUserListLoading();
      try {
        ResUserResponseDto responseDto = await resUserRepository.getResUserList(
            ip: event.ip, sessionId: event.sessionId);
        yield ResUserListLoaded(resUserResult: responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        if (ex is RequestTimeoutException) {
          yield ResUserListError(ex.toString());
        } else {
          yield ResUserListError(Language.EXCEPTION_BAD_RESPONSE);
        }
      }
    }
  }
}
