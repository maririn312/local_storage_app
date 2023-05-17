import 'dart:convert';

import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/components/tenger_error.dart';
import 'package:abico_warehouse/components/tenger_loading_indicator.dart';
import 'package:abico_warehouse/data/blocs/category/category_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../models/screen args/sub_category_args.dart';

class CategoryTab extends StatefulWidget {
  const CategoryTab({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CategoryTabState();
  }
}

class _CategoryTabState extends State<CategoryTab> {
  final CategoryBloc _categoryBloc = CategoryBloc();

  @override
  void initState() {
    getCategory();
    super.initState();
  }

  @override
  void dispose() {
    _categoryBloc.close();
    super.dispose();
  }

  getCategory() async {
    _categoryBloc.add(CategoryList());
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
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: false,
    );
  }

  Widget _buildCategories() {
    return BlocBuilder<CategoryBloc, CategoryState>(
      bloc: _categoryBloc,
      builder: (context, state) {
        if (state is CategoryListLoading) {
          return TengerLoadingIndicator();
        } else if (state is CategoryListLoaded) {
          return ListView.builder(
            itemCount:
                state.categoryResult.length, // Show only the first element
            itemBuilder: (_, index) {
              final categoryId = state.categoryResult[index].id;
              final category = state.categoryResult.firstWhere(
                (category) => category.id == categoryId,
                orElse: () => null,
              );

              if (category.companyId == categoryId) {
                final title = category.name;
                final image = category.icon;
                final id = category.id;
                return _buildFeaturedCard(
                  title: title,
                  image: image,
                  catId: id,
                );
              } else {
                return Container();
              }
            },
          );
        } else if (state is CategoryListError) {
          return TengerError(error: state.error);
        }
        return Container();
      },
    );
  }

  Widget _buildFeaturedCard({String title, String image, int catId}) {
    final double size = MediaQuery.of(context).size.height / 11.5;

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          AppTypes.SCREEN_SUB,
          arguments: SubCategoryArg(
            id: catId,
          ),
        );
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
        child: Column(
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Container(
                    height: size / 0.9,
                    width: size / 1.2,
                    margin: const EdgeInsets.symmetric(horizontal: 40),
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
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 50),
                    child: Text(
                      title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
