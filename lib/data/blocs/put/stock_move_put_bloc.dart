// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/put/stock_move_put_repo.dart';
import 'package:abico_warehouse/data/service/put/stock_move_put_api_client.dart';
import 'package:abico_warehouse/models/dto/put/message_response_dto.dart';

import '../../../exceptions/exception_manager.dart';

abstract class StockMovePutEvent extends Equatable {}

// ====================== StockMove EVENT ========================= //
class StockMovePut extends StockMovePutEvent {
  final String ip;
  final String id;
  final String time;
  StockMovePut({this.ip, this.id, this.time});

  @override
  List<Object> get props => [ip, id, time];
}

// ====================== StockMove STATE ========================= //
abstract class StockMovePutState extends Equatable {}

class StockMovePutEmpty extends StockMovePutState {
  @override
  List<Object> get props => [];
}

class StockMovePutLoading extends StockMovePutState {
  @override
  List<Object> get props => [];
}

class StockMovePutLoaded extends StockMovePutState {
  final MessageResponseDto responseDto;
  StockMovePutLoaded(this.responseDto);

  @override
  List<Object> get props => [responseDto];
}

class StockMovePutError extends StockMovePutState {
  final String error;

  StockMovePutError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== Stock Move BLOC ========================= //
class StockMovePutListBloc extends Bloc<StockMovePutEvent, StockMovePutState> {
  final StockMovePutRepository stockMovePutRepository =
      StockMovePutRepository(stockMovePutApiClient: StockMovePutApiClient());

  StockMovePutListBloc() : super(StockMovePutEmpty());

  @override
  Stream<StockMovePutState> mapEventToState(StockMovePutEvent event) async* {
    if (event is StockMovePut) {
      yield StockMovePutLoading();
      try {
        MessageResponseDto responseDto = await stockMovePutRepository
            .getStockMovePutList(ip: event.ip, id: event.id, time: event.time);
        yield StockMovePutLoaded(responseDto);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockMovePutError(ex.toString());
      }
    }
  }
}
