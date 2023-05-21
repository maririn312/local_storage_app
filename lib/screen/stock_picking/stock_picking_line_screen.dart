// ignore_for_file: avoid_print, depend_on_referenced_packages, use_build_context_synchronously

import 'package:abico_warehouse/components/alert_dialog/stock_picking_dialog.dart';
import 'package:abico_warehouse/components/tenger_error.dart';
import 'package:abico_warehouse/components/tenger_loading_indicator.dart';
import 'package:abico_warehouse/data/blocs/put/stock_move_put_bloc.dart';
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
  final StockMovePutListBloc _stockMovePutBloc = StockMovePutListBloc();

  final StockPickingIsActivePutListBloc _stockPickingPutBloc =
      StockPickingIsActivePutListBloc();
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
    getStockPicking();
    refreshForm();
  }

  @override
  void dispose() {
    super.dispose();
  }

//barcode unshihad omnoh buyu ene screeniig dhij uldegdel harj bga function n
  Future refreshForm() async {
    setState(() => isLoading = true);

    stockMoveLineData = await DBProvider.db.getStockMoveLine();
    final StockLocationDetailArg stockpickingArg =
        ModalRoute.of(context).settings.arguments;
    if (stockMoveLine.isEmpty) {
      for (int i = 0; i < stockMoveLineData.length; i++) {
        if (stockpickingArg.result[i].id == stockMoveLineData[i].pickingId) {
          setState(() {
            stockMoveLine.add(stockMoveLineData[i]);
            searchMoveLine = List.from(stockMoveLine);
          });
        }
      }
    } else {
      stockMoveLine.clear();
      for (int i = 0; i < stockMoveLineData.length; i++) {
        if (stockpickingArg.result[i].id == stockMoveLineData[i].pickingId) {
          setState(() {
            stockMoveLine.add(stockMoveLineData[i]);
          });
        }
      }
    }
    setState(() => isLoading = false);
  }

//db gees medeelel tatj bga function
  getStockPicking() async {
    List<StockMoveLineEntity> stockMoveLine =
        await DBProvider.db.getStockMoveLine();
    setState(() {
      stockMoveLineData.addAll(stockMoveLine);
    });
  }

  getStockPickingForm() async {
    List<StockPickingEntity> pickingForm =
        await DBProvider.db.getStockPicking();
    setState(() {
      stockPickingData.addAll(pickingForm);
    });
  }

// db deerees releation hiij bga zuilsiin functions
  Future<String> getPartnerName(int id) async {
    final DBProvider databaseService = DBProvider();
    final partner = await databaseService.partnerName(id);
    return partner.name;
  }

  Future<String> getLocationName(int id) async {
    final DBProvider databaseService = DBProvider();
    final location = await databaseService.stockLoacationName(id);
    return location.name;
  }

  Future<String> getPickingTypeName(int id) async {
    final DBProvider databaseService = DBProvider();
    final location = await databaseService.pickingTypeName(id);
    return location.name;
  }

  Future<String> getUserName(int id) async {
    final DBProvider databaseService = DBProvider();
    final user = await databaseService.userName(id);
    return user.name;
  }

  Future<String> getProductName(int id) async {
    final DBProvider databaseService = DBProvider();
    final product = await databaseService.productName(id);
    return product.name;
  }

  Future<String> getProductBarcode(int id) async {
    final DBProvider databaseService = DBProvider();
    final product = await databaseService.productName(id);
    return product.barcode;
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
            _buildButton(),
            _builtDefualtText(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                onChanged: (value) => updateList(value),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    hintText: Language.LABEL_SEARCH,
                    prefixIcon: const Icon(Icons.search),
                    prefixIconColor: Colors.black),
              ),
            ),
            _buildLineCardList(),
          ],
        ),
      ),
    );
  }

//door bga 3n textiig haruulj bga function
  Widget _builtDefualtText() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Color.fromARGB(206, 226, 105, 145),
              Color.fromRGBO(104, 26, 81, 0.9),
            ],
          ),
          borderRadius: BorderRadius.circular(5)),
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildText("Бараа"),
          _buildText('Бэлдэх тоо'),
          _buildText2('Бэлдсэн тоо')
        ],
      ),
    );
  }

