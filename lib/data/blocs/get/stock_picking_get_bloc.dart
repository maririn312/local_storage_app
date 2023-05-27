import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/get/stock_picking_get_repo.dart';
import 'package:abico_warehouse/data/service/get/stock_picking_get_api_client%20.dart';
import 'package:abico_warehouse/models/dto/get/stock_picking_get_dto_detail.dart';

import '../../../exceptions/exception_manager.dart';

abstract class StockPickingGetEvent extends Equatable {}

// ====================== StockPickingIsActive EVENT ========================= //
class StockPickingGet extends StockPickingGetEvent {
  final String id;

  StockPickingGet({this.id});

  @override
  List<Object> get props => [id];
}

// ====================== StockPickingIsActive STATE ========================= //
abstract class StockPickingGetState extends Equatable {}

class StockPickingGetEmpty extends StockPickingGetState {
  @override
  List<Object> get props => [];
}

class StockPickingGetLoading extends StockPickingGetState {
  @override
  List<Object> get props => [];
}

class StockPickingGetLoaded extends StockPickingGetState {
  final StockPickingGetResult responseDto;
  StockPickingGetLoaded(this.responseDto);

  @override
  List<Object> get props => [responseDto];
}

class StockPickingGetError extends StockPickingGetState {
  final String error;

  StockPickingGetError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== StockPickingIsActive BLOC ========================= //
class StockPickingGetListBloc
    extends Bloc<StockPickingGetEvent, StockPickingGetState> {
  final StockPickingGetRepository stockPickingGetRepository =
      StockPickingGetRepository(
          stockPickingGetApiClient: StockPickingGetApiClient());

  StockPickingGetListBloc() : super(StockPickingGetEmpty());

  @override
  Stream<StockPickingGetState> mapEventToState(
      StockPickingGetEvent event) async* {
    if (event is StockPickingGet) {
      yield StockPickingGetLoading();
      try {
        StockPickingGetResult responseDto = await stockPickingGetRepository
            .getStockPickingGetList(id: event.id, checkUser: '');
        yield StockPickingGetLoaded(responseDto);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockPickingGetError(ex.toString());
      }
    }
  }
}
