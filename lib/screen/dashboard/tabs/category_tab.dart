// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, use_key_in_widget_constructors, unused_field, avoid_print, unused_element, unused_local_variable, unrelated_type_equality_checks, unused_import, unused_label, must_call_super, unnecessary_const, depend_on_referenced_packages

import 'dart:convert';

import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/models/entity/category_entity/sub_category_entity.dart';
import 'package:abico_warehouse/models/screen%20args/product_product_args.dart';
import 'package:abico_warehouse/models/screen%20args/sub_category_args.dart';
import 'package:abico_warehouse/utils/tenger_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryTabState();
  }
}

class _CategoryTabState extends State<CategoryTab> {
  List<SubCategoryEntity> subCategoryData = [];
  List<SubCategoryEntity> category = [];

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void initState() {
    getSubCategory();
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void dispose() {
    super.dispose();
  }

//sub category medeelel tatj bga hesg db gees
  getSubCategory() async {
    List<SubCategoryEntity> subCategories =
        await DBProvider.db.getSubCategories();
    setState(() {
      subCategoryData.addAll(subCategories);
    });
  }

  /* ================================================================================== */
  /* ================================================================================== */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(),
      body: _buildCategories(),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: false,
    );
  }

//ui icon text hargdj bga funtion
  Widget _buildCategories() {
    final SubCategoryArg subCategArg =
        ModalRoute.of(context).settings.arguments;
    if (category.isEmpty) {
      for (int i = 0; i < subCategoryData.length; i++) {
        if (subCategArg.categoryEntity.id == subCategoryData[i].parentId) {
          category.add(subCategoryData[i]);
        }
      }
    } else {}
    return Container(
      height: MediaQuery.of(context).size.height,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1, childAspectRatio: 1.9 / 0.5),
          itemCount: category.length,
          itemBuilder: (_, index) {
            print('end urt irnee ${category.length}');
            return _buildFeaturedCard(
                title: category[index].name.toString(),
                image:
                    category[index].icon == false ? '' : category[index].icon,
                subCategoryEntity: category[index]);
          }),
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */
  //class name n tengerglobal tai tengtsuu bvl tuhain screen ruu oruulj bga function
  Widget _buildFeaturedCard(
      {String title, String image, SubCategoryEntity subCategoryEntity}) {
    double size = MediaQuery.of(context).size.height / 11.5; //5;

    final SubCategoryArg subCategoryArg =
        ModalRoute.of(context).settings.arguments;
    return GestureDetector(
      onTap: () {
        if (subCategoryEntity.className == TengerGlobal.LABEL_STOCK_PICKING) {
          print(
              ' subCategory ${subCategoryEntity.className} : ${TengerGlobal.LABEL_STOCK_PICKING}');

          Navigator.pushNamed(context, AppTypes.SCREEN_STOCK_PICKING);
        }
        if (subCategoryEntity.className == TengerGlobal.LABEL_PRODUCT_PRODUCT) {
          print(
              ' subCategory ${subCategoryEntity.className} : ${TengerGlobal.LABEL_PRODUCT_PRODUCT}');

          Navigator.pushNamed(context, AppTypes.SCREEN_PRODUCT_REGISTER,
              arguments: ProductProductArgs(subCategoryArg.ip));
        }
        if (subCategoryEntity.className == TengerGlobal.LABEL_STOCK_INVENTORY) {
          print(
              ' subCategory ${subCategoryEntity.className} : ${TengerGlobal.LABEL_STOCK_INVENTORY}');

          Navigator.pushNamed(context, AppTypes.SCREEN_INVENTORY);
        }
        print('class Name');
        print(subCategoryEntity.className);
      },
      child: Container(
        margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
        decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(206, 226, 105, 145),
                Color.fromRGBO(104, 26, 81, 0.9),
              ],
            ),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: size / 1.2,
                  width: size / 1.2,
                  margin: const EdgeInsets.symmetric(horizontal: 40),
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: image == null
                      ? BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(8))
                      : BoxDecoration(
                          color: const Color.fromRGBO(104, 26, 81, 0.9),
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: MemoryImage(base64Decode(image))),
                          borderRadius: BorderRadius.circular(8)),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 50),
                    child: Text(title,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
