import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/stock_picking/stock_picking_repo.dart';
import 'package:abico_warehouse/data/service/stock_picking/stock_picking_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_picking_dto.dart';

abstract class StockPickingEvent extends Equatable {}

// ====================== StockPicking LIST EVENT ========================= //
class StockPicking extends StockPickingEvent {
  final String ip;
  StockPicking({this.ip});

  @override
  List<Object> get props => [ip];
}

// ====================== StockPicking LIST STATE ========================= //
abstract class StockPickingState extends Equatable {}

class StockPickingEmpty extends StockPickingState {
  @override
  List<Object> get props => [];
}

class StockPickingLoading extends StockPickingState {
  @override
  List<Object> get props => [];
}

class StockPickingLoaded extends StockPickingState {
  final StockPickingResponseDto resultStockPicking;

  StockPickingLoaded(this.resultStockPicking);

  @override
  List<Object> get props => [resultStockPicking];
}

class StockPickingError extends StockPickingState {
  final String error;

  StockPickingError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== StockPicking LIST BLOC ========================= //
class StockPickingListBloc extends Bloc<StockPickingEvent, StockPickingState> {
  final StockPickingRepository stockPickingRepository =
      StockPickingRepository(stockPickingApiClient: StockPickingApiClient());

  StockPickingListBloc() : super(StockPickingEmpty());

  @override
  Stream<StockPickingState> mapEventToState(StockPickingEvent event) async* {
    if (event is StockPicking) {
      yield StockPickingLoading();
      try {
        StockPickingResponseDto responseDto =
            await stockPickingRepository.getStockPickingList(ip: event.ip);
        yield StockPickingLoaded(responseDto);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockPickingError(ex.toString());
      }
    }
  }
}
