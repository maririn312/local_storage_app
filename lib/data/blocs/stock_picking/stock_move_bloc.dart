// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/stock_picking/stock_move_repo.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_move_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_move_dto.dart';

abstract class StockMoveLineEvent extends Equatable {}

// ====================== StockMoveLine LIST EVENT ========================= //
class StockMoveLine extends StockMoveLineEvent {
  final String ip;
  StockMoveLine({this.ip});

  @override
  List<Object> get props => [ip];
}

// ====================== StockPickingLine LIST STATE ========================= //
abstract class StockMoveLineState extends Equatable {}

class StockMoveLineEmpty extends StockMoveLineState {
  @override
  List<Object> get props => [];
}

class StockMoveLineLoading extends StockMoveLineState {
  @override
  List<Object> get props => [];
}

class StockMoveLineLoaded extends StockMoveLineState {
  final List<StockMoveLineResult> resultStockMoveLine;

  StockMoveLineLoaded(this.resultStockMoveLine);

  @override
  List<Object> get props => [resultStockMoveLine];
}

class StockMoveLineError extends StockMoveLineState {
  final String error;

  StockMoveLineError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== StockMoveLine LIST BLOC ========================= //
class StockMoveLineListBloc
    extends Bloc<StockMoveLineEvent, StockMoveLineState> {
  final StockMoveLineRepository stockMoveLineRepository =
      StockMoveLineRepository(stockMoveLineApiClient: StockMoveLineApiClient());

  StockMoveLineListBloc() : super(StockMoveLineEmpty());

  @override
  Stream<StockMoveLineState> mapEventToState(StockMoveLineEvent event) async* {
    if (event is StockMoveLine) {
      yield StockMoveLineLoading();
      try {
        StockMoveLineResponseDto responseDto =
            await stockMoveLineRepository.getStockMoveLineList(
          ip: event.ip,
        );
        yield StockMoveLineLoaded(responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockMoveLineError(ex.toString());
      }
    }
  }
}
