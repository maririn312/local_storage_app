// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, unused_import, deprecated_member_use, equal_keys_in_map, avoid_print, unused_element, unnecessary_this

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/componenets/search_widget.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/entity/stock_entity/product_entity/stock_product_register_entity.dart';
import 'package:abico_warehouse/models/screen%20args/product_register_detail_args.dart';

class ProductRegisterScreen extends StatefulWidget {
  final dynamic data;
  const ProductRegisterScreen({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _ProductRegisterScreenState();
  }
}

class _ProductRegisterScreenState extends State<ProductRegisterScreen> {
  String query = '';
  List<StockProductRegisterEntity> productRegisterData = [];

  @override
  void initState() {
    getProductRegister();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> getProductRegister() async {
    final List<StockProductRegisterEntity> productRegister =
        await DBProvider.db.getProductRegister();
    setState(() {
      productRegisterData.addAll(productRegister);
    });
  }

  Future<String> getMeasureName(int id) async {
    final DBProvider _databaseService = DBProvider();
    final measureName = await _databaseService.measureName(id);
    return measureName.name;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: _buildAppBar(),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildSearch(),
            _buildListBoxGroup(),
          ],
        ),
      ),
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

  void searchData(String query) async {
    final List<StockProductRegisterEntity> saleOrder =
        await DBProvider.db.getProductRegister();
    final data = saleOrder.where((datas) {
      final titleLower = datas.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.productRegisterData = data;
    });
  }

  Widget _buildSearch() => SearchWidget(
        text: query,
        hintText: Language.LABEL_SEARCH,
        onChanged: searchData,
      );

  Widget _buildListBoxGroup() {
    final double height = MediaQuery.of(context).size.height - 160;

    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: height,
      child: _buildScreen(),
    );
  }

  Widget _buildScreen() {
    return ListView.separated(
      itemCount: productRegisterData.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, index) {
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppTypes.SCREEN_PRODUCT_REGISTER_DETAIL,
              arguments: ProductRegisterDetailArg(productRegisterData[index]),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
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
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 100,
                  width: 100,
                  decoration: productRegisterData[index].image128 == null
                      ? null
                      : BoxDecoration(
                          color: const Color.fromARGB(227, 6, 32, 179),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: MemoryImage(
                              base64Decode(productRegisterData[index].image128),
                            ),
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        _buildRow(
                          _buildText(
                              Language.LABEL_Product_Register_Product_Name),
                          _buildTextEnd(productRegisterData[index].name),
                        ),
                        _buildRow(
                          _buildText(Language.LABEL_Product_Register_Barcode),
                          _buildTextEnd(productRegisterData[index].barcode),
                        ),
                        _buildRow(
                          _buildText(
                              Language.LABEL_Product_Register_Default_Code),
                          _buildTextEnd(productRegisterData[index].defaultCode),
                        ),
                        _buildRow(
                          _buildText(Language.LABEL_Product_Register_Uom),
                          _buildRightRelacion(
                              getMeasureName(productRegisterData[index].uomId)),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildRow(Widget defualtText, Widget dynamicText) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        defualtText,
        Expanded(child: dynamicText),
      ],
    );
  }

  Widget _buildText(String text) {
    return Text(
      '$text:',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
    );
  }

  Widget _buildTextEnd(String text) {
    return Text(
      text ?? 'Хоосон',
      style: const TextStyle(
        color: Colors.white,
        fontSize: 14,
      ),
      textAlign: TextAlign.end,
    );
  }

  Widget _buildRightRelacion(Future<String> test) {
    return FutureBuilder<String>(
      future: test,
      builder: (context, snapshot) {
        return Text(
          snapshot.data ?? 'Хоосон',
          style: const TextStyle(color: Colors.white, fontSize: 12),
          textAlign: TextAlign.end,
        );
      },
    );
  }
}
