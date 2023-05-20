// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, unused_import, unused_element, avoid_unnecessary_containers, sized_box_for_whitespace, missing_return, avoid_print, curly_braces_in_flow_control_structures, depend_on_referenced_packages

import 'package:abico_warehouse/components/alert_dialog/stock_inventroy_barcode_dialog.dart';
import 'package:abico_warehouse/components/alert_dialog/stock_inventroy_barcode_multiply_dialog.dart';
import 'package:abico_warehouse/components/tenger_error.dart';
import 'package:abico_warehouse/components/tenger_loading_indicator.dart';
import 'package:abico_warehouse/components/tenger_notif_tile.dart';
import 'package:abico_warehouse/data/blocs/inventory/stock_inventory_line_bloc.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/inventory/stock_inventory_line_response_dto.dart';
import 'package:abico_warehouse/models/entity/stock_entity/inventory/stock_inventory_line_entity.dart';
import 'package:abico_warehouse/models/screen%20args/stock_inventory_detail_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StockInventoryDetailScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StockInventoryDetailScreenState();
  }
}

class _StockInventoryDetailScreenState
    extends State<StockInventoryDetailScreen> {
  final TextEditingController _nameController = TextEditingController();
  List<StockInventoryLineEntity> inventoryLineData = [];
  List<StockInventoryLineEntity> inventoryLine = [];
  final StockInventoryLineListBloc _inventoryLineListBloc =
      StockInventoryLineListBloc();
  static List<StockInventoryLineResult> inventoryBlocDto = [];
  List<StockInventoryLineResult> searchInventory = inventoryBlocDto;
  List<StockInventoryLineResult> testsearch = [];

  // String value;
  String query = '';
  Map<int, String> someMap = {};
  bool isLoading = false;

  final myController = TextEditingController();

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      _buildLineCardList();
    });
    // _buildLineCardList();
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void dispose() {
    _nameController?.dispose();

    super.dispose();
  }

  Future<String> getCompanyName(int id) async {
    final DBProvider databaseService = DBProvider();
    final comapny = await databaseService.companyName(id);
    return comapny.name;
  }

  Future<String> getMeasureName(int id) async {
    final DBProvider databaseService = DBProvider();
    final measure = await databaseService.measureName(id);
    return measure.name;
  }

  Future<String> getProductName(int id) async {
    final DBProvider databaseService = DBProvider();
    final measure = await databaseService.productName(id);
    return measure.name;
  }

  Future<String> getProductBarcode(int id) async {
    final DBProvider databaseService = DBProvider();
    final measure = await databaseService.productName(id);
    return measure.barcode;
  }

  Future<String> getStockLoaction(int id) async {
    final DBProvider databaseService = DBProvider();
    final measure = await databaseService.stockLoacationName(id);
    return measure.completeName;
  }

  getUpdate(int id) async {
    await DBProvider.db.updateInventoryLine(StockInventoryLineEntity());
  }

  void updateList(String value) {
    print('end ymr utg ireed bn $searchInventory');
    print(inventoryBlocDto);
    searchInventory = List.from(inventoryBlocDto);
    setState(() {
      searchInventory = inventoryBlocDto
          .where((element) =>
              element.productName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  Widget build(BuildContext context) {
    // if (searchInventory == null) {
    //   setState(() {
    //     searchInventory;
    //   });
    // } else {
    //   setState(() {
    //     searchInventory = List.from(inventoryBlocDto);
    //   });
    // }
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: _buildAppBar(),
        body: Column(children: [
          _buildCardBox(),
          _buildButton(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
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
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(
                  width: 10,
                ),
                _buildResult("Бараа:"),
                _buildText('Гарт байгаа:'),
                _buildTextToolson('Тоолсон:')
              ],
            ),
          ),
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
          _buildLineCardList()
        ]),
      ),
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */
  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      elevation: 0,
      centerTitle: false,
    );
  }

  Widget _buildCardBox() {
    final StockInventoryDetailArg stockInventoryArg =
        ModalRoute.of(context).settings.arguments;
    _inventoryLineListBloc
        .add(StockInventoryLine(ip: stockInventoryArg.result.id.toString()));

    return Expanded(
      child: TengerNotifTile(
        title: Container(
          decoration: BoxDecoration(
              color: const Color.fromRGBO(104, 26, 81, 0.9),
              borderRadius: BorderRadius.circular(10)),
          // padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(children: [
                    _buildRowColumn(Language.LABEL_Census_Name,
                        _buildText2(stockInventoryArg.result.name)),
                    _buildRowColumn(
                        Language.LABEL_Financial_Date,
                        _buildText2(
                            stockInventoryArg.result.accountingDate != 'null'
                                ? stockInventoryArg.result.accountingDate
                                    .substring(0, 10)
                                : 'Хоосон')),
                    _buildRowColumn(
                      Language.LABEL_Claim_Company,
                      FutureBuilder<String>(
                        future:
                            getCompanyName(stockInventoryArg.result.companyId),
                        builder: (context, partnerName) {
                          return _buildText2('${partnerName.data},' ?? 'null');
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          Language.LABEL_Locations,
                          style: TextStyle(fontSize: 14, color: Colors.white),
                          textAlign: TextAlign.start,
                        ),
                        for (int zaa = 0;
                            zaa < stockInventoryArg.result.locationIds.length;
                            zaa++)
                          FutureBuilder<String>(
                            future: getStockLoaction(
                                stockInventoryArg.result.locationIds[zaa]),
                            builder: (context, partnerName) {
                              return _buildText2(
                                  '${partnerName.data},' ?? 'null');
                            },
                          ),
                      ],
                    ),
                  ]),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  // padding: const EdgeInsetsDirectional.only(start: 10),
                  decoration: BoxDecoration(
                      color: (stockInventoryArg.result.state == 'draft')
                          ? Colors.grey
                          : (stockInventoryArg.result.state) == 'confirm'
                              ? Colors.blue
                              : (stockInventoryArg.result.state) == 'done'
                                  ? Colors.green
                                  : Colors.red,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10))),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            Language.LABEL_Sale_Order_State,
                            style: TextStyle(color: Colors.white),
                          ),
                          Text(
                            stockInventoryArg.result.state == 'draft'
                                ? 'Ноорог'
                                : stockInventoryArg.result.state == 'confirm'
                                    ? 'Явагдаж буй'
                                    : stockInventoryArg.result.state == 'done'
                                        ? 'Батлагдсан'
                                        : 'Цуцлагдсан',
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // ),
        // ),
      ),
    );
  }

  Widget _buildCreateButton() {
    double size = 163;
    double circlesize = 20;
    final StockInventoryDetailArg stockInventoryArg =
        ModalRoute.of(context).settings.arguments;
    return TengerNotifTile(
      title: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${Language.LABEL_Census_Date}: ${stockInventoryArg.result.accountingDate}',
              style: const TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineCardList() {
    double height = MediaQuery.of(context).size.height - 380; //* 0.79;
    final StockInventoryDetailArg stockInventoryArg =
        ModalRoute.of(context).settings.arguments;

    return SizedBox(
        height: height,
        child: BlocBuilder(
            bloc: _inventoryLineListBloc,
            builder: (_, state) {
              if (state is StockInventoryLineLoading) {
                return // const Text('loading ');
                    const Center(
                        child: SizedBox(
                            height: 70,
                            width: 70,
                            child: TengerLoadingIndicator()));
              } else if (state is StockInventoryLineError) {
                return Center(
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    child: TengerError(
                      error: state.error,
                    ),
                  ),
                );
              } else if (state is StockInventoryLineLoaded) {
                if (inventoryBlocDto.isEmpty) {
                  for (int s = 0;
                      s < state.resultStockInventoryLine.length;
                      s++) {
                    // setState(() {
                    inventoryBlocDto.add(state.resultStockInventoryLine[s]);
                    // searchInventory = inventoryBlocDto;
                    someMap[state.resultStockInventoryLine[s].id] =
                        state.resultStockInventoryLine[s].barcode;
                    // });
                  }
                } else {
                  inventoryBlocDto.clear();
                  // searchInventory.clear();
                  for (int s = 0;
                      s < state.resultStockInventoryLine.length;
                      s++) {
                    inventoryBlocDto.add(state.resultStockInventoryLine[s]);
                    // searchInventory = inventoryBlocDto;
                    someMap[state.resultStockInventoryLine[s].id] =
                        state.resultStockInventoryLine[s].barcode;
                  }
                }
                print(
                    '/////////////////////////////////////////////////////////////////');
                print('searchInventory length ${searchInventory.length}');
                print('inventoryBlocDto length ${inventoryBlocDto.length}');
                print(
                    'state.resultStockInventoryLine length ${state.resultStockInventoryLine.length}');
                // ignore: unnecessary_cast
                testsearch.addAll(state.resultStockInventoryLine
                    as Iterable<StockInventoryLineResult>);
                return ListView.builder(
                    itemCount: searchInventory.length,
                    itemBuilder: (_, index) {
                      return Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          decoration: const BoxDecoration(
                            border: Border(top: BorderSide()),
                          ),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    // Text(searchInventory.first.productName),
                                    Expanded(
                                      child: Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            searchInventory[index]
                                                    .productName ??
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
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: Text(
                                            searchInventory[index]
                                                    .theoreticalQty
                                                    .toString() ??
                                                'Хоосон',
                                            style: const TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                            textAlign: TextAlign.end,
                                          )),
                                    ),
                                    // _buildText(
                                    //     inventoryLine[index].theoreticalQty.toString() ??
                                    //         'null'),
                                    (searchInventory[index].productQty ==
                                            searchInventory[index]
                                                .theoreticalQty)
                                        ? Expanded(
                                            child: Container(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),
                                                child: Text(
                                                  inventoryBlocDto[index]
                                                          .productQty
                                                          .toString() ??
                                                      'Хоосон',
                                                  style: const TextStyle(
                                                      color: Colors.green,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.end,
                                                )),
                                          )
                                        : (searchInventory[index].productQty >
                                                searchInventory[index]
                                                    .theoreticalQty)
                                            ? Expanded(
                                                child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Text(
                                                      searchInventory[index]
                                                              .productQty
                                                              .toString() ??
                                                          'Хоосон',
                                                      style: const TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign: TextAlign.end,
                                                    )),
                                              )
                                            : Expanded(
                                                child: Container(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Text(
                                                      searchInventory[index]
                                                              .productQty
                                                              .toString() ??
                                                          'Хоосон',
                                                      style: const TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 14,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign: TextAlign.end,
                                                    )),
                                              )
                                  ],
                                ),
                              ]));
                    });
              }
            }));
  }

  Widget _buildLeftTextStyle(String text) {
    return Text(text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
        textAlign: TextAlign.start);
  }

