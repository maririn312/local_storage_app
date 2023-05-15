// ignore_for_file: non_constant_identifier_names, unused_local_variable, depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/auth/auth_repo.dart';
import 'package:abico_warehouse/data/service/auth/auth_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/models/dto/auth/auth_response_dto.dart';

// ====================== AUTH EVENT ========================= //
abstract class AuthEvent extends Equatable {}

class AuthUser extends AuthEvent {
  final String login;
  final String ip;
  final String password;
  final String access_token;
  final String refresh_token;

  AuthUser(
      {this.ip,
      this.login,
      this.password,
      this.access_token,
      this.refresh_token});

  @override
  List<Object> get props => [ip, login, password, access_token, refresh_token];
}

// ====================== AUTH STATE ========================= //
abstract class AuthState extends Equatable {}

class AuthEmpty extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthUserLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthUserLoaded extends AuthState {
  final AuthResponseDto responseDto;

  AuthUserLoaded(this.responseDto);
  @override
  List<Object> get props => [responseDto];
}

class AuthUserError extends AuthState {
  final String error;

  AuthUserError(this.error);

  @override
  List<Object> get props => [error];
}

class AuthUserLogOut extends AuthState {
  @override
  List<Object> get props => [];
}

// ====================== AUTH BLOC ========================= //
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository =
      AuthRepository(authApiClient: AuthApiClient());

  AuthBloc() : super(AuthEmpty());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthUser) {
      yield AuthUserLoading();
      try {
        bool login = await authRepository.login(
            ip: event.ip, login: event.login, password: event.password);
        AuthResponseDto responseDto;

        yield AuthUserLoaded(responseDto);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield AuthUserError(ex.toString());
      }
    }
  }
}
