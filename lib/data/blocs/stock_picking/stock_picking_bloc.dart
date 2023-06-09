// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:local_storage_app/data/repository/stock_picking/stock_picking_repo.dart';
// import 'package:local_storage_app/data/service/stock_picking/stock_picking_api_client.dart';
// import 'package:local_storage_app/exceptions/exception_manager.dart';
// import 'package:local_storage_app/exceptions/request_timeout_exception.dart';
// import 'package:local_storage_app/language.dart';
// import 'package:local_storage_app/models/dto/stock_picking/stock_picking_dto.dart';

// abstract class StockPickingEvent extends Equatable {}

// // ====================== STOCK LOCATION EVENT ========================= //
// class StockPicking extends StockPickingEvent {
//   final String ip;
//   StockPicking({this.ip});

//   @override
//   List<Object> get props => [ip];
// }

// // ====================== STOCK LOCATION STATE ========================= //
// abstract class StockPickingState extends Equatable {}

// class StockPickingEmpty extends StockPickingState {
//   @override
//   List<Object> get props => [];
// }

// class StockPickingLoading extends StockPickingState {
//   @override
//   List<Object> get props => [];
// }

// class StockPickingLoaded extends StockPickingState {
//   final List<StockPickingResult> stockPickingResult;

//   StockPickingLoaded({this.stockPickingResult});

//   @override
//   List<Object> get props => [stockPickingResult];
// }

// class StockPickingError extends StockPickingState {
//   final String error;

//   StockPickingError(this.error);

//   @override
//   List<Object> get props => [error];
// }

// // ====================== STOCK LOCATION BLOC ========================= //
// class StockPickingBloc extends Bloc<StockPickingEvent, StockPickingState> {
//   final StockPickingRepository stockLocationRepository =
//       StockPickingRepository(stockPickingApiClient: StockPickingClient());

//   StockPickingBloc() : super(StockPickingEmpty());

//   @override
//   Stream<StockPickingState> mapEventToState(StockPickingEvent event) async* {
//     if (event is StockPicking) {
//       yield StockPickingLoading();
//       try {
//         StockPickingResponseDto responseDto =
//             await stockLocationRepository.getStockPickingList(ip: event.ip);
//         yield StockPickingLoaded(stockPickingResult: responseDto.results);
//       } catch (ex, stacktrace) {
//         ExceptionManager.xMan.captureException(ex, stacktrace);
//         if (ex is RequestTimeoutException) {
//           yield StockPickingError(ex.toString());
//         } else {
//           yield StockPickingError(Language.EXCEPTION_BAD_RESPONSE);
//         }
//       }
//     }
//   }
// }

// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_app/data/repository/stock_picking/stock_picking_repo.dart';
import 'package:local_storage_app/data/service/stock_picking/stock_picking_api_client.dart';
import 'package:local_storage_app/exceptions/exception_manager.dart';
import 'package:local_storage_app/models/dto/stock_picking/stock_picking_dto.dart';

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
