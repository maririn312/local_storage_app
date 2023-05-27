import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/partner/partner_repo.dart';
import 'package:abico_warehouse/data/service/partner/partner_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/partner/partner_response_dto.dart';

// ====================== PARTNER EVENT ========================= //
abstract class PartnerEvent extends Equatable {}

class PartnerList extends PartnerEvent {
  final String ip;
  final String sessionId;
  PartnerList({this.ip, this.sessionId});

  @override
  List<Object> get props => [ip, sessionId];
}

// ====================== PARTNER STATE ========================= //
abstract class PartnerState extends Equatable {}

class PartnerListEmpty extends PartnerState {
  @override
  List<Object> get props => [];
}

class PartnerListLoading extends PartnerState {
  @override
  List<Object> get props => [];
}

class PartnerListLoaded extends PartnerState {
  final List<PartnerResult> partnerResult;

  PartnerListLoaded({this.partnerResult});

  @override
  List<Object> get props => [partnerResult];
}

class PartnerListError extends PartnerState {
  final String error;

  PartnerListError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== PARTNER BLOC ========================= //
class PartnerBloc extends Bloc<PartnerEvent, PartnerState> {
  final PartnerRepository partnerRepository =
      PartnerRepository(partnerApiClient: PartnerApiClient());

  PartnerBloc() : super(PartnerListEmpty());

  @override
  Stream<PartnerState> mapEventToState(PartnerEvent event) async* {
    if (event is PartnerList) {
      yield PartnerListLoading();
      try {
        PartnerResponseDto responseDto = await partnerRepository.getPartnerList(
            ip: event.ip, sessionId: event.sessionId);
        yield PartnerListLoaded(partnerResult: responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        if (ex is RequestTimeoutException) {
          yield PartnerListError(ex.toString());
        } else {
          yield PartnerListError(Language.EXCEPTION_BAD_RESPONSE);
        }
      }
    }
  }
}
