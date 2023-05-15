// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/hr/hr_repo.dart';
import 'package:abico_warehouse/data/service/hr/hr_api_client.dart';

import '../../../exceptions/exception_manager.dart';
import '../../../models/dto/hr/hr_response_dto.dart';

abstract class HrEvent extends Equatable {}

// ====================== HR LIST EVENT ========================= //
class Hr extends HrEvent {
  final String ip;
  final String uid;
  Hr({this.ip, this.uid});

  @override
  List<Object> get props => [ip, uid];
}

// ====================== HR LIST STATE ========================= //
abstract class HrState extends Equatable {}

class HrEmpty extends HrState {
  @override
  List<Object> get props => [];
}

class HrLoading extends HrState {
  @override
  List<Object> get props => [];
}

class HrLoaded extends HrState {
  final List<HrResult> resultHr;

  HrLoaded(this.resultHr);

  @override
  List<Object> get props => [resultHr];
}

class HrError extends HrState {
  final String error;

  HrError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== HR LIST BLOC ========================= //
class HrListBloc extends Bloc<HrEvent, HrState> {
  final HrRepository hrRepository = HrRepository(hrApiClient: HrApiClient());

  HrListBloc() : super(HrEmpty());

  @override
  Stream<HrState> mapEventToState(HrEvent event) async* {
    if (event is Hr) {
      yield HrLoading();
      try {
        HrResponseDto responseDto = await hrRepository.getHrList(
          ip: event.ip,
          uid: event.uid,
        );
        yield HrLoaded(responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield HrError(ex.toString());
      }
    }
  }
}
