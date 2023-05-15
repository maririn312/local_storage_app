// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, use_key_in_widget_constructors, unused_field, avoid_print, unused_element, unused_local_variable, deprecated_member_use, unrelated_type_equality_checks, must_call_super, unused_import, prefer_const_literals_to_create_immutables

import 'dart:convert';

import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_detail_entity.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_entity.dart';
import 'package:abico_warehouse/models/entity/category_entity/category_entity.dart';
import 'package:abico_warehouse/models/screen%20args/auth_args.dart';
import 'package:abico_warehouse/models/screen%20args/sub_category_args.dart';
import 'package:flutter/material.dart';

class CategoryTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CategoryTabState();
  }
}

class _CategoryTabState extends State<CategoryTab> {
  List<CategoryEntity> categoryData = [];
  String ip;
  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void initState() {
    getCategory();
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void dispose() {
    super.dispose();
  }

//mobile sync config oos yum tatj chadsan bol end orj irnee
  getCategory() async {
    List<CategoryEntity> categories = await DBProvider.db.getCategories();
    UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();
    UserEntity users = await DBProvider.db.getUser();
    ip = userDetailEntity.ip;
    setState(() {
      print('end bn shde yuu ch bj bolh bha ${categories.length}');
      categoryData.addAll(categories);
    });
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  Widget build(BuildContext context) {
    print('category urt irnee ${categoryData.length}');
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Container(
        child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, childAspectRatio: 1.9 / 0.5),
            itemCount: categoryData.length,
            itemBuilder: (_, index) {
              print('data index u bn ${categoryData[index].name}');
              return _buildFeaturedCard(
                  title: categoryData[index].name.toString(),
                  image: categoryData[index].icon == false
                      ? null
                      : categoryData[index].icon,
                  categoryEntity: categoryData[index]);
            }),
      ),
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */
//ene zurg texttei haruulj bga hesg menu ge
  Widget _buildFeaturedCard({
    String title,
    String image,
    CategoryEntity categoryEntity,
  }) {
    double size = MediaQuery.of(context).size.height / 11.5;

    final AuthArgs authArg = ModalRoute.of(context).settings.arguments;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, AppTypes.SCREEN_SUB,
            arguments: SubCategoryArg(categoryEntity, ip));
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
