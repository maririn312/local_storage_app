// ignore_for_file: depend_on_referenced_packages

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/repository/category/category_repo.dart';
import 'package:abico_warehouse/data/service/category/category_api_client.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/exceptions/request_timeout_exception.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/category/category_response_dto.dart';

// ====================== GIFT EVENT ========================= //
abstract class CategoryEvent extends Equatable {}

class CategoryList extends CategoryEvent {
  @override
  List<Object> get props => [];
}

class CategoryParentId extends CategoryEvent {
  final int id;

  CategoryParentId(this.id);

  @override
  List<Object> get props => [id];
}

// ====================== GIFT STATE ========================= //
abstract class CategoryState extends Equatable {}

class CategoryListEmpty extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryListLoading extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryListLoaded extends CategoryState {
  final List<CategoryResult> categoryResult;

  CategoryListLoaded({this.categoryResult});

  @override
  List<Object> get props => [categoryResult];
}

class CategoryListError extends CategoryState {
  final String error;

  CategoryListError(this.error);

  @override
  List<Object> get props => [error];
}

// ====================== GIFT BLOC ========================= //
class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  final CategoryRepository categoryRepository;

  CategoryBloc()
      : categoryRepository =
            CategoryRepository(categoryApiClient: CategoryApiClient()),
        super(CategoryListEmpty());

  @override
  Stream<CategoryState> mapEventToState(CategoryEvent event) async* {
    if (event is CategoryList) {
      yield CategoryListLoading();
      try {
        CategoryResponseDto responseDto =
            await categoryRepository.getCategoryList();
        yield CategoryListLoaded(categoryResult: responseDto.results);
      } catch (ex, stacktrace) {
        ExceptionManager.xMan.captureException(ex, stacktrace);
        if (ex is RequestTimeoutException) {
          yield CategoryListError(ex.toString());
        } else {
          yield CategoryListError(Language.EXCEPTION_BAD_RESPONSE);
        }
      }
    }
  }
}
