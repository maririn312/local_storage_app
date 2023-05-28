// ignore_for_file: prefer_if_null_operators, use_key_in_widget_constructors, avoid_print, unused_field, unused_import, non_constant_identifier_names, unused_element, duplicate_ignore, unused_local_variable

import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/componenets/tenger_error.dart';
import 'package:abico_warehouse/componenets/tenger_loading_indicator.dart';
import 'package:abico_warehouse/data/blocs/category/category_bloc.dart';
import 'package:abico_warehouse/data/blocs/company/res_company_bloc.dart';
import 'package:abico_warehouse/data/blocs/hr/hr_bloc.dart';
import 'package:abico_warehouse/data/blocs/inventory/stock_inventory_bloc.dart';
import 'package:abico_warehouse/data/blocs/inventory/stock_inventory_line_bloc.dart';
import 'package:abico_warehouse/data/blocs/partner/partner_bloc.dart';
import 'package:abico_warehouse/data/blocs/partner/res_user_bloc.dart';
import 'package:abico_warehouse/data/blocs/product/stock_measure_bloc.dart';
import 'package:abico_warehouse/data/blocs/product/stock_product_register_bloc.dart';
import 'package:abico_warehouse/data/blocs/stock_picking/stock_location_bloc.dart';
import 'package:abico_warehouse/data/blocs/stock_picking/stock_move_bloc.dart';
import 'package:abico_warehouse/data/blocs/stock_picking/stock_picking_bloc.dart';
import 'package:abico_warehouse/data/blocs/stock_picking/stock_picking_line_bloc.dart';
import 'package:abico_warehouse/data/blocs/stock_picking/stock_picking_type_bloc.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/entity/auth_entity/user_entity.dart';
import 'package:abico_warehouse/models/screen%20args/auth_args.dart';
import 'package:abico_warehouse/screen/login/login_screen.dart';

class SettingsTab extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SettingsTabState();
  }
}

class _SettingsTabState extends State<SettingsTab> {
  final CategoryBloc _categoryBloc = CategoryBloc();

