import 'package:local_storage_app/models/entity/category_entity/category_entity.dart';

class SubCategoryArg {
  final String ip;
  final CategoryEntity categoryEntity;
  SubCategoryArg(this.categoryEntity, this.ip);
}