//form iin medeelel haruulj bga function ui
  Widget _buildCardBox() {
    final StockLocationDetailArg stockpickingArg =
        ModalRoute.of(context).settings.arguments;
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
                  _buildRow(
                      _buildText('Хүргэлтийн нэр'),
                      _buildResult(
                          stockpickingArg.result.first.name.toString())),
                  _buildRow(
                    _buildText('Агуулахын баримтын төрөл'),
                    FutureBuilder<String>(
                      future: getPickingTypeName(
                          stockpickingArg.result.first.pickingTypeId),
                      builder: (context, pickingTypeName) {
                        return _buildResult(pickingTypeName.data ?? 'Хоосон');
                      },
                    ),
                  ),
                  _buildRow(
                    _buildText('Эх байрлал'),
                    FutureBuilder<String>(
                      future: getLocationName(
                          stockpickingArg.result.first.locationId),
                      builder: (context, locationName) {
                        return _buildResult(locationName.data ?? 'Хоосон');
                      },
                    ),
                  ),
                  _buildRow(
                      _buildText('Товлосон огноо'),
                      _buildResult(stockpickingArg.result.first.scheduledDate
                          .toString()
                          .substring(0, 10))),
                  _buildRow(_buildText('Эх баримт'),
                      _buildResult(stockpickingArg.result.first.origin)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

//screen deer bga tovchuudiig end bichsen
  Widget _buildButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ElevatedButton(
          onPressed: () {
            setState(() {
              final StockLocationDetailArg stockpickingArg =
                  ModalRoute.of(context).settings.arguments;
              _stockPickingPutBloc.add(
                StockPickingIsActivePut(
                  id: stockpickingArg.result.first.id.toString(),
                ),
              );
            });
            showDialog<String>(
              context: context,
              builder: (BuildContext context) => AlertDialog(
                title: BlocBuilder(
                  bloc: _stockPickingPutBloc,
                  // ignore: missing_return
                  builder: (_, state) {
                    if (state is StockPickingIsActivePutLoading) {
                      return const Center(
                          child: SizedBox(
                              height: 70,
                              width: 70,
                              child: TengerLoadingIndicator()));
                    } else if (state is StockPickingIsActivePutLoaded) {
                      stateUtgaAvn = state.responseDto.isChecked;
                      return (state.responseDto.isChecked == 'half_checked')
                          ? const Text('Дутуу шалгасан')
                          : const Text('Бүрэн шалгасан');
                    } else if (state is StockPickingIsActivePutError) {
                      return Center(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          child: TengerError(
                            error: state.error,
                          ),
                        ),
                      );
                    }
                  },
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      if (stateUtgaAvn == "checked") {
                        deleteNote();
                      } else if (stateUtgaAvn == 'half_checked') {
                        updateNote();
                      } else {
                        updateNote();
                      }
                    },
                    child: const Text('OK'),
                  ),
                ],
              ),
            );
          },
          child: const Text(
            Language.CHECK,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _scanPlus();
          },
          child: const Text(
            'Нэгээр',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            _scan();
          },
          child: const Text(
            'Олноор',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      ],
    );
  }

//barcode unshij olonoor buyu oor alert luu oruulj too oruulhasd eniig ashgilj bga
  Future<void> _scan() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      for (var v in someMap.values) {
        print('end mapiin urt irnee ${someMap.keys.first}');
        print('end mapiin urt irnee ${someMap.length}');

        print('end barcode irnee $barcodeScanRes');
        print('barcode hevlene $v');
        print('end urt hevlene ${stockMoveLine.length}');
      }
      someMap.forEach((i, value) async {
        if (barcodeScanRes == value) {
          for (int z = 0; z < stockMoveLine.length; z++) {
            if (stockMoveLine[z].id == i) {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return StockPickingDialog(note: stockMoveLine[z]);
                  });
            }

            refreshForm();
          }
        } else {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(
              'Бараа олдсоггүй',
              textAlign: TextAlign.center,
            )));
        }
      });
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {});
  }

//bar code unshuulj negeer nemhed eniig ashgiulnaa
  Future<void> _scanPlus() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      // for (var v in someMap.values) {
      //   print(v);
      // }
      someMap.forEach((i, value) async {
        if (barcodeScanRes == value) {
          for (int z = 0; z < stockMoveLine.length; z++) {
            if (stockMoveLine[z].id == i) {
              int checkQty = stockMoveLine[z].checkQty.toInt();
              int too = checkQty + 1;
              if (stockMoveLine[z].productUomQty >= too) {
                await DBProvider.db.updateStockMoveLine(StockMoveLineEntity(
                  id: stockMoveLine[z].id,
                  productId: stockMoveLine[z].productId,
                  descriptionPicking: stockMoveLine[z].descriptionPicking,
                  dateExpected: stockMoveLine[z].dateExpected,
                  quantityDone: stockMoveLine[z].quantityDone,
                  productUom: stockMoveLine[z].productUom,
                  productUomQty: stockMoveLine[z].productUomQty,
                  pickingId: stockMoveLine[z].pickingId,
                  checkQty: too.toDouble(),
                  diffQty: stockMoveLine[z].diffQty,
                  barcode: stockMoveLine[z].barcode,
                  productName: stockMoveLine[z].productName,
                ));
                _stockMovePutBloc.add(
                  StockMovePut(
                    ip: '49.0.129.18:9393',
                    id: stockMoveLine[z].id.toString(),
                    time: too.toString(),
                  ),
                );
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                      content: Text(
                    'Амжилттай',
                    textAlign: TextAlign.center,
                  )));
              } else {
                ScaffoldMessenger.of(context)
                  ..removeCurrentSnackBar()
                  ..showSnackBar(const SnackBar(
                      content: Text(
                    'Барааг нэгээр нэмэх боломжгүй байна',
                    textAlign: TextAlign.center,
                  )));
              }
            }

            refreshForm();
          }
        } else {
          ScaffoldMessenger.of(context)
            ..removeCurrentSnackBar()
            ..showSnackBar(const SnackBar(
                content: Text(
              'Бараа олдсоггүй',
              textAlign: TextAlign.center,
            )));
        }
      });
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {});
  }

