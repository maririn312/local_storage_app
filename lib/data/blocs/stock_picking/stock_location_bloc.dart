import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_app/data/repository/stock_picking/stock_location_repo.dart';
import 'package:local_storage_app/data/service/stock_picking/stock_location_api_client.dart';
import 'package:local_storage_app/exceptions/exception_manager.dart';
import 'package:local_storage_app/exceptions/request_timeout_exception.dart';
import 'package:local_storage_app/language.dart';
import 'package:local_storage_app/models/dto/stock_picking/stock_location_response_dto.dart';

abstract class StockLocationEvent extends Equatable {}

// ====================== STOCK LOCATION EVENT ========================= //
class StockLocation extends StockLocationEvent {
  final String ip;
  final String sessionId;
  StockLocation({this.ip, this.sessionId});

  @override
  List<Object> get props => [ip, sessionId];
}

// ====================== STOCK LOCATION STATE ========================= //
abstract class StockLocationState extends Equatable {}

class StockLocationEmpty extends StockLocationState {
  @override
  List<Object> get props => [];
}

class StockLocationLoading extends StockLocationState {
  @override
  List<Object> get props => [];
}

class StockLocationLoaded extends StockLocationState {
  final List<StockLocationResult> stockLocationResult;

  StockLocationLoaded({this.stockLocationResult});

  @override
  List<Object> get props => [stockLocationResult];
}

class StockLocationError extends StockLocationState {
  final String error;

  StockLocationError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== STOCK LOCATION BLOC ========================= //
class StockLocationBloc extends Bloc<StockLocationEvent, StockLocationState> {
  final StockLocationRepository stockLocationRepository =
      StockLocationRepository(stockLocationApiClient: StockLocationApiClient());

  StockLocationBloc() : super(StockLocationEmpty());

  @override
  Stream<StockLocationState> mapEventToState(StockLocationEvent event) async* {
    if (event is StockLocation) {
      yield StockLocationLoading();
      try {
        StockLocationResponseDto responseDto = await stockLocationRepository
            .getStockLocation(ip: event.ip, sessionId: event.sessionId);
        yield StockLocationLoaded(stockLocationResult: responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        if (ex is RequestTimeoutException) {
          yield StockLocationError(ex.toString());
        } else {
          yield StockLocationError(Language.EXCEPTION_BAD_RESPONSE);
        }
      }
    }
  }
}
