// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/components/tenger_error.dart';
import 'package:abico_warehouse/components/tenger_loading_indicator.dart';
import 'package:abico_warehouse/data/blocs/category/category_bloc.dart';
import 'package:abico_warehouse/utils/tenger_global.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryTabState();
  }
}

class _CategoryTabState extends State<CategoryTab> {
  CategoryBloc _categoryBloc;

  @override
  void initState() {
    super.initState();
    _categoryBloc = CategoryBloc();
    _categoryBloc.add(CategoryList());
  }

  @override
  void dispose() {
    _categoryBloc.close();
    super.dispose();
  }

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
      elevation: 0,
      centerTitle: false,
      iconTheme: const IconThemeData(color: Colors.black), // Set the icon color
    );
  }

  Widget _buildCategories() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      bloc: _categoryBloc,
      builder: (context, state) {
        switch (state.runtimeType) {
          case CategoryListLoading:
            return const TengerLoadingIndicator();
          case CategoryListLoaded:
            final loadedState = state as CategoryListLoaded;
            return ListView.builder(
              key:
                  const Key('categoryList'), // Add a key to improve performance
              itemCount: loadedState.categoryResult.length -
                  1, // Exclude the first item
              itemBuilder: (_, index) {
                final category = loadedState.categoryResult[index + 1];
                return _buildFeaturedCard(
                  title: category.name, // Add "+ 1" to adjust the index
                  image: category.icon,
                  className:
                      category.className, // Add "+ 1" to adjust the index
                );
              },
            );
          case CategoryListError:
            final errorState = state as CategoryListError;
            return TengerError(error: errorState.error);
          default:
            return Container();
        }
      },
    );
  }

  Widget _buildFeaturedCard({String title, String image, String className}) {
    final double size = MediaQuery.of(context).size.height / 11.5;

    return InkWell(
      onTap: () {
        switch (className) {
          case TengerGlobal.LABEL_STOCK_PICKING:
            Navigator.pushNamed(context, AppTypes.SCREEN_STOCK_PICKING);
            break;
          case TengerGlobal.LABEL_PRODUCT_PRODUCT:
            Navigator.pushNamed(context, AppTypes.SCREEN_PRODUCT_REGISTER);
            break;
          case TengerGlobal.LABEL_STOCK_INVENTORY:
            Navigator.pushNamed(context, AppTypes.SCREEN_INVENTORY);
            break;
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
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildFeaturedImage(size, image),
              const SizedBox(width: 16),
              _buildFeaturedText(title),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeaturedImage(double size, String image) {
    return Container(
      height: size / 1.2,
      width: size / 1.2,
      decoration: image == null
          ? BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(8),
            )
          : BoxDecoration(
              color: const Color.fromRGBO(104, 26, 81, 0.9),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: MemoryImage(base64Decode(image)),
              ),
              borderRadius: BorderRadius.circular(8),
            ),
    );
  }

  Widget _buildFeaturedText(String title) {
    return Expanded(
      child: Align(
        alignment: Alignment.center,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
