// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/put/stock_picking_put_repo.dart';
import 'package:abico_warehouse/data/service/put/stock_picking_put_api_client.dart';
import 'package:abico_warehouse/models/dto/put/message_response_dto.dart';

import '../../../exceptions/exception_manager.dart';

abstract class StockPickingPutEvent extends Equatable {}

// ====================== StockPicking EVENT ========================= //
class StockPickingPut extends StockPickingPutEvent {
  final String ip;
  final String id;
  final String time;
  StockPickingPut({this.ip, this.id, this.time});

  @override
  List<Object> get props => [ip, id, time];
}

// ====================== StockPicking STATE ========================= //
abstract class StockPickingPutState extends Equatable {}

class StockPickingPutEmpty extends StockPickingPutState {
  @override
  List<Object> get props => [];
}

class StockPickingPutLoading extends StockPickingPutState {
  @override
  List<Object> get props => [];
}

class StockPickingPutLoaded extends StockPickingPutState {
  final MessageResponseDto responseDto;
  StockPickingPutLoaded(this.responseDto);

  @override
  List<Object> get props => [responseDto];
}

class StockPickingPutError extends StockPickingPutState {
  final String error;

  StockPickingPutError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== Stock Picking BLOC ========================= //
class StockPickingPutListBloc
    extends Bloc<StockPickingPutEvent, StockPickingPutState> {
  final StockPickingPutRepository stockPickingPutRepository =
      StockPickingPutRepository(
          stockPickingPutApiClient: StockPickingPutApiClient());

  StockPickingPutListBloc() : super(StockPickingPutEmpty());

  @override
  Stream<StockPickingPutState> mapEventToState(
      StockPickingPutEvent event) async* {
    if (event is StockPickingPut) {
      yield StockPickingPutLoading();
      try {
        MessageResponseDto responseDto =
            await stockPickingPutRepository.getStockPickingPutList(
                ip: event.ip, id: event.id, time: event.time);
        yield StockPickingPutLoaded(responseDto);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockPickingPutError(ex.toString());
      }
    }
  }
}
