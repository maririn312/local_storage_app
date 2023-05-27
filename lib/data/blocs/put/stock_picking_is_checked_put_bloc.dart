import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/put/stock_picking_is_checked_put_repo.dart';
import 'package:abico_warehouse/data/service/put/stock_picking_is_checked_put_api_client%20.dart';
import 'package:abico_warehouse/models/dto/put/stock_picking_put_response_dto.dart';

import '../../../exceptions/exception_manager.dart';

abstract class StockPickingIsActivePutEvent extends Equatable {}

// ====================== StockPickingIsActive EVENT ========================= //
class StockPickingIsActivePut extends StockPickingIsActivePutEvent {
  final String id;

  StockPickingIsActivePut({this.id});

  @override
  List<Object> get props => [id];
}

// ====================== StockPickingIsActive STATE ========================= //
abstract class StockPickingIsActivePutState extends Equatable {}

class StockPickingIsActivePutEmpty extends StockPickingIsActivePutState {
  @override
  List<Object> get props => [];
}

class StockPickingIsActivePutLoading extends StockPickingIsActivePutState {
  @override
  List<Object> get props => [];
}

class StockPickingIsActivePutLoaded extends StockPickingIsActivePutState {
  final StockPickingPutResponseDto responseDto;
  StockPickingIsActivePutLoaded(this.responseDto);

  @override
  List<Object> get props => [responseDto];
}

class StockPickingIsActivePutError extends StockPickingIsActivePutState {
  final String error;

  StockPickingIsActivePutError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== StockPickingIsActive BLOC ========================= //
class StockPickingIsActivePutListBloc
    extends Bloc<StockPickingIsActivePutEvent, StockPickingIsActivePutState> {
  final StockPickingIsActivePutRepository stockPickingIsActivePutRepository =
      StockPickingIsActivePutRepository(
          stockPickingIsActivePutApiClient: StockPickingIsActivePutApiClient());

  StockPickingIsActivePutListBloc() : super(StockPickingIsActivePutEmpty());

  @override
  Stream<StockPickingIsActivePutState> mapEventToState(
      StockPickingIsActivePutEvent event) async* {
    if (event is StockPickingIsActivePut) {
      yield StockPickingIsActivePutLoading();
      try {
        StockPickingPutResponseDto responseDto =
            await stockPickingIsActivePutRepository
                .getStockPickingIsActivePutList(id: event.id);
        yield StockPickingIsActivePutLoaded(responseDto);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockPickingIsActivePutError(ex.toString());
      }
    }
  }
}
