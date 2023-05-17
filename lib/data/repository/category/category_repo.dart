// ignore_for_file: avoid_print

import 'package:flutter/cupertino.dart';
import 'package:abico_warehouse/data/service/category/category_api_client.dart';

class CategoryRepository {
  final CategoryApiClient categoryApiClient;

  CategoryRepository({@required this.categoryApiClient});

  getCategoryList() async {
    print('Category');
    try {
      return categoryApiClient.getCategoryList();
    } catch (e) {}
  }
}
