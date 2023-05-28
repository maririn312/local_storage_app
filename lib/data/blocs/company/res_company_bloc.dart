// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_app/data/repository/comapny/res_company_repo.dart';
import 'package:local_storage_app/data/service/comapny/res_company_api_client_detail.dart';
import 'package:local_storage_app/exceptions/exception_manager.dart';
import 'package:local_storage_app/models/dto/company/res_company_dto.dart';

abstract class ResCompanyEvent extends Equatable {}

// ====================== ResCompany LIST EVENT ========================= //
class ResCompany extends ResCompanyEvent {
  final String ip;
  ResCompany({this.ip});

  @override
  List<Object> get props => [ip];
}

// ====================== ResCompany LIST STATE ========================= //
abstract class ResCompanyState extends Equatable {}

class ResCompanyEmpty extends ResCompanyState {
  @override
  List<Object> get props => [];
}

class ResCompanyLoading extends ResCompanyState {
  @override
  List<Object> get props => [];
}

class ResCompanyLoaded extends ResCompanyState {
  final ResCompanyResponseDto resultResCompany;

  ResCompanyLoaded(this.resultResCompany);

  @override
  List<Object> get props => [resultResCompany];
}

class ResCompanyError extends ResCompanyState {
  final String error;

  ResCompanyError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== ResCompany LIST BLOC ========================= //
class ResCompanyListBloc extends Bloc<ResCompanyEvent, ResCompanyState> {
  final ResCompanyRepository resCompanyRepository =
      ResCompanyRepository(resCompanyApiClient: ResCompanyApiClient());

  ResCompanyListBloc() : super(ResCompanyEmpty());

  @override
  Stream<ResCompanyState> mapEventToState(ResCompanyEvent event) async* {
    if (event is ResCompany) {
      yield ResCompanyLoading();
      try {
        ResCompanyResponseDto responseDto =
            await resCompanyRepository.getResCompanyList(ip: event.ip);
        yield ResCompanyLoaded(responseDto);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield ResCompanyError(ex.toString());
      }
    }
  }
}
