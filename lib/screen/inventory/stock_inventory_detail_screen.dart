// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, unused_import, unused_element, avoid_unnecessary_containers, sized_box_for_whitespace, missing_return, avoid_print, curly_braces_in_flow_control_structures, unrelated_type_equality_checks

import 'package:abico_warehouse/models/entity/auth_entity/user_detail_entity.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/inventory/stock_inventory_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:abico_warehouse/models/dto/inventory/stock_inventory_line_response_dto.dart';
import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/componenets/alert_dialog/stock_inventroy_barcode_dialog.dart';
import 'package:abico_warehouse/componenets/alert_dialog/stock_inventroy_barcode_multiply_dialog.dart';
import 'package:abico_warehouse/componenets/search_widget.dart';
import 'package:abico_warehouse/componenets/tenger_error.dart';
import 'package:abico_warehouse/componenets/tenger_loading_indicator.dart';
import 'package:abico_warehouse/componenets/tenger_notif_tile.dart';
import 'package:abico_warehouse/componenets/tenger_outline_button.dart';
import 'package:abico_warehouse/data/blocs/inventory/stock_inventory_bloc.dart';
import 'package:abico_warehouse/data/blocs/inventory/stock_inventory_line_bloc.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/entity/stock_entity/inventory/stock_inventory_line_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/product_entity/stock_product_register_entity.dart';
import 'package:abico_warehouse/models/screen%20args/stock_inventory_detail_args.dart';
import 'package:abico_warehouse/models/screen%20args/stock_inventory_line_args.dart';
import 'package:abico_warehouse/models/screen%20args/stock_picking_detail_args.dart';

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
  List<StockInventoryLineResult> line = [];

  // String value;
  String ip;
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
    final company = await DBProvider().companyName(id);
    return company.name;
  }

  Future<String> getMeasureName(int id) async {
    final measure = await DBProvider().measureName(id);
    return measure.name;
  }

  Future<String> getProductName(int id) async {
    final product = await DBProvider().productName(id);
    return product.name;
  }

  Future<String> getProductBarcode(int id) async {
    final product = await DBProvider().productName(id);
    return product.barcode;
  }

  Future<String> getStockLocation(int id) async {
    final stockLocation = await DBProvider().stockLoacationName(id);
    return stockLocation.completeName;
  }

  Future<void> getUserEntity() async {
    UserDetailEntity userDetailEntity = await DBProvider.db.getUserDetail();
    setState(() {
      ip = userDetailEntity.ip.toString();
    });
  }

  Future<void> getUpdate(int id) async {
    await DBProvider.db.updateInventoryLine(StockInventoryLineEntity());
  }

  void updateList(String value) {
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
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        resizeToAvoidBottomInset: true,
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
    final companyNameFuture =
        getCompanyName(stockInventoryArg.result.companyId);
    final stockLocationFutures = stockInventoryArg.result.locationIds
        .map((id) => getStockLocation(id))
        .toList();

    _inventoryLineListBloc
        .add(StockInventoryLine(ip: stockInventoryArg.result.id.toString()));

    return Expanded(
      child: TengerNotifTile(
        title: Container(
          decoration: BoxDecoration(
            color: const Color.fromRGBO(104, 26, 81, 0.9),
            borderRadius: BorderRadius.circular(10),
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      _buildRowColumn(
                        Language.LABEL_Census_Name,
                        _buildText2(stockInventoryArg.result.name),
                      ),
                      _buildRowColumn(
                        Language.LABEL_Financial_Date,
                        _buildText2(
                          stockInventoryArg.result.accountingDate != 'null'
                              ? stockInventoryArg.result.accountingDate
                                  .substring(0, 10)
                              : 'Хоосон',
                        ),
                      ),
                      _buildRowColumn(
                        Language.LABEL_Claim_Company,
                        FutureBuilder<String>(
                          future: companyNameFuture,
                          builder: (context, snapshot) {
                            return _buildText2('${snapshot.data},' ?? 'null');
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
                          for (final stockLocationFuture
                              in stockLocationFutures)
                            FutureBuilder<String>(
                              future: stockLocationFuture,
                              builder: (context, snapshot) {
                                return _buildText2(
                                    '${snapshot.data},' ?? 'null');
                              },
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: (stockInventoryArg.result.state == 'draft')
                        ? Colors.grey
                        : (stockInventoryArg.result.state == 'confirm')
                            ? Colors.blue
                            : (stockInventoryArg.result.state == 'done')
                                ? Colors.green
                                : Colors.red,
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    ),
                  ),
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
            return Center(
              child: SizedBox(
                height: 70,
                width: 70,
                child: TengerLoadingIndicator(),
              ),
            );
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
            inventoryBlocDto.clear();
            someMap.clear();
            inventoryBlocDto.addAll(state.resultStockInventoryLine);
            for (var item in state.resultStockInventoryLine) {
              someMap[item.id] = item.barcode;
            }
            print(
                'inventory line id bn uu    ${state.resultStockInventoryLine.first.id}');
            print(
                '/////////////////////////////////////////////////////////////////');
            print('searchInventory length ${searchInventory.length}');
            print('inventoryBlocDto length ${inventoryBlocDto.length}');
            print(
                'state.resultStockInventoryLine length ${state.resultStockInventoryLine.length}');
            testsearch.addAll(state.resultStockInventoryLine);

            // Filter the stock inventory lines based on the condition
// Filter the stock inventory lines based on the condition
            List<StockInventoryLine> filteredLines = state
                .resultStockInventoryLine
                .where(
                    (line) => line.inventoryId == stockInventoryArg.result.id)
                .map((result) => StockInventoryLine(
                      ip: ip, // Replace `ip` with the actual property name from your database
                      inventory_id: stockInventoryArg.result.id.toString(),
                    ))
                .toList();

            return ListView.builder(
              itemCount: filteredLines.length,
              itemBuilder: (_, index) {
                StockInventoryLine line = filteredLines[index];

                return Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
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
                          Expanded(
                            child: Container(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                state.resultStockInventoryLine[index]
                                        .productName ??
                                    'Хоосон',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              decoration: const BoxDecoration(
                                border: Border(right: BorderSide()),
                              ),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                state.resultStockInventoryLine[index]
                                        .theoreticalQty
                                        .toString() ??
                                    'Хоосон',
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.end,
                              ),
                            ),
                          ),
                          if (state
                                  .resultStockInventoryLine[index].productQty ==
                              state.resultStockInventoryLine[index]
                                  .theoreticalQty)
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  state.resultStockInventoryLine[index]
                                          .productQty
                                          .toString() ??
                                      'Хоосон',
                                  style: const TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            )
                          else if (state
                                  .resultStockInventoryLine[index].productQty >
                              state.resultStockInventoryLine[index]
                                  .theoreticalQty)
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  state.resultStockInventoryLine[index]
                                          .productQty
                                          .toString() ??
                                      'Хоосон',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            )
                          else
                            Expanded(
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  state.resultStockInventoryLine[index]
                                          .productQty
                                          .toString() ??
                                      'Хоосон',
                                  style: const TextStyle(
                                    color: Colors.blue,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  textAlign: TextAlign.end,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
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
    try {
      final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );

      final matchingInventory = inventoryBlocDto.firstWhere(
        (note) => note.barcode == barcodeScanRes,
        orElse: () => null,
      );

      if (matchingInventory != null) {
        showDialog(
          context: context,
          builder: (context) {
            return StockInventoryBarCodeDialog(note: matchingInventory);
          },
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Бараа олдсоггүй',
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } on PlatformException {
      Fluttertoast.showToast(
        msg: 'Failed to get platform version.',
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _scanPlus() async {
    try {
      final barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
        '#ff6666',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );

      final matchingInventory = inventoryBlocDto.firstWhere(
        (note) => note.barcode == barcodeScanRes,
        orElse: () => null,
      );

      if (matchingInventory != null) {
        showDialog(
          context: context,
          builder: (context) {
            return StockInventoryBarCodeMultiplyDialog(
              note: matchingInventory,
            );
          },
        );
      } else {
        Fluttertoast.showToast(
          msg: 'Бараа олдсоггүй',
          backgroundColor: Colors.red,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
        );
      }
    } on PlatformException {
      Fluttertoast.showToast(
        msg: 'Failed to get platform version.',
        backgroundColor: Colors.red,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }

    if (!mounted) return;

    setState(() {});
  }

  Future<void> _showAttendDialog() async {
    final stockInventoryArg =
        ModalRoute.of(context).settings.arguments as StockInventoryDetailArg;
  }

  Widget _buildText(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          text ?? 'Хоосон',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.end,
        ),
      ),
    );
  }

  Widget _buildText2(String text) {
    return Expanded(
      child: Text(
        text ?? 'Хоосон',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
        ),
        textAlign: TextAlign.end,
      ),
    );
  }

  Widget _buildTextToolson(String text) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          text ?? 'Хоосон',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.end,
        ),
      ),
    );
  }

  Widget _buildResult(String text) {
    return Expanded(
      child: Text(
        text ?? 'Хоосон',
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}
