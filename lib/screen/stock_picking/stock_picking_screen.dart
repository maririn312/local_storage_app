// // ignore_for_file: avoid_print

// ignore_for_file: depend_on_referenced_packages

import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/components/alert_dialog/stock_picking_bloc_dialog.dart';
import 'package:abico_warehouse/components/search_widget.dart';
import 'package:abico_warehouse/components/tenger_loading_indicator.dart';
import 'package:abico_warehouse/data/blocs/stock_picking/stock_location_bloc.dart';
import 'package:abico_warehouse/data/blocs/stock_picking/stock_partner_bloc.dart';
import 'package:abico_warehouse/data/blocs/stock_picking/stock_picking_bloc.dart';
import 'package:abico_warehouse/data/blocs/stock_picking/stock_picking_type_bloc.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_location_response_dto.dart';
import 'package:abico_warehouse/models/dto/stock_picking/stock_picking_dto.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_picking_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/dto/stock_picking/stock_partner_response_dto.dart';
import '../../models/dto/stock_picking/stock_picking_type_dto.dart';
import '../../models/screen args/stock_picking_args.dart';

class StockPickingScreen extends StatefulWidget {
  const StockPickingScreen({Key key}) : super(key: key);

  @override
  State<StockPickingScreen> createState() => StockPickingScreenState();
}

class StockPickingScreenState extends State<StockPickingScreen> {
  final TextEditingController controller = TextEditingController();
  StockPickingListBloc _stockPickingListBloc;
  StockLocationBloc _stockLocationBloc;
  StockPartnerBloc _stockPartnerBloc;
  StockPickingTypeListBloc _stockPickingTypeListBloc;

  List<StockPickingResult> stockResult = [];
  List<StockPickingResult> stockPickingData = [];
  List<StockLocationResult> location = [];
  List<StockPartnerResult> partner = [];
  List<StockPickingTypeResult> pickingType = [];
  String query = '';

  @override
  void initState() {
    super.initState();
    _stockPickingListBloc = StockPickingListBloc();
    _stockLocationBloc = StockLocationBloc();
    _stockPartnerBloc = StockPartnerBloc();
    _stockPickingTypeListBloc = StockPickingTypeListBloc();

    // Populate stockResult and stockPickingData with all the data initially
    getStockPicking();
    getLocation();
    getPartner();
    getPickingType();
    stockResult = []; // Initialize stockResult as an empty list
    stockPickingData = []; // Initialize stockPickingData as an empty list
  }

  @override
  void dispose() {
    _stockPickingListBloc.close();
    _stockLocationBloc.close();
    _stockPartnerBloc.close();
    _stockPickingTypeListBloc.close();
    super.dispose();
  }

  void getStockPicking() {
    _stockPickingListBloc.add(StockPicking());
  }

  void getLocation() {
    _stockLocationBloc.add(StockLocation());
  }

  void getPartner() {
    _stockPartnerBloc.add(StockPartnerList());
  }

  void getPickingType() {
    _stockPickingTypeListBloc.add(StockPickingType());
  }

