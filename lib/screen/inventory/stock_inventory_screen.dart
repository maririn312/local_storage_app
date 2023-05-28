import 'package:flutter/material.dart';

import '../../app_types.dart';
import '../../componenets/search_widget.dart';
import '../../data/db_provider.dart';
import '../../language.dart';
import '../../models/entity/company_entity/company_entity.dart';
import '../../models/entity/stock_entity/inventory/stock_inventory_entity.dart';
import '../../models/entity/stock_entity/stock_location_entity.dart';
import '../../models/screen args/stock_inventory_detail_args.dart';

class StockInventoryScreen extends StatefulWidget {
  const StockInventoryScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StockInventoryScreenState();
  }
}

class _StockInventoryScreenState extends State<StockInventoryScreen> {
  List<StockInventoryEntity> inventoryData = [];
  List<CompanyEntity> companyData = [];
  List<StockLocationEntity> locationData = [];
  bool isLoading = false;
  String query = '';

  @override
  void initState() {
    super.initState();
    getInventory();
    getCompany();
    getLocation();
  }

  Future<void> getInventory() async {
    final List<StockInventoryEntity> inventory =
        await DBProvider.db.getInventory();
    setState(() {
      inventoryData.addAll(inventory);
    });
  }

  Future<void> getCompany() async {
    final List<CompanyEntity> company = await DBProvider.db.getCompany();
    setState(() {
      companyData.addAll(company);
    });
  }

  Future<void> getLocation() async {
    final List<StockLocationEntity> location =
        await DBProvider.db.getStockLocation();
    setState(() {
      locationData.addAll(location);
    });
  }

  Future<String> getStockLocation(int id) async {
    final DBProvider _databaseService = DBProvider();
    final measure = await _databaseService.stockLoacationName(id);
    return measure.completeName;
  }

  Future<String> getCompanyName(int id) async {
    final DBProvider _databaseService = DBProvider();
    final breed = await _databaseService.companyName(id);
    return breed.name;
  }

  Future<void> refreshNotes() async {
    setState(() => isLoading = true);
    inventoryData = await DBProvider.db.getInventory();
    setState(() => isLoading = false);
  }

  void searchData(String query) async {
    final List<StockInventoryEntity> saleOrder =
        await DBProvider.db.getInventory();
    final data = saleOrder.where((datas) {
      final titleLower = datas.name.toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      inventoryData = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
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
      title: SizedBox(
        height: 41,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
    return ListView.builder(
      itemCount: inventoryData.length,
      itemBuilder: (_, index) {
        final stockInventory = inventoryData[index];
        return GestureDetector(
          onTap: () {
            Navigator.pushNamed(
              context,
              AppTypes.SCREEN_INVENTORY_DETAIL,
              arguments: StockInventoryDetailArg(stockInventory),
            );
          },
          child: Column(
            children: [
              const SizedBox(height: 10),
              Container(
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
                child: Column(
                  children: [
                    _buildRowColumn(
                      Language.LABEL_Census_Code,
                      _buildText(stockInventory.name),
                    ),
                    _buildRowColumn(
                      Language.LABEL_Financial_Date,
                      _buildText(stockInventory.accountingDate != 'null'
                          ? stockInventory.accountingDate.substring(0, 10)
                          : 'Хоосон'),
                    ),
                    _buildRowColumn(
                      Language.LABEL_Claim_Company,
                      FutureBuilder<String>(
                        future: getCompanyName(stockInventory.companyId),
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
                        for (final locationId in stockInventory.locationIds)
                          FutureBuilder<String>(
                            future: getStockLocation(locationId),
                            builder: (context, partnerName) {
                              return _buildText(
                                  '${partnerName.data},' ?? 'null');
                            },
                          ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: stockInventory.state == 'draft'
                            ? Colors.grey
                            : stockInventory.state == 'confirm'
                                ? Colors.blue
                                : stockInventory.state == 'done'
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
                            children: [
                              const SizedBox(width: 10),
                              Text(
                                stockInventory.state == 'draft'
                                    ? 'Ноорог'
                                    : stockInventory.state == 'confirm'
                                        ? 'Явагдаж буй'
                                        : stockInventory.state == 'done'
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

  Widget _buildRowColumn(String defaultText, Widget dynamicWidget) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            defaultText,
            style: const TextStyle(fontSize: 14, color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
        dynamicWidget,
      ],
    );
  }

  Widget _buildText(String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          text ?? "Хоосон",
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          textAlign: TextAlign.end,
        ),
      ),
    );
  }
}
