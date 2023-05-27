import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/put/stock_Inventroy_line_put_repo.dart';
import 'package:abico_warehouse/data/service/put/stock_Inventory_line_put_api_client.dart';
import 'package:abico_warehouse/models/dto/put/message_response_dto.dart';

import '../../../exceptions/exception_manager.dart';

abstract class StockInventoryLinePutEvent extends Equatable {}

// ====================== StockInventoryLine EVENT ========================= //
class StockInventoryLinePut extends StockInventoryLinePutEvent {
  final String ip;
  final String id;
  final String time;
  StockInventoryLinePut({this.ip, this.id, this.time});

  @override
  List<Object> get props => [ip, id, time];
}

// ====================== StockInventoryLine STATE ========================= //
abstract class StockInventoryLinePutState extends Equatable {}

class StockInventoryLinePutEmpty extends StockInventoryLinePutState {
  @override
  List<Object> get props => [];
}

class StockInventoryLinePutLoading extends StockInventoryLinePutState {
  @override
  List<Object> get props => [];
}

class StockInventoryLinePutLoaded extends StockInventoryLinePutState {
  final MessageResponseDto responseDto;
  StockInventoryLinePutLoaded(this.responseDto);

  @override
  List<Object> get props => [responseDto];
}

class StockInventoryLinePutError extends StockInventoryLinePutState {
  final String error;

  StockInventoryLinePutError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== StockInventoryLine BLOC ========================= //
class StockInventoryLinePutListBloc
    extends Bloc<StockInventoryLinePutEvent, StockInventoryLinePutState> {
  final StockInventoryLinePutRepository stockInventoryLinePutRepository =
      StockInventoryLinePutRepository(
          stockInventoryLinePutApiClient: StockInventoryLinePutApiClient());

  StockInventoryLinePutListBloc() : super(StockInventoryLinePutEmpty());

  @override
  Stream<StockInventoryLinePutState> mapEventToState(
      StockInventoryLinePutEvent event) async* {
    if (event is StockInventoryLinePut) {
      yield StockInventoryLinePutLoading();
      try {
        MessageResponseDto responseDto =
            await stockInventoryLinePutRepository.getStockInventoryLinePutList(
                ip: event.ip, id: event.id, time: event.time);
        yield StockInventoryLinePutLoaded(responseDto);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockInventoryLinePutError(ex.toString());
      }
    }
  }
}
