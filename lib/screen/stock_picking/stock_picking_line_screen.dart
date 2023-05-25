// ignore_for_file: avoid_print, depend_on_referenced_packages, use_build_context_synchronously

import 'package:abico_warehouse/components/alert_dialog/stock_picking_dialog.dart';
import 'package:abico_warehouse/components/tenger_error.dart';
import 'package:abico_warehouse/components/tenger_loading_indicator.dart';
import 'package:abico_warehouse/data/blocs/put/stock_move_put_bloc.dart';
import 'package:abico_warehouse/data/blocs/stock_picking/stock_picking_line_bloc.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_move_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_picking_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/blocs/put/stock_picking_is_checked_put_bloc.dart';
import '../../models/screen args/stock_picking_args.dart';

class StockPickingLineScreen extends StatefulWidget {
  final StockPickingEntity picking;

  const StockPickingLineScreen({Key key, this.picking}) : super(key: key);

  @override
  State<StockPickingLineScreen> createState() => StockPickingLineScreenState();
}

class StockPickingLineScreenState extends State<StockPickingLineScreen> {
  final controller = TextEditingController();

  List<StockMoveLineEntity> stockMoveLineData = [];
  static List<StockMoveLineEntity> stockMoveLine = [];

  List<StockMoveLineEntity> searchMoveLine = List.from(stockMoveLine);

  List intStr = [];
  Map<dynamic, dynamic> someMap = {};
  var result23 = {};
  bool isLoading = false;
  List<StockPickingEntity> stockPickingData = [];
  StockPickingEntity stockPickingUpdate;

  String stateUtgaAvn;
  String query = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//search hiij bga function
  void updateList(String value) {
    setState(() {
      searchMoveLine = stockMoveLine
          .where((element) =>
              element.productName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context);

        return;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: Column(
          children: [
            _buildCardBox(),
          ],
        ),
      ),
    );
  }

//form iin medeelel haruulj bga function ui
  Widget _buildCardBox() {
    StockLocationDetailArg stockPickingArg =
        ModalRoute.of(context).settings.arguments;
    // final StockLocationDetailArg stockpickingArg =
    //     ModalRoute.of(context).settings.arguments;
    return Expanded(
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.symmetric(vertical: 10),
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
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildRow(_buildText('Хүргэлтийн нэр'),
                      _buildResult(stockPickingArg.result.first.name)),
                  //stockpickingArg.result.first.name.toString())),
                  _buildRow(_buildText('Агуулахын баримтын төрөл'),
                      _buildResult('' ?? 'Хоосон')),
                  _buildRow(
                      _buildText('Эх байрлал'), _buildResult('' ?? 'Хоосон')),
                  _buildRow(_buildText('Товлосон огноо'), _buildResult('')),
                  _buildRow(_buildText('Эх баримт'), _buildResult('')),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(Widget text, Widget hoinoosAvhUtga) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        text,
        hoinoosAvhUtga,
      ],
    );
  }

  Widget _buildText(String text) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            '$text:' ?? 'Хоосон',
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          )),
    );
  }

  Widget _buildText2(String text) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text ?? 'Хоосон',
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.end,
          )),
    );
  }

//text avj bga ehneese ehlne
  Widget _buildResult(String text) {
    return Expanded(
      child: Text(
        text ?? 'Хоосон',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
