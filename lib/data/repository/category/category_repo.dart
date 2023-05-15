// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/category/category_api_client.dart';
import 'package:abico_warehouse/models/dto/category/category_response_dto.dart';
import 'package:abico_warehouse/models/entity/category_entity/category_entity.dart';

class CategoryRepository {
  final CategoryApiClient categoryApiClient;

  CategoryRepository({@required this.categoryApiClient});

  getCategoryList(
    String ip,
  ) async {
    print('Category');
    try {
      CategoryResponseDto categoryDto = await categoryApiClient.getCategoryList(
        ip: ip,
      );

      if (categoryDto != null) {
        await DBProvider.db.deleteCategories();
        print('category urt : ${categoryDto.results.length}');
        for (int i = 0; i < categoryDto.count; i++) {
          await DBProvider.db.newCategory(CategoryEntity(
              id: categoryDto.results[i].id,
              companyId: categoryDto.results[i].companyId,
              sequence: categoryDto.results[i].sequence,
              isSendData: categoryDto.results[i].isSendData,
              name: categoryDto.results[i].name,
              icon: categoryDto.results[i].icon));
        }
      }
      return categoryApiClient.getCategoryList(
        ip: ip,
      );
      // ignore: empty_catches
    } catch (e) {}
  }
}
