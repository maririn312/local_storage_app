import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_storage_app/data/repository/post/stock_inventory_line_history_post_repo.dart';
import 'package:local_storage_app/data/service/post/stock_inventory_line_history_post_client.dart';
import 'package:local_storage_app/models/dto/put/message_response_dto.dart';

import '../../../exceptions/exception_manager.dart';

abstract class StockInventoryLineHistoryPostEvent extends Equatable {}

// ====================== StockInventoryLineHistoryPost EVENT ========================= //
class StockInventoryLineHistoryPost extends StockInventoryLineHistoryPostEvent {
  final String ip;
  final String id;
  final String time;
  StockInventoryLineHistoryPost({this.ip, this.id, this.time});

  @override
  List<Object> get props => [ip, id, time];
}

// ====================== StockInventoryLineHistoryPost STATE ========================= //
abstract class StockInventoryLineHistoryPostState extends Equatable {}

class StockInventoryLineHistoryPostEmpty
    extends StockInventoryLineHistoryPostState {
  @override
  List<Object> get props => [];
}

class StockInventoryLineHistoryPostLoading
    extends StockInventoryLineHistoryPostState {
  @override
  List<Object> get props => [];
}

class StockInventoryLineHistoryPostLoaded
    extends StockInventoryLineHistoryPostState {
  final MessageResponseDto responseDto;
  StockInventoryLineHistoryPostLoaded(this.responseDto);

  @override
  List<Object> get props => [responseDto];
}

class StockInventoryLineHistoryPostError
    extends StockInventoryLineHistoryPostState {
  final String error;

  StockInventoryLineHistoryPostError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== StockInventoryLineHistoryPost BLOC ========================= //
class StockInventoryLineHistoryPostListBloc extends Bloc<
    StockInventoryLineHistoryPostEvent, StockInventoryLineHistoryPostState> {
  final StockInventoryLineHistoryPostRepository
      stockInventoryLineHistoryPostRepository =
      StockInventoryLineHistoryPostRepository(
          stockInventoryLineHistoryPostApiClient:
              StockInventoryLineHistoryPostApiClient());

  StockInventoryLineHistoryPostListBloc()
      : super(StockInventoryLineHistoryPostEmpty());

  @override
  Stream<StockInventoryLineHistoryPostState> mapEventToState(
      StockInventoryLineHistoryPostEvent event) async* {
    if (event is StockInventoryLineHistoryPost) {
      yield StockInventoryLineHistoryPostLoading();
      try {
        MessageResponseDto responseDto =
            await stockInventoryLineHistoryPostRepository
                .getStockInventoryLineHistoryPostList(
                    ip: event.ip, id: event.id, time: event.time);
        yield StockInventoryLineHistoryPostLoaded(responseDto);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        yield StockInventoryLineHistoryPostError(ex.toString());
      }
    }
  }
}
