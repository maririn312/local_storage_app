// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, unused_import, avoid_print, unused_element, unnecessary_this, depend_on_referenced_packages, use_build_context_synchronously

import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/components/search_widget.dart';
import 'package:abico_warehouse/data/blocs/inventory/stock_inventory_bloc.dart';
import 'package:abico_warehouse/data/blocs/inventory/stock_inventory_line_bloc.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/entity/company_entity/company_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/inventory/stock_inventory_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_location_entity.dart';
import 'package:abico_warehouse/models/screen%20args/stock_inventory_detail_args.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class StockInventoryScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _StockInventoryScreenState();
  }
}

class _StockInventoryScreenState extends State<StockInventoryScreen> {
  List<StockInventoryEntity> inventoryData = [];
  List<CompanyEntity> companyData = [];
  List<StockLocationEntity> locationData = [];
  final StockInventoryListBloc _inventoryListBloc = StockInventoryListBloc();
  final StockInventoryLineListBloc _inventoryLineListBloc =
      StockInventoryLineListBloc();
  bool isLoading = false;

  String query = '';

  /* ================================================================================== */
  /* ================================================================================== */
  //end barg db deerees ogogdol tatah uyd ashgilj bgoo
  @override
  void initState() {
    getInventory();
    getCompany();
    refreshNotes();
    getLocation();
    super.initState();
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void dispose() {
    super.dispose();
  }

//db deerees ene ogogdluudiig tatah uyd ashgilnoo
  getInventory() async {
    List<StockInventoryEntity> inventory = await DBProvider.db.getInventory();
    setState(() {
      inventoryData.addAll(inventory);
    });
  }

  getCompany() async {
    List<CompanyEntity> company = await DBProvider.db.getCompany();
    setState(() {
      companyData.addAll(company);
    });
  }

  getLocation() async {
    List<StockLocationEntity> location = await DBProvider.db.getStockLocation();
    setState(() {
      locationData.addAll(location);
    });
  }

//db gees ner duudj bga function
  Future<String> getStockLoaction(int id) async {
    final DBProvider databaseService = DBProvider();
    final measure = await databaseService.stockLoacationName(id);
    return measure.completeName;
  }

  Future<String> getCompanyName(int id) async {
    final DBProvider databaseService = DBProvider();
    final breed = await databaseService.companyName(id);
    return breed.name;
  }

  downloadInventory() async {
    _inventoryListBloc.add(StockInventory(ip: '49.0.129.29'));
  }

  downloadInventoryLine() async {
    _inventoryLineListBloc.add(StockInventoryLine(ip: "ip"));
  }

//
  Future refreshNotes() async {
    setState(() => isLoading = true);

    inventoryData = await DBProvider.db.getInventory();
    final StockInventoryDetailArg stockInventoryArg =
        ModalRoute.of(context).settings.arguments;

    // if (inventoryLine.isEmpty) {
    //   for (int i = 0; i < inventoryLineData.length; i++) {
    //     if (stockInventoryArg.result.id == inventoryLineData[i].inventoryId) {
    //       setState(() {
    //         inventoryLine.add(inventoryLineData[i]);
    //       });
    //     }
    //   }
    // } else {
    //   inventoryLine.clear();
    //   for (int i = 0; i < inventoryLineData.length; i++) {
    //     if (stockInventoryArg.result.id == inventoryLineData[i].inventoryId) {
    //       setState(() {
    //         inventoryLine.add(inventoryLineData[i]);
    //       });
    //     }
    //   }
    // }
    setState(() => isLoading = false);
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: _buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [_buildSearch(), _buildListBoxGroup()],
          ),
        ));
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
      title: SizedBox(
        height: 41,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            // ElevatedButton(
            //     onPressed: () {
            //       downloadInventory();
            //       downloadInventoryLine();

            //       setState(() {
            //         refreshNotes();
            //       });
            //     },
            //     child: const Text('Татах'))
          ],
        ),
      ),
    );
    // ElevatedButton(
    //     onPressed: () {
    //       downloadInventory();
    //     },
    //     child: const Text('Татах'))
  }

//db ashgilj search hiij bga function
  void searchData(String query) async {
    List<StockInventoryEntity> saleOrder = await DBProvider.db.getInventory();
    final data = saleOrder.where((datas) {
      final titleLower = datas.name.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      this.inventoryData = data;
    });
  }

//belen search widget ashgilj bgan onpress deer n deer bichsen function duudaj bn
  Widget _buildSearch() => SearchWidget(
        text: query,
        hintText: Language.LABEL_SEARCH,
        onChanged: searchData,
      );

  /* ================================================================================== */
  /* ================================================================================== */
//deerees n hesg zai avaad zurg bga function
  Widget _buildListBoxGroup() {
    double height = MediaQuery.of(context).size.height - 160;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: height,
      child: _buildScreen(),
    );
  }

//form haruulj bga function end db gees duudj bga
  Widget _buildScreen() {
    return ListView.builder(
      itemCount: inventoryData.length,
      itemBuilder: (_, index) {
        for (int i = 0; i < inventoryData.length; i++) {}
        if (inventoryData[index].locationIds.length > 1) {}
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, AppTypes.SCREEN_INVENTORY_DETAIL,
                arguments: StockInventoryDetailArg(inventoryData[index]));
          },
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                // padding: const EdgeInsets.symmetric(horizontal: ),
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
                  children: [
                    _buildRowColumn(
                      Language.LABEL_Census_Code,
                      _buildText(inventoryData[index].name),
                    ),
                    _buildRowColumn(
                        Language.LABEL_Financial_Date,
                        _buildText(inventoryData[index].accountingDate != 'null'
                            ? inventoryData[index]
                                .accountingDate
                                .substring(0, 10)
                            : 'Хоосон')),
                    _buildRowColumn(
                      Language.LABEL_Claim_Company,
                      FutureBuilder<String>(
                        future: getCompanyName(inventoryData[index].companyId),
                        builder: (context, partnerName) {
                          return _buildText('${partnerName.data},' ?? 'null');
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: const Text(
                            Language.LABEL_Locations,
                            style: TextStyle(fontSize: 14, color: Colors.white),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        for (int zaa = 0;
                            zaa < inventoryData[index].locationIds.length;
                            zaa++)
                          FutureBuilder<String>(
                            future: getStockLoaction(
                                inventoryData[index].locationIds[zaa]),
                            builder: (context, partnerName) {
                              return _buildText(
                                  '${partnerName.data},' ?? 'null');
                            },
                          ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: (inventoryData[index].state == 'draft')
                              ? Colors.grey
                              : (inventoryData[index].state) == 'confirm'
                                  ? Colors.blue
                                  : (inventoryData[index].state) == 'done'
                                      ? Colors.green
                                      : Colors.red,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10))),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                inventoryData[index].state == 'draft'
                                    ? 'Ноорог'
                                    : inventoryData[index].state == 'confirm'
                                        ? 'Явагдаж буй'
                                        : inventoryData[index].state == 'done'
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
            ],
          ),
        );
      },
    );
  }

//defualt text bolon ard n ymr neg widget duudhad ashgilj bga function jishee n ehnii text ner bhd ard n dyncmic bvl eniig ashgilj bga
  Widget _buildRowColumn(
    String defaulUtga,
    Widget dynamicUtag,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
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

//text avnoo delgetsnii hoinoos style iig shuud ogson bga
  Widget _buildText(String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(text ?? "Хоосон",
            style: const TextStyle(
              color: Colors.white,
              fontSize: 14,
            ),
            textAlign: TextAlign.end),
      ),
    );
  }
}