//id irj bga talbariin zov utgiig duudaj bga function text n suulees ehlene
  Widget _buildLeftRelacion(Future test) {
    return FutureBuilder<String>(
      future: test,
      builder: (context, name) {
        return Text(name.data ?? 'Хоосон',
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.end);
      },
    );
  }

  Widget _buildRowColumn(
    String defaulUtga,
    Widget dynamicUtag,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text(
            defaulUtga,
            style: const TextStyle(fontSize: 14, color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
        dynamicUtag
      ],
    );
  }

  Widget _buildButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              print('end map irnee $someMap');
              _scan();
            },
            child: const Text(
              'Тоо ширхэг',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              print('end map irnee $someMap');
              _scanPlus();
            },
            child: const Text(
              'Хайрцаг',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _scan() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      // for (var v in someMap.values) {}
      someMap.forEach((i, value) async {
        if (barcodeScanRes == value) {
          for (int z = 0; z < inventoryBlocDto.length; z++) {
            if (inventoryBlocDto[z].id == i) {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return StockInventoryBarCodeDialog(
                        note: inventoryBlocDto[z]);
                  });
            }

            // refreshForm();
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

  Future<void> _scanPlus() async {
    String barcodeScanRes;
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      // for (var v in someMap.values) {}
      someMap.forEach((i, value) async {
        if (barcodeScanRes == value) {
          for (int z = 0; z < inventoryBlocDto.length; z++) {
            if (inventoryBlocDto[z].id == i) {
              await showDialog(
                  context: context,
                  builder: (context) {
                    return StockInventoryBarCodeMultiplyDialog(
                        note: inventoryBlocDto[z]);
                  });
            }

            // refreshForm();
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

  Future<void> _showAttendDialog() async {
    final StockInventoryDetailArg stockInventoryArg =
        ModalRoute.of(context).settings.arguments;
  }

  Widget _buildText(String text) {
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

  Widget _buildText2(String text) {
    return Expanded(
      child: Container(
          // padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
        text ?? 'Хоосон',
        style: const TextStyle(color: Colors.white, fontSize: 14),
        textAlign: TextAlign.end,
      )),
    );
  }

  Widget _buildTextToolson(String text) {
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

  Widget _buildResult(String text) {
    return Expanded(
      child: Text(
        text ?? 'Хоосон',
        style: const TextStyle(
            color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
        textAlign: TextAlign.start,
      ),
    );
  }
}
