// ignore_for_file: sized_box_for_whitespace, avoid_unnecessary_containers, use_key_in_widget_constructors, unused_field, avoid_print, unused_element, unused_local_variable, unrelated_type_equality_checks, unused_import, unused_label, must_call_super, unnecessary_const

import 'dart:convert';

import 'package:abico_warehouse/components/tenger_error.dart';
import 'package:abico_warehouse/components/tenger_loading_indicator.dart';
import 'package:abico_warehouse/models/dto/category/sub_category_response_dto.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/models/entity/category_entity/sub_category_entity.dart';
import 'package:abico_warehouse/models/screen%20args/sub_category_args.dart';
import 'package:abico_warehouse/models/screen%20args/product_product_args.dart';
import 'package:abico_warehouse/utils/tenger_global.dart';

import '../../../data/blocs/category/sub_category_bloc.dart';

class SubCategoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SubCategoryScreenState();
  }
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  final SubCategoryBloc _subCategoryBloc = SubCategoryBloc();

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void initState() {
    _subCategoryBloc.add(SubCategoryList());
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void dispose() {
    super.dispose();
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

    return Container(
      height: MediaQuery.of(context).size.height,
      child: BlocBuilder<SubCategoryBloc, SubCategoryState>(
        bloc: _subCategoryBloc,
        builder: (context, state) {
          if (state is SubCategoryListLoading) {
            return TengerLoadingIndicator();
          } else if (state is SubCategoryListLoaded) {
            final matchingSubCategories = state.subCategoryResult.where(
              (subCategory) => subCategory.parentId == subCategArg.id,
            );

            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1,
                childAspectRatio: 1.9 / 0.5,
              ),
              itemCount: matchingSubCategories.length,
              itemBuilder: (_, index) {
                final subCategory = matchingSubCategories.elementAt(index);
                final title = subCategory.name;
                final image = subCategory.icon;
                final className = subCategory.className;
                return _buildFeaturedCard(
                    title: title, image: image, classname: className);
              },
            );
          } else if (state is SubCategoryListError) {
            return TengerError(error: state.error);
          }
          return Container();
        },
      ),
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */
  //class name n tengerglobal tai tengtsuu bvl tuhain screen ruu oruulj bga function
  Widget _buildFeaturedCard({String title, String image, String classname}) {
    double size = MediaQuery.of(context).size.height / 11.5; //5;

    final SubCategoryArg subCategoryArg =
        ModalRoute.of(context).settings.arguments;
    return GestureDetector(
      onTap: () {
        if (classname == TengerGlobal.LABEL_STOCK_PICKING) {
          Navigator.pushNamed(context, AppTypes.SCREEN_STOCK_PICKING);
        } else if (classname == TengerGlobal.LABEL_PRODUCT_PRODUCT) {
          Navigator.pushNamed(
            context,
            AppTypes.SCREEN_PRODUCT_REGISTER,
          );
        } else if (classname == TengerGlobal.LABEL_STOCK_INVENTORY) {
          Navigator.pushNamed(context, AppTypes.SCREEN_INVENTORY);
        }
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
