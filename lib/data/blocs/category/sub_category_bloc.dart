// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/category/sub_category_repo.dart';
import 'package:abico_warehouse/data/service/category/sub_category_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/category/sub_category_response_dto.dart';

abstract class SubCategoryEvent extends Equatable {}

class SubCategoryList extends SubCategoryEvent {
  SubCategoryList();

  @override
  List<Object> get props => [];
}

// ====================== SUB CATEGORY STATE ========================= //
abstract class SubCategoryState extends Equatable {}

class SubCategoryListEmpty extends SubCategoryState {
  @override
  List<Object> get props => [];
}

class SubCategoryListLoading extends SubCategoryState {
  @override
  List<Object> get props => [];
}

class SubCategoryListLoaded extends SubCategoryState {
  final List<SubCategoryResult> subCategoryResult;

  SubCategoryListLoaded({this.subCategoryResult});

  @override
  List<Object> get props => [subCategoryResult];
}

class SubCategoryListError extends SubCategoryState {
  final String error;

  SubCategoryListError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== SUB CATEGORY BLOC ========================= //
class SubCategoryBloc extends Bloc<SubCategoryEvent, SubCategoryState> {
  final SubCategoryRepository subCategoryRepository =
      SubCategoryRepository(subCategoryApiClient: SubCategoryApiClient());

  SubCategoryBloc() : super(SubCategoryListEmpty());

  @override
  Stream<SubCategoryState> mapEventToState(SubCategoryEvent event) async* {
    if (event is SubCategoryList) {
      yield SubCategoryListLoading();
      try {
        SubCategoryResponseDto responseDto =
            await subCategoryRepository.getSubCategoryList();
        yield SubCategoryListLoaded(subCategoryResult: responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        if (ex is RequestTimeoutException) {
          yield SubCategoryListError(ex.toString());
        } else {
          yield SubCategoryListError(Language.EXCEPTION_BAD_RESPONSE);
        }
      }
    }
  }
}
