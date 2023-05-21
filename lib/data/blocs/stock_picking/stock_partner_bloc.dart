// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_partner_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';

import '../../../models/dto/stock_picking/stock_partner_response_dto.dart';
import '../../repository/stock_picking/stock_partner_repo.dart';

// ====================== PARTNER EVENT ========================= //
abstract class StockPartnerEvent extends Equatable {}

class StockPartnerList extends StockPartnerEvent {
  StockPartnerList();

  @override
  List<Object> get props => [];
}

// ====================== PARTNER STATE ========================= //
abstract class StockPartnerState extends Equatable {}

class StockPartnerListEmpty extends StockPartnerState {
  @override
  List<Object> get props => [];
}

class StockPartnerListLoading extends StockPartnerState {
  @override
  List<Object> get props => [];
}

class StockPartnerListLoaded extends StockPartnerState {
  final List<StockPartnerResult> partnerResult;

  StockPartnerListLoaded({this.partnerResult});

  @override
  List<Object> get props => [partnerResult];
}

class StockPartnerListError extends StockPartnerState {
  final String error;

  StockPartnerListError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== PARTNER BLOC ========================= //
class StockPartnerBloc extends Bloc<StockPartnerEvent, StockPartnerState> {
  final StockPartnerRepository partnerRepository =
      StockPartnerRepository(stockPartnerApiClient: StockPartnerApiClient());

  StockPartnerBloc() : super(StockPartnerListEmpty());

  @override
  Stream<StockPartnerState> mapEventToState(StockPartnerEvent event) async* {
    if (event is StockPartnerList) {
      yield StockPartnerListLoading();
      try {
        StockPartnerResponseDto responseDto =
            await partnerRepository.getPartnerList();
        yield StockPartnerListLoaded(partnerResult: responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        if (ex is RequestTimeoutException) {
          yield StockPartnerListError(ex.toString());
        } else {
          yield StockPartnerListError(Language.EXCEPTION_BAD_RESPONSE);
        }
      }
    }
  }
}
