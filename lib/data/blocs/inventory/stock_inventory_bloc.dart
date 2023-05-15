// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/inventory/stock_inventory_repo.dart';
import 'package:abico_warehouse/data/service/inventory/stock_inventory_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/models/dto/inventory/stock_inventory_response_dto.dart';

abstract class StockInventoryEvent extends Equatable {}

// ====================== StockInventory LIST EVENT ========================= //
class StockInventory extends StockInventoryEvent {
  final String ip;
  StockInventory({this.ip});

  @override
  List<Object> get props => [ip];
}

// ====================== StockInventory LIST STATE ========================= //
abstract class StockInventoryState extends Equatable {}

class StockInventoryEmpty extends StockInventoryState {
  @override
  List<Object> get props => [];
}

class StockInventoryLoading extends StockInventoryState {
  @override
  List<Object> get props => [];
}

class StockInventoryLoaded extends StockInventoryState {
  final List<StockInventoryResult> resultStockInventory;

  StockInventoryLoaded(this.resultStockInventory);

  @override
  List<Object> get props => [resultStockInventory];
}

class StockInventoryError extends StockInventoryState {
  final String error;

  StockInventoryError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== StockInventory LIST BLOC ========================= //
class StockInventoryListBloc
    extends Bloc<StockInventoryEvent, StockInventoryState> {
  final StockInventoryRepository stockInventoryRepository =
      StockInventoryRepository(
          stockInventoryApiClient: StockInventoryApiClient());

  StockInventoryListBloc() : super(StockInventoryEmpty());

  @override
  Stream<StockInventoryState> mapEventToState(
      StockInventoryEvent event) async* {
    if (event is StockInventory) {
      yield StockInventoryLoading();
      try {
        StockInventoryResponseDto responseDto =
            await stockInventoryRepository.getStockInventoryList(
          ip: event.ip,
        );
        yield StockInventoryLoaded(responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockInventoryError(ex.toString());
      }
    }
  }
}