//ene bol yag line haruulj bga function n nohtsoloos hamaarj end taarsan id nuud haruulj bga
  Widget _buildLineCardList() {
    double height = MediaQuery.of(context).size.height - 385;
    final StockLocationDetailArg stockpickingArg =
        ModalRoute.of(context).settings.arguments;
    if (stockMoveLine.isEmpty) {
      for (int i = 0; i < stockMoveLineData.length; i++) {
        if (stockpickingArg.result.first.id == stockMoveLineData[i].pickingId) {
          setState(() {
            stockMoveLine.add(stockMoveLineData[i]);
            searchMoveLine = List.from(stockMoveLine);
            for (int s = 0; s < stockMoveLine.length; s++) {
              someMap[stockMoveLine[s].id] = stockMoveLine[s].barcode;
            }
          });
        }
      }
    } else {
      stockMoveLine.clear();
      for (int i = 0; i < stockMoveLineData.length; i++) {
        if (stockpickingArg.result.first.id == stockMoveLineData[i].pickingId) {
          setState(() {
            stockMoveLine.add(stockMoveLineData[i]);
            for (int s = 0; s < stockMoveLine.length; s++) {
              someMap[stockMoveLine[s].id] = stockMoveLine[s].barcode;
            }
          });
        }
      }
    }

    return SingleChildScrollView(
      child: SizedBox(
        height: height,
        child: ListView.builder(
            itemCount: searchMoveLine.length,
            itemBuilder: (_, index) {
              return Container(
                margin:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide()),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                searchMoveLine[index].productName.toString() ??
                                    'Хоосон',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.start,
                              )),
                        ),
                        Expanded(
                          child: Container(
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide()),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                searchMoveLine[index]
                                        .productUomQty
                                        .toString() ??
                                    'Хоосон',
                                style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.end,
                              )),
                        ),
                        (searchMoveLine[index].checkQty ==
                                searchMoveLine[index].productUomQty)
                            ? Expanded(
                                child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Text(
                                      searchMoveLine[index]
                                              .checkQty
                                              .toString() ??
                                          'Хоосон',
                                      style: const TextStyle(
                                          color: Colors.green,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.end,
                                    )),
                              )
                            : (searchMoveLine[index].checkQty <=
                                    searchMoveLine[index].productUomQty)
                                ? Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          searchMoveLine[index]
                                                  .checkQty
                                                  .toString() ??
                                              'Хоосон',
                                          style: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.end,
                                        )),
                                  )
                                : Expanded(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Text(
                                          searchMoveLine[index]
                                                  .checkQty
                                                  .toString() ??
                                              'Хоосон',
                                          style: const TextStyle(
                                              color: Colors.red,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.end,
                                        )),
                                  ),
                      ],
                    ),
                  ],
                ),
              );
            }),
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

//db deer update hiihed eniig ashgilj bgaa
  Future updateNote() async {
    final StockLocationDetailArg stockpickingArg =
        ModalRoute.of(context).settings.arguments;

    await DBProvider.db.updateStockPicking(StockPickingEntity(
        id: stockpickingArg.result.first.id,
        name: stockpickingArg.result.first.name,
        partnerId: stockpickingArg.result.first.partnerId,
        pickingTypeId: stockpickingArg.result.first.pickingTypeId,
        locationId: stockpickingArg.result.first.locationId,
        origin: stockpickingArg.result.first.origin,
        scheduledDate: stockpickingArg.result.first.scheduledDate,
        state: stockpickingArg.result.first.state,
        isChecked: stateUtgaAvn));
    print('state utga irn$stateUtgaAvn');
  }

// checked utga irvel ustgah hergtei eniig ashgilj db gees ustgj bga
  Future deleteNote() async {
    final StockLocationDetailArg stockpickingArg =
        ModalRoute.of(context).settings.arguments;

    await DBProvider.db.deliteStockPicking(StockPickingEntity(
        id: stockpickingArg.result.first.id,
        name: stockpickingArg.result.first.name,
        partnerId: stockpickingArg.result.first.partnerId,
        pickingTypeId: stockpickingArg.result.first.pickingTypeId,
        locationId: stockpickingArg.result.first.locationId,
        origin: stockpickingArg.result.first.origin,
        scheduledDate: stockpickingArg.result.first.scheduledDate,
        state: stockpickingArg.result.first.state,
        isChecked: stateUtgaAvn));
    print('state utga irn$stateUtgaAvn');
  }
}
