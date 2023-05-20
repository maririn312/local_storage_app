// ignore_for_file: depend_on_referenced_packages

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

  AuthUser({this.ip, this.login, this.password});

  @override
  List<Object> get props => [ip, login, password];
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
  final AuthRepository authRepository;

  AuthBloc({AuthRepository authRepository})
      : authRepository =
            authRepository ?? AuthRepository(authApiClient: AuthApiClient()),
        super(AuthEmpty());

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is AuthUser) {
      yield AuthUserLoading();
      try {
        bool success = await authRepository.login(
          ip: event.ip,
          login: event.login,
          password: event.password,
        );
        if (success) {
          AuthResponseDto responseDto =
              AuthResponseDto(); // Update with your actual response

          yield AuthUserLoaded(responseDto);
        } else {
          yield AuthUserError(
              'Login failed'); // Update with appropriate error message
        }
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield AuthUserError(ex.toString());
      }
    }
  }
}
