import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/product/stock_product_register_repo.dart';
import 'package:abico_warehouse/data/service/product/stock_product_register_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/models/dto/product/stock_product_register_response_dto.dart';

abstract class StockProductRegisterEvent extends Equatable {}

// ====================== StockProductRegister LIST EVENT ========================= //
class StockProductRegister extends StockProductRegisterEvent {
  StockProductRegister();

  @override
  List<Object> get props => [];
}

// ====================== StockProductRegister LIST STATE ========================= //
abstract class StockProductRegisterState extends Equatable {}

class StockProductRegisterEmpty extends StockProductRegisterState {
  @override
  List<Object> get props => [];
}

class StockProductRegisterLoading extends StockProductRegisterState {
  @override
  List<Object> get props => [];
}

class StockProductRegisterLoaded extends StockProductRegisterState {
  final StockProductRegisterResponseDto resultStockProductRegister;

  StockProductRegisterLoaded(this.resultStockProductRegister);

  @override
  List<Object> get props => [resultStockProductRegister];
}

class StockProductRegisterError extends StockProductRegisterState {
  final String error;

  StockProductRegisterError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== StockProductRegister LIST BLOC ========================= //
class StockProductRegisterListBloc
    extends Bloc<StockProductRegisterEvent, StockProductRegisterState> {
  final StockProductRegisterRepository stockProductRegisterRepository =
      StockProductRegisterRepository(
          stockProductRegisterApiClient: StockProductRegisterApiClient());

  StockProductRegisterListBloc() : super(StockProductRegisterEmpty());

  @override
  Stream<StockProductRegisterState> mapEventToState(
      StockProductRegisterEvent event) async* {
    if (event is StockProductRegister) {
      yield StockProductRegisterLoading();
      try {
        StockProductRegisterResponseDto responseDto =
            await stockProductRegisterRepository.getStockProductRegisterList();
        yield StockProductRegisterLoaded(responseDto);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockProductRegisterError(ex.toString());
      }
    }
  }
}