  void searchData(String query) {
    if (query.isEmpty) {
      setState(() {
        this.query = query;
        stockPickingData = List.from(stockResult);
      });
      return;
    }

    final List<StockPickingResult> data = stockResult.where((datas) {
      if (datas.origin == null) {
        return false;
      }
      final titleLower = datas.origin.toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      stockPickingData = data.isNotEmpty ? data : List.from(stockResult);
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
            MultiBlocListener(
              listeners: [
                BlocListener<StockPickingListBloc, StockPickingState>(
                  bloc: _stockPickingListBloc,
                  listener: (_, state) {
                    if (state is StockPickingLoaded) {
                      setState(() {
                        stockResult.addAll(state.resultStockPicking.results);
                      });
                    }
                  },
                ),
                BlocListener<StockLocationBloc, StockLocationState>(
                  bloc: _stockLocationBloc,
                  listener: (_, state) {
                    if (state is StockLocationLoaded) {
                      setState(() {
                        location.addAll(state.stockLocationResult);
                      });
                    }
                  },
                ),
                BlocListener<StockPartnerBloc, StockPartnerState>(
                  bloc: _stockPartnerBloc,
                  listener: (_, state) {
                    if (state is StockPartnerListLoaded) {
                      setState(() {
                        partner.addAll(state.partnerResult);
                      });
                    }
                  },
                ),
                BlocListener<StockPickingTypeListBloc, StockPickingTypeState>(
                  bloc: _stockPickingTypeListBloc,
                  listener: (_, state) {
                    if (state is StockPickingTypeLoaded) {
                      setState(() {
                        pickingType.addAll(state.resultStockPickingType);
                      });
                    }
                  },
                ),
              ],
              child: Container(),
            ),
            _buildListBoxGroup(),
          ],
        ),
      ),
    );
  }

  Widget _buildListBoxGroup() {
    final height = MediaQuery.of(context).size.height - 160;
    return Container(
      margin: const EdgeInsets.only(top: 10),
      height: height,
      child: stockPickingData.isEmpty // Check if stockPickingData is empty
          ? stockResult
                  .isEmpty // Show loading indicator if stockResult is empty
              ? const SizedBox(
                  height: 25,
                  width: 30,
                  child: TengerLoadingIndicator(),
                )
              : _buildAllData() // Show all the data if stockResult is not empty
          : ListView.separated(
              itemCount: stockPickingData.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (_, index) {
                final stockPicking = stockPickingData[index];
                final matchingLocation = location.firstWhere(
                  (loc) => loc.locationId == stockPicking.locationId,
                  orElse: () => null,
                );
                final matchingPartners = partner.firstWhere(
                  (part) => part.id == stockPicking.partnerId,
                  orElse: () => null,
                );
                final matchingPickingType = pickingType.firstWhere(
                  (pick) => pick.id == stockPicking.pickingTypeId,
                  orElse: () => null,
                );

                return GestureDetector(
                  onTap: () async {
                    await Navigator.pushNamed(
                      context,
                      AppTypes.SCREEN_STOCK_PICKING_LINE,
                      arguments: StockLocationDetailArg(stockPickingData),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20),
                    padding: const EdgeInsets.only(top: 10),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildRow(
                          _buildText('Хүргэлтийн нэр'),
                          _buildResult(stockPicking.name),
                        ),
                        _buildRow(
                          _buildText('Хүргэлтийн хаяг'),
                          _buildResult(matchingPartners?.name),
                        ),
                        _buildRow(
                          _buildText('Агуулахын баримтын төрөл'),
                          _buildResult(matchingPickingType?.name),
                        ),
                        _buildRow(
                          _buildText('Эх байрлал'),
                          _buildResult(matchingLocation?.completeName),
                        ),
                        _buildRow(
                          _buildText('Товлосон огноо'),
                          _buildResult(
                            stockPicking.scheduledDate
                                .toString()
                                .substring(0, 10),
                          ),
                        ),
                        _buildRow(
                          _buildText('Эх баримт'),
                          _buildResult(stockPicking.origin),
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildAllData() {
    return ListView.separated(
      itemCount: stockResult.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (_, index) {
        final stockPicking = stockResult[index];
        final matchingLocation = location.firstWhere(
          (loc) => loc.locationId == stockPicking.locationId,
          orElse: () => null,
        );
        final matchingPartners = partner.firstWhere(
          (part) => part.id == stockPicking.partnerId,
          orElse: () => null,
        );
        final matchingPickingType = pickingType.firstWhere(
          (pick) => pick.id == stockPicking.pickingTypeId,
          orElse: () => null,
        );

        return GestureDetector(
          onTap: () async {
            await Navigator.pushNamed(
              context,
              AppTypes.SCREEN_STOCK_PICKING_LINE,
              arguments: StockLocationDetailArg(stockPickingData),
            );
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            padding: const EdgeInsets.only(top: 10),
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
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRow(
                  _buildText('Хүргэлтийн нэр'),
                  _buildResult(stockPicking.name),
                ),
                _buildRow(
                  _buildText('Хүргэлтийн хаяг'),
                  _buildResult(matchingPartners?.name),
                ),
                _buildRow(
                  _buildText('Агуулахын баримтын төрөл'),
                  _buildResult(matchingPickingType?.name),
                ),
                _buildRow(
                  _buildText('Эх байрлал'),
                  _buildResult(matchingLocation?.completeName),
                ),
                _buildRow(
                  _buildText('Товлосон огноо'),
                  _buildResult(
                    stockPicking.scheduledDate.toString().substring(0, 10),
                  ),
                ),
                _buildRow(
                  _buildText('Эх баримт'),
                  _buildResult(stockPicking.origin),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearch() => SearchWidget(
        text: query,
        hintText: Language.LABEL_SEARCH,
        onChanged: searchData,
      );

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
          text ?? 'Хоосон',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  Widget _buildResult(String text) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Text(
          text ?? '',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }
}
