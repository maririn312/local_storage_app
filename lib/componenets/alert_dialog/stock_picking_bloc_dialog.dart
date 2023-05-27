// ignore_for_file: unused_field, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/componenets/tenger_error.dart';
import 'package:abico_warehouse/componenets/tenger_loading_indicator.dart';
import 'package:abico_warehouse/data/blocs/put/stock_move_put_bloc.dart';
import 'package:abico_warehouse/data/blocs/put/stock_picking_is_checked_put_bloc.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_move_entity.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_picking_entity.dart';

class StockPickingBlocDialog extends StatefulWidget {
  final StockPickingEntity note;

  const StockPickingBlocDialog({
    Key key,
    this.note,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StockPickingBlocDialogState();
  }
}

class _StockPickingBlocDialogState extends State<StockPickingBlocDialog> {
  _StockPickingBlocDialogState();
  final controller = TextEditingController(text: "0");
  final StockMovePutListBloc _stockMovePutBloc = StockMovePutListBloc();
  List<StockMoveLineEntity> stockMoveLineData = [];
  final StockPickingIsActivePutListBloc _stockPickingPutBloc =
      StockPickingIsActivePutListBloc();
  String stateUtgaAvn;

  bool ihbaival = false;

  double number;
  @override
  void initState() {
    getStockPicking();
    // number = widget.note?.diffQty ?? 0;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  getStockPicking() async {
    List<StockMoveLineEntity> stockMoveLine =
        await DBProvider.db.getStockMoveLine();
    setState(() {
      stockMoveLineData.addAll(stockMoveLine);
    });
  }

  Future<String> getProductName(int id) async {
    final DBProvider _databaseService = DBProvider();
    final product = await _databaseService.productName(id);
    return product.name;
  }

  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        title: BlocBuilder(
          bloc: _stockPickingPutBloc,
          // ignore: missing_return
          builder: (_, state) {
            if (state is StockPickingIsActivePutLoading) {
              return Center(
                  child: SizedBox(
                      height: 70, width: 70, child: TengerLoadingIndicator()));
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
            onPressed: () async {
              print('end state utg irnee $stateUtgaAvn');
              // final StockLocationDetailArg stockpickingArg =
              //     ModalRoute.of(context).settings.arguments;
              print(widget.note.name);

              Navigator.of(context).pop();
              // Navigator.pop(context, 'OK');
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
