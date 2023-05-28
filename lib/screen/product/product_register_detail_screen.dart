// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, unused_import, unused_element, avoid_unnecessary_containers, sized_box_for_whitespace, unnecessary_string_interpolations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/screen%20args/product_register_detail_args.dart';

class ProductRegisterDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductRegisterDetailScreenState();
  }
}

class _ProductRegisterDetailScreenState
    extends State<ProductRegisterDetailScreen> {
  /* ================================================================================== */
  /* ================================================================================== */

  @override
  void initState() {
    super.initState();
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void dispose() {
    super.dispose();
  }

// db relation hiij bga function uud
  Future<String> getMeasureName(int id) async {
    final DBProvider _databaseService = DBProvider();
    final measureName = await _databaseService.measureName(id);
    return measureName.name;
  }

  Future<String> getCompanyName(int id) async {
    final DBProvider _databaseService = DBProvider();
    final companyName = await _databaseService.companyName(id);
    return companyName.name;
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomInset: true,
          // Theme.of(context).colorScheme.surface,
          appBar: _buildAppBar(),
          body: SingleChildScrollView(
            child: Column(children: [_buildCardBox()]),
          )),
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */
  //defualt app bar
  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: false,
      // ignore: prefer_const_literals_to_create_immutables
      actions: [
        const IconButton(
          onPressed: null,
          icon: Icon(Icons.youtube_searched_for_rounded),
        )
      ],
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */
// ui bichej bga hesg
  Widget _buildCardBox() {
    double size = 163;
    double circlesize = 20;
    final ProductRegisterDetailArg detailArg =
        ModalRoute.of(context).settings.arguments;
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.only(top: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 220,
                    width: 220,
                    decoration: detailArg.result.image128 == null
                        ? null
                        : BoxDecoration(
                            color: const Color.fromARGB(227, 6, 32, 179),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(
                                    base64Decode(detailArg.result.image128))),
                            borderRadius: BorderRadius.circular(10)),
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
        Container(
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
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildRowText(_buildLeftTextStyle(Language.LABEL_DETAIL_NAME),
                  _buildRightTextStyle(detailArg.result.name)),
              // _buildRowText(
              //     _buildLeftTextStyle(Language.LABEL_DETAIL_CATEGORY_ID),
              //     _buildRightRelacion(
              //         getBreedName(detailArg.result.categId))),
              _buildRowText(
                  _buildLeftTextStyle(Language.LABEL_BARCODE_CODE),
                  _buildRightTextStyle(detailArg.result.barcode == null
                      ? 'Хоосон'
                      : detailArg.result.barcode.toString())),
              _buildRowText(
                  _buildLeftTextStyle(Language.LABEL_DETAIL_PRODUCT_CODE),
                  _buildRightTextStyle(detailArg.result.defaultCode)),
              _buildRowText(
                  _buildLeftTextStyle(Language.LABEL_PRODUCT_PRICE),
                  _buildRightTextStyle(detailArg.result.listPrice == null
                      ? 'Хоосон'
                      : detailArg.result.listPrice.toString())),
              _buildRowText(
                  _buildLeftTextStyle(Language.LABEL_DETIAL_PRODUCT_TYPE),
                  _buildRightTextStyle((detailArg.result.type == 'Type.PRODUCT')
                      ? 'Нөөцлөх бараа'
                      : (detailArg.result.type == 'Type.SERVICE')
                          ? 'Үйлчилгээ'
                          : 'Хангамжийн')),
              _buildRowText(
                  _buildLeftTextStyle(Language.LABEL_DETAIL_PRODUCT_WEIGHT),
                  _buildRightTextStyle(detailArg.result.weight == null
                      ? 'Хоосон'
                      : detailArg.result.weight.toString())),
              _buildRowText(
                  _buildLeftTextStyle(Language.LABEL_DETIAL_PRODUCT_VOLUME),
                  _buildRightTextStyle(detailArg.result.volume == null
                      ? 'Хоосон'
                      : detailArg.result.volume.toString())),
              _buildRowText(
                  _buildLeftTextStyle(Language.LABEL_DETAIL_PRODUCT_UOMID),
                  _buildRightRelacion(
                    getMeasureName(detailArg.result.uomId),
                  )),
              _buildRowText(
                  _buildLeftTextStyle(Language.LABEL_DETAIL_PRODUCT_COMPANY),
                  _buildRightRelacion(
                      getCompanyName(detailArg.result.companyId))),
            ],
          ),
        ),
      ],
    );
  }

  //1row dotor 2utga avn ene 2n ehlel bolon togsgol deer bairlana
  Widget _buildRowText(Widget text, Widget data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Expanded(child: text), Expanded(child: data)],
      ),
    );
  }

//text duudaj bga function containeriin hoino
  Widget _buildRightTextStyle(String text) {
    return Text(
      text ?? 'Хоосон',
      style: const TextStyle(color: Colors.white, fontSize: 14),
      textAlign: TextAlign.end,
    );
  }

//ehlehed bh textiig oruulj baiga dunction
  Widget _buildLeftTextStyle(String text) {
    return Text('$text:' ?? 'Хоосон',
        style: const TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.start);
  }

//id irj bga talbariin zov utgiig oruulj bga function suulees n bichegdene
  Widget _buildRightRelacion(Future test) {
    return FutureBuilder<String>(
      future: test,
      builder: (context, name) {
        return Text(name.data ?? 'Хоосон',
            style: const TextStyle(color: Colors.white, fontSize: 14),
            textAlign: TextAlign.end);
      },
    );
  }
}
