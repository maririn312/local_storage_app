// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/stock_picking/stock_picking_line_repo.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_picking_line_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_picking_line_dto.dart';

abstract class StockPickingLineEvent extends Equatable {}

// ====================== StockPickingLine LIST EVENT ========================= //
class StockPickingLine extends StockPickingLineEvent {
  final String ip;
  StockPickingLine({this.ip});

  @override
  List<Object> get props => [ip];
}

// ====================== StockPickingLine LIST STATE ========================= //
abstract class StockPickingLineState extends Equatable {}

class StockPickingLineEmpty extends StockPickingLineState {
  @override
  List<Object> get props => [];
}

class StockPickingLineLoading extends StockPickingLineState {
  @override
  List<Object> get props => [];
}

class StockPickingLineLoaded extends StockPickingLineState {
  final List<StockPickingLineResult> resultStockPickingLine;

  StockPickingLineLoaded(this.resultStockPickingLine);

  @override
  List<Object> get props => [resultStockPickingLine];
}

class StockPickingLineError extends StockPickingLineState {
  final String error;

  StockPickingLineError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== StockPickingLine LIST BLOC ========================= //
class StockPickingLineListBloc
    extends Bloc<StockPickingLineEvent, StockPickingLineState> {
  final StockPickingLineRepository stockPickingLineRepository =
      StockPickingLineRepository(
          stockPickingLineApiClient: StockPickingLineApiClient());

  StockPickingLineListBloc() : super(StockPickingLineEmpty());

  @override
  Stream<StockPickingLineState> mapEventToState(
      StockPickingLineEvent event) async* {
    if (event is StockPickingLine) {
      yield StockPickingLineLoading();
      try {
        StockPickingLineResponseDto responseDto =
            await stockPickingLineRepository.getStockPickingLineList(
          ip: event.ip,
        );
        yield StockPickingLineLoaded(responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockPickingLineError(ex.toString());
      }
    }
  }
}
