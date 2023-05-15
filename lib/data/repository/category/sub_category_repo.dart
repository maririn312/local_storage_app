// ignore_for_file: avoid_print, missing_return

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/data/service/category/sub_category_api_client.dart';
import 'package:abico_warehouse/models/dto/category/sub_category_response_dto.dart';
import 'package:abico_warehouse/models/entity/category_entity/sub_category_entity.dart';

class SubCategoryRepository {
  final SubCategoryApiClient subCategoryApiClient;

  SubCategoryRepository({@required this.subCategoryApiClient});

  Future<SubCategoryResponseDto> getSubCategoryList({
    String ip,
  }) async {
    print('Sub Category');

    SubCategoryResponseDto subCategoryDto =
        await subCategoryApiClient.getSubCategoryList(ip);

    if (subCategoryDto != null) {
      await DBProvider.db.deleteSubCategories();
      print('SUBcategory urt : ${subCategoryDto.results.length}');
      for (int i = 0; i < subCategoryDto.count; i++) {
        // print('parent Id =========  ${subCategoryDto.result[i].parentId}');
        if (subCategoryDto.results[i].parentId != null) {
          print('parent Id =========  ${subCategoryDto.results[i].parentId}');
          await DBProvider.db.newSubCategory(SubCategoryEntity(
              id: subCategoryDto.results[i].id,
              className: subCategoryDto.results[i].className,
              companyId: subCategoryDto.results[i].companyId,
              sequence: subCategoryDto.results[i].sequence,
              parentId: subCategoryDto.results[i].parentId,
              isSendData: subCategoryDto.results[i].isSendData,
              name: subCategoryDto.results[i].name,
              icon: subCategoryDto.results[i].icon));
        } else {}
      }
    }
    return subCategoryApiClient.getSubCategoryList(ip);
  }
}
