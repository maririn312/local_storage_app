// import 'package:equatable/equatable.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:local_storage_app/data/repository/product/stock_product_register_repo.dart';
// import 'package:local_storage_app/data/service/product/stock_product_register_api_client.dart';
// import 'package:local_storage_app/exceptions/exception_manager.dart';
// import 'package:local_storage_app/exceptions/request_timeout_exception.dart';
// import 'package:local_storage_app/language.dart';
// import 'package:local_storage_app/models/dto/product/stock_product_register_response_dto.dart';

// abstract class StockProductRegisterListEvent extends Equatable {}

// // ====================== STOCK PRODUCT REGISTER LIST EVENT ========================= //
// class StockProductRegisterList extends StockProductRegisterListEvent {
//   final String ip;
//   final String sessionId;
//   StockProductRegisterList({this.ip, this.sessionId});

//   @override
//   List<Object> get props => [ip, sessionId];
// }

// // ====================== STOCK PRODUCT REGISTER LIST STATE ========================= //
// abstract class StockProductRegisterListState extends Equatable {}

// class StockProductRegisterListEmpty extends StockProductRegisterListState {
//   @override
//   List<Object> get props => [];
// }

// class StockProductRegisterListLoading extends StockProductRegisterListState {
//   @override
//   List<Object> get props => [];
// }

// class StockProductRegisterListLoaded extends StockProductRegisterListState {
//   final List<ProductResult> stockProductRegisterListResult;

//   StockProductRegisterListLoaded({this.stockProductRegisterListResult});

//   @override
//   List<Object> get props => [stockProductRegisterListResult];
// }

// class StockProductRegisterListError extends StockProductRegisterListState {
//   final String error;

//   StockProductRegisterListError(this.error);

//   @override
//   List<Object> get props => [error];
// }

// // ====================== STOCK PRODUCT REGISTER LIST BLOC ========================= //
// class StockProductRegisterListBloc
//     extends Bloc<StockProductRegisterListEvent, StockProductRegisterListState> {
//   final StockProductRegisterListRepository stockProductRegisterListRepository =
//       StockProductRegisterListRepository(
//           stockProductRegisterListApiClient:
//               StockProductRegisterListApiClient());

//   StockProductRegisterListBloc() : super(StockProductRegisterListEmpty());

//   @override
//   Stream<StockProductRegisterListState> mapEventToState(
//       StockProductRegisterListEvent event) async* {
//     if (event is StockProductRegisterList) {
//       yield StockProductRegisterListLoading();
//       try {
//         StockProductRegisterResponseDto responseDto =
//             await stockProductRegisterListRepository
//                 .getStockProductRegisterList(
//                     ip: event.ip, sessionId: event.sessionId);
//         yield StockProductRegisterListLoaded(
//             stockProductRegisterListResult: responseDto.results);
//       } catch (ex, stacktrace) {
//         ExceptionManager.xMan.captureException(ex, stacktrace);
//         if (ex is RequestTimeoutException) {
//           yield StockProductRegisterListError(ex.toString());
//         } else {
//           yield StockProductRegisterListError(Language.EXCEPTION_BAD_RESPONSE);
//         }
//       }
//     }
//   }
// }

// ignore_for_file: non_constant_identifier_names

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_app/data/repository/product/stock_product_register_repo.dart';
import 'package:local_storage_app/data/service/product/stock_product_register_api_client.dart';
import 'package:local_storage_app/exceptions/exception_manager.dart';
import 'package:local_storage_app/models/dto/product/stock_product_register_response_dto.dart';

abstract class StockProductRegisterEvent extends Equatable {}

// ====================== StockProductRegister LIST EVENT ========================= //
class StockProductRegister extends StockProductRegisterEvent {
  final String ip;
  StockProductRegister({this.ip});

  @override
  List<Object> get props => [ip];
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
            await stockProductRegisterRepository.getStockProductRegisterList(
                ip: event.ip);
        yield StockProductRegisterLoaded(responseDto);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockProductRegisterError(ex.toString());
      }
    }
  }
}
