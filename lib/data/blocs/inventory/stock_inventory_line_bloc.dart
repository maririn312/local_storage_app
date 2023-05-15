// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/inventory/stock_inventory_line_repo.dart';
import 'package:abico_warehouse/data/service/inventory/stock_inventory_line_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/models/dto/inventory/stock_inventory_line_response_dto.dart';

abstract class StockInventoryLineEvent extends Equatable {}

// ====================== StockInventoryLine LIST EVENT ========================= //
class StockInventoryLine extends StockInventoryLineEvent {
  final String ip;
  StockInventoryLine({this.ip});

  @override
  List<Object> get props => [ip];
}

// ====================== StockInventoryLine LIST STATE ========================= //
abstract class StockInventoryLineState extends Equatable {}

class StockInventoryLineEmpty extends StockInventoryLineState {
  @override
  List<Object> get props => [];
}

class StockInventoryLineLoading extends StockInventoryLineState {
  @override
  List<Object> get props => [];
}

class StockInventoryLineLoaded extends StockInventoryLineState {
  final List<StockInventoryLineResult> resultStockInventoryLine;

  StockInventoryLineLoaded(this.resultStockInventoryLine);

  @override
  List<Object> get props => [resultStockInventoryLine];
}

class StockInventoryLineError extends StockInventoryLineState {
  final String error;

  StockInventoryLineError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== StockInventoryLine LIST BLOC ========================= //
class StockInventoryLineListBloc
    extends Bloc<StockInventoryLineEvent, StockInventoryLineState> {
  final StockInventoryLineRepository stockInventoryLineRepository =
      StockInventoryLineRepository(
          stockInventoryLineApiClient: StockInventoryLineApiClient());

  StockInventoryLineListBloc() : super(StockInventoryLineEmpty());

  @override
  Stream<StockInventoryLineState> mapEventToState(
      StockInventoryLineEvent event) async* {
    if (event is StockInventoryLine) {
      yield StockInventoryLineLoading();
      try {
        StockInventoryLineResponseDto responseDto =
            await stockInventoryLineRepository.getStockInventoryLineList(
          ip: event.ip,
        );
        yield StockInventoryLineLoaded(responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockInventoryLineError(ex.toString());
      }
    }
  }
}
