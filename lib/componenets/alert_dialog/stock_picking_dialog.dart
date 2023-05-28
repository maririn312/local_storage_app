// ignore_for_file: unused_field, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:abico_warehouse/data/blocs/put/stock_move_put_bloc.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/models/entity/stock_entity/stock_picking_entity/stock_move_entity.dart';

class StockPickingDialog extends StatefulWidget {
  final StockMoveLineEntity note;
  final dynamic data;

  const StockPickingDialog({Key key, this.note, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StockPickingDialogState();
  }
}

class _StockPickingDialogState extends State<StockPickingDialog> {
  _StockPickingDialogState();
  final controller = TextEditingController(text: "0");
  final StockMovePutListBloc _stockMovePutBloc = StockMovePutListBloc();
  List<StockMoveLineEntity> stockMoveLineData = [];

  bool ihbaival = false;

  double number;
  @override
  void initState() {
    getStockPicking();
    number = widget.note?.diffQty ?? 0;
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
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Бараа ${widget.note.productName}'),
                const SizedBox(
                  height: 10,
                ),
                Text('Бэлдэх тоо ${widget.note.productUomQty}'),
                Text('Бэлдсэн тоо ${widget.note.checkQty}'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text('Тоолсон тоо:'),
                    const SizedBox(
                      width: 10,
                    ),
                    Expanded(
                      child: TextFormField(
                        scrollPadding:
                            const EdgeInsets.symmetric(horizontal: 50),
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                              color: Colors.blue,
                              width: 2.0,
                            ),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                        controller: controller,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Үгүй')),
                    buildButton()
                  ],
                ),
              ],
            ),
          ),
        ));
  }

  Widget buildButton() {
    return ElevatedButton(
      onPressed: addOrUpdateNote,
      child: const Text('Тийм'),
    );
  }

  void addOrUpdateNote() async {
    int checkQty = widget.note.checkQty.toInt();
    int a = int.parse(controller.text);

    final isUpdating = widget.note != null;
    if (widget.note.productUomQty >= widget.note.checkQty + a) {
      int too = checkQty + a;
      if (0 < a) {
        if (isUpdating) {
          await updateNote();
        } else {}
        _stockMovePutBloc.add(
          StockMovePut(
            ip: '49.0.129.18:9393',
            id: widget.note.id.toString(),
            time: too.toString(),
          ),
        );

        Navigator.of(context).pop();
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
            'Хасах тоо оруулах боломжгүй',
            textAlign: TextAlign.center,
          )));
      }
    } else {
      setState(() {
        ihbaival == true;
      });
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(const SnackBar(
            content: Text(
          'Бэлдсэн тоо нь Бэлдэх тооноос их байж болохгүй',
          textAlign: TextAlign.center,
        )));
    }
  }

  Future updateNote() async {
    double a = double.parse(controller.text);
    await DBProvider.db.updateStockMoveLine(StockMoveLineEntity(
      id: widget.note.id,
      productId: widget.note.productId,
      descriptionPicking: widget.note.descriptionPicking,
      dateExpected: widget.note.dateExpected,
      quantityDone: widget.note.quantityDone,
      productUom: widget.note.productUom,
      productUomQty: widget.note.productUomQty,
      pickingId: widget.note.pickingId,
      checkQty: widget.note.checkQty + a,
      diffQty: widget.note.diffQty,
      barcode: widget.note.barcode,
      productName: widget.note.productName,
    ));
  }
}