  final StockPickingListBloc _stockPickingBloc = StockPickingListBloc();
  final StockPickingLineListBloc _stockPickingLineBloc =
      StockPickingLineListBloc();
  final StockMoveLineListBloc _stockMoveLineBloc = StockMoveLineListBloc();
  final HrListBloc _hrListBloc = HrListBloc();
  final StockPickingTypeListBloc _stockPickingTypeBloc =
      StockPickingTypeListBloc();
  final PartnerBloc _partnerBloc = PartnerBloc();
  final StockLocationBloc _stockLocationBloc = StockLocationBloc();
  final StockProductRegisterListBloc _productRegisterListBloc =
      StockProductRegisterListBloc();
  final StockMeasureBloc _stockMeasureBloc = StockMeasureBloc();
  final ResUserBloc _resUserBloc = ResUserBloc();
  final StockInventoryListBloc _inventoryListBloc = StockInventoryListBloc();
  final StockInventoryLineListBloc _inventoryLineListBloc =
      StockInventoryLineListBloc();
  final ResCompanyListBloc _resCompanyListBloc = ResCompanyListBloc();
  String ip;
  String _sessionId;
  int _patentId;
  String _displayData;
  bool _image;
  UserEntity UserData;

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  // ignore: must_call_super
  void initState() {
    _getHr();
    getUser();
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void dispose() {
    // _categoryBloc?.close();
    super.dispose();
  }

  Future<void> _getHr() async {
    UserEntity user = await DBProvider.db.getUser();
    setState(() {
      _hrListBloc.add(Hr(
        uid: user.uid.toString(),
      ));
    });
  }

  Future<void> getUser() async {
    UserEntity user = await DBProvider.db.getUser();
    setState(() {
      UserData = user;
    });
  }

  Future<String> getCompanyName(int id) async {
    final DBProvider _databaseService = DBProvider();
    final company = await _databaseService.companyName(id);
    return company.name;
  }

  Future<void> downloadData(List<Function()> functions) async {
    for (final function in functions) {
      await function();
    }

    Fluttertoast.showToast(
      msg: 'Өгөгдөл татаж байна',
      backgroundColor: Theme.of(context).primaryColor,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
    );
  }

  Future<void> downloadAllData() async {
    await downloadData([
      downloadStockPicking,
      downloadStockPickingLine,
      downloadStockMoveingLine,
      downloadStockPickingType,
      downloadpartner,
      downloadStockLocation,
      downloadProduct,
      downloadMeasure,
      downloadUser,
      downloadInventory,
      downloadResCompany,
      downloadInventoryLine,
    ]);
  }

  Future<void> downloadWarehouseData() async {
    await downloadData([
      downloadStockPicking,
      downloadStockPickingLine,
      downloadStockMoveingLine,
      downloadStockPickingType,
    ]);
  }

  Future<void> downloadCountingData() async {
    await downloadData([
      downloadInventory,
      downloadResCompany,
      downloadInventoryLine,
    ]);
  }

  Future<void> downloadStockPicking() async {
    _stockPickingBloc.add(StockPicking(ip: ip));
  }

  Future<void> downloadStockPickingLine() async {
    _stockPickingLineBloc.add(StockPickingLine(ip: ip));
  }

  Future<void> downloadStockMoveingLine() async {
    _stockMoveLineBloc.add(StockMoveLine(ip: ip));
  }

  Future<void> downloadStockPickingType() async {
    _stockPickingTypeBloc.add(StockPickingType(ip: ip));
  }

  Future<void> downloadpartner() async {
    _partnerBloc.add(PartnerList(ip: ip));
  }

  Future<void> downloadStockLocation() async {
    _stockLocationBloc.add(StockLocation(ip: ip));
  }

  Future<void> downloadProduct() async {
    _productRegisterListBloc.add(StockProductRegister(ip: ip));
  }

  Future<void> downloadMeasure() async {
    _stockMeasureBloc.add(StockMeasure(ip: ip));
  }

  Future<void> downloadUser() async {
    _resUserBloc.add(ResUserList(ip: ip));
  }

  Future<void> downloadInventory() async {
    _inventoryListBloc.add(StockInventory());
  }

  Future<void> downloadInventoryLine() async {
    _inventoryLineListBloc.add(StockInventoryLine(ip: ip));
  }

  Future<void> downloadResCompany() async {
    _resCompanyListBloc.add(ResCompany(ip: ip));
  }

  /* ================================================================================== */
  /* ================================================================================== */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BlocBuilder(
              bloc: _hrListBloc,
              builder: (_, state) {
                if (state is HrLoading) {
                  return Center(
                      child: SizedBox(
                          height: 70,
                          width: 70,
                          child: TengerLoadingIndicator()));
                } else if (state is HrError) {
                  return Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: TengerError(
                        error: state.error,
                      ),
                    ),
                  );
                } else if (state is HrLoaded) {
                  return Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            width: 15,
                          ),
                          Container(
                            height: 100,
                            width: 100,
                            decoration: state.resultHr.first.image1920 == null
                                ? null
                                : BoxDecoration(
                                    color:
                                        const Color.fromRGBO(104, 26, 81, 0.9),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: MemoryImage(base64Decode(
                                            state.resultHr.first.image1920))),
                                    borderRadius: BorderRadius.circular(50)),
                          ),
                          const SizedBox(
                            width: 30,
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  state.resultHr.first.name ?? 'null',
                                  style: const TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  state.resultHr.first.jobTitle ?? 'null',
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                          margin: const EdgeInsets.symmetric(horizontal: 16),
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          decoration: BoxDecoration(
                              color: Colors.blue.shade200,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              _buildContainer(
                                Icons.add_home_work,
                                const Text(
                                  'Компани',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                _buildLeftRelacion(getCompanyName(
                                    state.resultHr.first.companyId ?? 'null')),
                              ),
                              _buildContainer(
                                Icons.phone,
                                const Text(
                                  'Утас',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  state.resultHr.first.mobilePhone ?? 'null',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              _buildContainer(
                                Icons.mail,
                                const Text(
                                  'Э-майл',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  state.resultHr.first.workEmail ?? 'null',
                                  style: const TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                              _buildContainer(
                                  Icons.home,
                                  const Text(
                                    'Ажлын Байршил',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    state.resultHr.first.workLocation ?? 'null',
                                    style: const TextStyle(
                                      fontSize: 16,
                                    ),
                                  )),
                            ],
                          )),
                      const SizedBox(
                        height: 20,
                      )
                    ],
                  );
                }
                return const Text(
                  ' Language.LABEL_NAME_NOT_FOUND',
                  textAlign: TextAlign.center,
                );
              },
            ),
            _buildAccountSettings(),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Theme.of(context).colorScheme.surface,
        child: SizedBox(
          height: 156,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [
                                Color.fromARGB(228, 4, 38, 150),
                                Color.fromARGB(206, 9, 104, 160),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(10)),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                          ),
                          child: const Text(Language.LABEL_OUT),
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              CupertinoPageRoute(
                                builder: (context) => const LoginScreen(),
                              ),
                              (_) => false,
                            );
                            // Navigator.pushNamed(context, AppTypes.SCREEN_LOGIN);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */

  Widget _buildAccountSettings() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          color: Theme.of(context).colorScheme.surface,
          border: Border.all(color: const Color(0xffefeff4), width: 1)),
      // margin: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          //_eleveted(),
          _buildButton()
        ],
      ),
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */

  Widget _buildButton() {
    final buttonConfigs = [
      {
        'label': 'Өгөгдөл татах',
        'onPressed': () async {
          downloadAllData();
        },
      },
      {
        'label': 'Агуулах',
        'onPressed': () {
          downloadWarehouseData();
        },
      },
      {
        'label': 'Тооллого',
        'onPressed': () {
          downloadCountingData();
        },
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: buttonConfigs.map((config) {
        return _buildButtonContainer(
          label: config['label'],
          onPressed: config['onPressed'],
        );
      }).toList(),
    );
  }

  Widget _buildButtonContainer(
      {@required String label, @required VoidCallback onPressed}) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Color.fromARGB(228, 4, 38, 150),
            Color.fromARGB(206, 9, 104, 160),
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _elevated() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                Color.fromARGB(228, 4, 38, 150),
                Color.fromARGB(206, 9, 104, 160),
              ],
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Өгөгдөл татах'),
            onPressed: () async {
              Fluttertoast.showToast(
                msg: 'Өгөгдөл татаж байна',
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
              );

              await Future.wait<void>([
                downloadStockPicking(),
                downloadStockPickingLine(),
                downloadStockMoveingLine(),
                downloadStockPickingType(),
                downloadpartner(),
                downloadStockLocation(),
                downloadProduct(),
                downloadMeasure(),
                downloadUser(),
                downloadInventory(),
                downloadResCompany(),
                downloadInventoryLine(),
              ]);
            },
          ),
        ),
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Color.fromARGB(228, 4, 38, 150),
                  Color.fromARGB(206, 9, 104, 160),
                ],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text('Агуулахын хөдөлгөөн татах'),
              onPressed: () {
                Fluttertoast.showToast(
                  msg: 'Өгөгдөл татаж байна',
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.CENTER,
                );

                Future.wait([
                  downloadStockPicking(),
                  downloadStockPickingLine(),
                  downloadStockMoveingLine(),
                  downloadStockPickingType(),
                ]);
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContainer(IconData icon, Widget defualtText, Widget state) {
    return Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 2, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          child: Icon(
            icon,
            size: 40,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [defualtText, state],
        )
      ],
    );
  }

  // ignore: unused_element
  Widget _buildLeftRelacion(Future test) {
    return FutureBuilder<String>(
      future: test,
      builder: (context, name) {
        return Text(name.data ?? 'default',
            style: const TextStyle(color: Colors.black),
            textAlign: TextAlign.start);
      },
    );
  }
}
