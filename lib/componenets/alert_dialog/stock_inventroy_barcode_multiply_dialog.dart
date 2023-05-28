// ignore_for_file: unused_field, unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:local_storage_app/data/blocs/post/stock_inventory_line_history_post_bloc.dart';
import 'package:local_storage_app/data/blocs/put/stock_inventory_line_put_bloc.dart';
import 'package:local_storage_app/data/db_provider.dart';
import 'package:local_storage_app/models/dto/inventory/stock_inventory_line_response_dto.dart';

class StockInventoryBarCodeMultiplyDialog extends StatefulWidget {
  final StockInventoryLineResult note;

  const StockInventoryBarCodeMultiplyDialog({
    Key key,
    this.note,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _StockInventoryBarCodeMultiplyDialogState();
  }
}

class _StockInventoryBarCodeMultiplyDialogState
    extends State<StockInventoryBarCodeMultiplyDialog> {
  _StockInventoryBarCodeMultiplyDialogState();
  final controller = TextEditingController(text: '0');
  final StockInventoryLinePutListBloc _stockMovePutBloc =
      StockInventoryLinePutListBloc();
  final StockInventoryLineHistoryPostListBloc _historyPostListBloc =
      StockInventoryLineHistoryPostListBloc();

  int number;
  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void initState() {
    // number = widget.note?.theoreticalQty ;
    super.initState();
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void dispose() {
    super.dispose();
  }

  Future<String> getProductName(int id) async {
    final DBProvider _databaseService = DBProvider();
    final product = await _databaseService.productName(id);
    return product.name;
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    int b = widget.note.packQty.toInt();

    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0))),
          content: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Бараа: ${widget.note.productName}' ?? 'Хоосон'),
                const SizedBox(
                  height: 10,
                ),
                Text('Гарт байгаа: ${widget.note.theoreticalQty}'),
                Text('Тоолсон тоо: ${widget.note.productQty}'),
                // Text(widget.note.pickingId.toString()),
                const SizedBox(
                  height: 10,
                ),
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
                        textAlign: TextAlign.start,
                        // initialValue: widget.note.productQty.toString(),
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
                    )
                  ],
                )
              ],
            ),
          ),
          actions: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildButton(),
              ],
            )
          ],
        ));
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        onPressed: () {
          int packQty = widget.note.packQty.toInt();
          int productQty = widget.note.productQty.toInt();
          int a = int.parse(controller.text);
          int too = productQty + (a * packQty);
          int tse = a * packQty;

          if (0 < a) {
            _stockMovePutBloc.add(
              StockInventoryLinePut(
                ip: '49.0.129.18:9393',
                id: widget.note.id.toString(),
                time: too.toString(),
              ),
            );
            _historyPostListBloc.add(StockInventoryLineHistoryPost(
                ip: widget.note.id.toString(), id: 's', time: tse.toString()));
            setState(() {});
            Navigator.pop(context);
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
        }, //addOrUpdateNote,
        child: const Text('Нэмэх'),
      ),
    );
  }

  void addOrUpdateNote() async {
    int productQty = widget.note.productQty.toInt();

    int a = int.parse(controller.text);
    int b = widget.note.packQty.toInt();
    final isUpdating = widget.note != null;
    // if (widget.note.theoreticalQty >= widget.note.productQty + a) {
    int too = productQty + b * a;
    if (0 < a) {
      if (isUpdating) {
        _stockMovePutBloc.add(
          StockInventoryLinePut(
            ip: '49.0.129.18:9393',
            id: widget.note.id.toString(),
            time: too.toString(),
          ),
        ); // await updateNote();
      } else {}

      setState(() {});
      Navigator.pop(context);
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
    // } else {
    //   ScaffoldMessenger.of(context)
    //     ..removeCurrentSnackBar()
    //     ..showSnackBar(const SnackBar(
    //         content: Text(
    //       'Бэлдсэн тоо нь Бэлдэх тооноос их байж болохгүй',
    //       textAlign: TextAlign.center,
    //     )));
    // }
  }

  // Future updateNote() async {
  //   double a = double.parse(controller.text);
  //   await DBProvider.db.updateInventoryLine(StockInventoryLineEntity(
  //     id: widget.note.id,
  //     inventoryId: widget.note.inventoryId,
  //     productId: widget.note.productId,
  //     inventoryDate: widget.note.inventoryDate.toString(),
  //     theoreticalQty: widget.note.theoreticalQty,
  //     productQty: a + widget.note.productQty,
  //     differenceQty: widget.note.differenceQty,
  //     productUomId: widget.note.productUomId,
  //     companyId: widget.note.companyId,
  //     // isSendData: widget.note.isSendData,
  //     locationId: widget.note.locationId,
  //     barcode: widget.note.barcode,
  //   ));
  // }
}
