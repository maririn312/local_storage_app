// ignore_for_file: avoid_print

import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/components/search_widget.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_picking_entity.dart';
import 'package:flutter/material.dart';

import '../../models/screen args/stock_picking_args.dart';

class StockPickingScreen extends StatefulWidget {
  const StockPickingScreen({Key key}) : super(key: key);

  @override
  State<StockPickingScreen> createState() => StockPickingScreenState();
}

class StockPickingScreenState extends State<StockPickingScreen> {
  final controller = TextEditingController();
  List<StockPickingEntity> stockPickingData = [];
  List<StockPickingEntity> testEntity = [];

  // final StockPickingListBloc _stockPickingBloc = StockPickingListBloc();
  bool isLoading = false;
  bool value = false;
  String query = '';

  @override
  void initState() {
    // refreshNotes();
    changeData();
    getStockPicking();

    // getStockPicking();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

//herggu yum bh shig bno
  void changeData() {
    value = true;
    setState(() {
      value = true;
    });
  }

//ene uul n db deer bga zuiliig omnh screen deer refresh hiihd ashgildag ghde ashiglaagu bj magdgu bn sain medehgu bno
  Future refreshForm() async {
    setState(() => isLoading = true);

    stockPickingData = await DBProvider.db.getStockPicking();

    if (testEntity.isEmpty) {
      for (int i = 0; i < stockPickingData.length; i++) {
        setState(() {
          testEntity.add(stockPickingData[i]);
        });
      }
    } else {
      testEntity.clear();
      for (int i = 0; i < stockPickingData.length; i++) {
        setState(() {
          testEntity.add(stockPickingData[i]);
        });
      }
    }
    setState(() => isLoading = false);
  }
  // Future refreshNotes() async {
  //   setState(() => isLoading = true);

  //   stockPickingData = await DBProvider.db.getStockPicking();

  //   setState(() => isLoading = false);
  // }
//relation hiij bga function uudl bnda
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

//db geed ogogdol tataj bgan
  getStockPicking() async {
    List<StockPickingEntity> stockPicking =
        await DBProvider.db.getStockPicking();
    setState(() {
      stockPickingData.addAll(stockPicking);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromARGB(0, 255, 255, 255),
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.black),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              _buildSearch(),
              _buildListBoxGroup(),
            ],
          ),
        ));
  }

//screeniig deerees n 10px avj bga function
  Widget _buildListBoxGroup() {
    double height = MediaQuery.of(context).size.height - 160;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: height,
      child: _buildScreen(),
    );
  }

//db gees search hiij bga function
  void searchData(String query) async {
    List<StockPickingEntity> testEntity = await DBProvider.db.getStockPicking();
    print('stock entity $testEntity');

    if (query == null || query.isEmpty) {
      setState(() {
        this.query = query;
        stockPickingData = testEntity;
      });
      return;
    }

    final data = testEntity.where((datas) {
      if (datas.origin == null) {
        return false;
      }
      final titleLower = datas.origin.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      stockPickingData = data;
    });
  }

  // void searchData(String query) async {
  //   List<StockPickingEntity> testEntity = await DBProvider.db.getStockPicking();
  //   print('stock entity ${testEntity}');
  //   final data = testEntity.where((datas) {
  //     final titleLower = datas.origin.toLowerCase() ?? "";
  //     final searchLower = query.toLowerCase();

  //     return titleLower.contains(searchLower);
  //   }).toList();

  //   setState(() {
  //     this.query = query;
  //     stockPickingData = data;
  //   });
  // }

//search hiij bga zuiliig iim widgeteer haruulj bga belen widget
  Widget _buildSearch() => SearchWidget(
        text: query,
        hintText: Language.LABEL_SEARCH,
        onChanged: searchData,
      );

//ui screen zurj haruulj bga hesg
  Widget _buildScreen() {
    if (testEntity.isEmpty) {
      testEntity.addAll(stockPickingData);
    } else {
      testEntity.clear();
      testEntity.addAll(stockPickingData);
    }
    return ListView.builder(
        itemCount: testEntity.length,
        itemBuilder: (_, index) {
          return GestureDetector(
            onTap: () async {
              await Navigator.pushNamed(
                  context, AppTypes.SCREEN_STOCK_PICKING_LINE,
                  arguments: StockLocationDetailArg(testEntity[index]));
              refreshForm();
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  padding: const EdgeInsets.only(top: 10),
                  // padding: const EdgeInsets.symmetric(vertical: 10),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildRow(_buildText('Хүргэлтийн нэр'),
                          _buildResult(testEntity[index].name)),
                      _buildRow(
                        _buildText('Хүргэлтийн хаяг'),
                        FutureBuilder<String>(
                          future: getPartnerName(testEntity[index].partnerId),
                          builder: (context, partnerName) {
                            return _buildResult(partnerName.data);
                          },
                        ),
                      ),
                      _buildRow(
                        _buildText('Агуулахын баримтын төрөл'),
                        FutureBuilder<String>(
                          future: getPickingTypeName(
                              testEntity[index].pickingTypeId),
                          builder: (context, partnerName) {
                            return _buildResult(partnerName.data);
                          },
                        ),
                      ),
                      _buildRow(
                        _buildText('Эх байрлал'),
                        FutureBuilder<String>(
                          future: getLocationName(testEntity[index].locationId),
                          builder: (context, locationName) {
                            return _buildResult(locationName.data);
                          },
                        ),
                      ),
                      _buildRow(
                          _buildText('Товлосон огноо'),
                          _buildResult(testEntity[index]
                              .scheduledDate
                              .toString()
                              .substring(0, 10))),
                      _buildRow(_buildText('Эх баримт'),
                          _buildResult(testEntity[index].origin)),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color:
                                (testEntity[index].isChecked == 'not_checked')
                                    ? Colors.grey
                                    : (testEntity[index].isChecked) ==
                                            'half_checked'
                                        ? Colors.blue
                                        : (testEntity[index].state) == 'done'
                                            ? Colors.green
                                            : Colors.green,
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
                                  testEntity[index].isChecked == 'not_checked'
                                      ? 'Шалгаагүй'
                                      : testEntity[index].isChecked ==
                                              'half_checked'
                                          ? 'Хагас шалгасан'
                                          : testEntity[index].state == 'done'
                                              ? 'Батлагдсан'
                                              : 'Бүрэн шалгасан',
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
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          );
        });
  }

//row dotr 2utg avh function
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

//deer bga functiond ehnii utg bolj ordg function
  Widget _buildText(String text) {
    return Expanded(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            text ?? 'Хоосон',
            style: const TextStyle(
                color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),
            textAlign: TextAlign.start,
          )),
    );
  }

//deer bga functiond suuliin utg bolj ordg function
  Widget _buildResult(String text) {
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
}
