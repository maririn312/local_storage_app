import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_app/data/repository/product/stock_measure_repo.dart';
import 'package:local_storage_app/data/service/product/stock_measure_api_client.dart';
import 'package:local_storage_app/exceptions/exception_manager.dart';
import 'package:local_storage_app/exceptions/request_timeout_exception.dart';
import 'package:local_storage_app/language.dart';
import 'package:local_storage_app/models/dto/product/stock_measure_response_dto.dart';

abstract class StockMeasureEvent extends Equatable {}

// ====================== STOCK MEASURE EVENT ========================= //
class StockMeasure extends StockMeasureEvent {
  final String ip;
  final String sessionId;
  StockMeasure({this.ip, this.sessionId});

  @override
  List<Object> get props => [ip, sessionId];
}

// ====================== STOCK MEASURE STATE ========================= //
abstract class StockMeasureState extends Equatable {}

class StockMeasureEmpty extends StockMeasureState {
  @override
  List<Object> get props => [];
}

class StockMeasureLoading extends StockMeasureState {
  @override
  List<Object> get props => [];
}

class StockMeasureLoaded extends StockMeasureState {
  final List<StockMeasureResult> stockMeasureResult;

  StockMeasureLoaded({this.stockMeasureResult});

  @override
  List<Object> get props => [stockMeasureResult];
}

class StockMeasureError extends StockMeasureState {
  final String error;

  StockMeasureError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== STOCK MEASURE BLOC ========================= //
class StockMeasureBloc extends Bloc<StockMeasureEvent, StockMeasureState> {
  final StockMeasureRepository stockMeasureRepository =
      StockMeasureRepository(stockMeasureApiClient: StockMeasureApiClient());

  StockMeasureBloc() : super(StockMeasureEmpty());

  @override
  Stream<StockMeasureState> mapEventToState(StockMeasureEvent event) async* {
    if (event is StockMeasure) {
      yield StockMeasureLoading();
      try {
        StockMeasureResponseDto responseDto = await stockMeasureRepository
            .getStockMeasure(ip: event.ip, sessionId: event.sessionId);
        yield StockMeasureLoaded(stockMeasureResult: responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        if (ex is RequestTimeoutException) {
          yield StockMeasureError(ex.toString());
        } else {
          yield StockMeasureError(Language.EXCEPTION_BAD_RESPONSE);
        }
      }
    }
  }
}
