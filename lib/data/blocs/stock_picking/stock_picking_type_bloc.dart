// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/stock_picking/stock_picking_type_repo.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_picking_type_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_picking_type_dto.dart';

abstract class StockPickingTypeEvent extends Equatable {}

// ====================== StockPickingType LIST EVENT ========================= //
class StockPickingType extends StockPickingTypeEvent {
  StockPickingType();

  @override
  List<Object> get props => [];
}

// ====================== StockPickingLine LIST STATE ========================= //
abstract class StockPickingTypeState extends Equatable {}

class StockPickingTypeEmpty extends StockPickingTypeState {
  @override
  List<Object> get props => [];
}

class StockPickingTypeLoading extends StockPickingTypeState {
  @override
  List<Object> get props => [];
}

class StockPickingTypeLoaded extends StockPickingTypeState {
  final List<StockPickingTypeResult> resultStockPickingType;

  StockPickingTypeLoaded(this.resultStockPickingType);

  @override
  List<Object> get props => [resultStockPickingType];
}

class StockPickingTypeError extends StockPickingTypeState {
  final String error;

  StockPickingTypeError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== StockPickingType LIST BLOC ========================= //
class StockPickingTypeListBloc
    extends Bloc<StockPickingTypeEvent, StockPickingTypeState> {
  final StockPickingTypeRepository stockPickingTypeRepository =
      StockPickingTypeRepository(
          stockPickingTypeApiClient: StockPickingTypeApiClient());

  StockPickingTypeListBloc() : super(StockPickingTypeEmpty());

  @override
  Stream<StockPickingTypeState> mapEventToState(
      StockPickingTypeEvent event) async* {
    if (event is StockPickingType) {
      yield StockPickingTypeLoading();
      try {
        StockPickingTypeResponseDto responseDto =
            await stockPickingTypeRepository.getStockPickingTypeList();
        yield StockPickingTypeLoaded(responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockPickingTypeError(ex.toString());
      }
    }
  }
}
