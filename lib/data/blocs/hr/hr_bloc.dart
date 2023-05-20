// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/hr/hr_repo.dart';
import 'package:abico_warehouse/data/service/hr/hr_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/models/dto/hr/hr_response_dto.dart';

// ====================== HR LIST EVENT ========================= //
class HrEvent extends Equatable {
  const HrEvent();

  @override
  List<Object> get props => [];
}

class Hr extends HrEvent {
  final String uid;

  const Hr({this.uid});

  @override
  List<Object> get props => [uid];
}

// ====================== HR LIST STATE ========================= //
class HrState extends Equatable {
  const HrState();

  @override
  List<Object> get props => [];
}

class HrEmpty extends HrState {}

class HrLoading extends HrState {}

class HrLoaded extends HrState {
  final List<HrResult> resultHr;

  const HrLoaded(this.resultHr);

  @override
  List<Object> get props => [resultHr];
}

class HrError extends HrState {
  final String error;

  const HrError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== HR LIST BLOC ========================= //
class HrListBloc extends Bloc<HrEvent, HrState> {
  final HrRepository hrRepository;

  HrListBloc({HrRepository hrRepository})
      : hrRepository = hrRepository ?? HrRepository(hrApiClient: HrApiClient()),
        super(HrEmpty());

  @override
  Stream<HrState> mapEventToState(HrEvent event) async* {
    if (event is Hr) {
      yield HrLoading();
      try {
        HrResponseDto responseDto = await hrRepository.getHrList(
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
