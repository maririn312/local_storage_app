import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:local_storage_app/data/blocs/post/stock_inventory_line_history_post_bloc.dart';
import 'package:local_storage_app/data/blocs/put/stock_inventory_line_put_bloc.dart';
import 'package:local_storage_app/models/dto/inventory/stock_inventory_line_response_dto.dart';

class StockInventoryBarCodeDialog extends StatefulWidget {
  final StockInventoryLineResult note;
  final dynamic data;

  const StockInventoryBarCodeDialog({Key key, this.note, this.data})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _StockInventoryBarCodeDialogState();
}

class _StockInventoryBarCodeDialogState
    extends State<StockInventoryBarCodeDialog> {
  final TextEditingController controller = TextEditingController(text: '0');
  final StockInventoryLinePutListBloc _stockMovePutBloc =
      StockInventoryLinePutListBloc();
  final StockInventoryLineHistoryPostListBloc _historyPostListBloc =
      StockInventoryLineHistoryPostListBloc();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.0)),
        ),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Бараа: ${widget.note.productName}' ?? 'Хоосон'),
              const SizedBox(height: 10),
              Text('Гарт байгаа: ${widget.note.theoreticalQty}'),
              Text('Тоолсон тоо: ${widget.note.productQty}'),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Тоолсон тоо:'),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
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
              buildButtonHasah(),
              buildButton(),
            ],
          )
        ],
      ),
    );
  }

  Widget buildButtonHasah() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        onPressed: () => handleButtonHasah(),
        child: const Text('Хасах'),
      ),
    );
  }

  void handleButtonHasah() async {
    final int productQty = widget.note.productQty.toInt();
    final int a = int.tryParse(controller.text) ?? 0;
    final int too = productQty - a;
    if (0 < a) {
      _stockMovePutBloc.add(
        StockInventoryLinePut(
          ip: '49.0.129.18:9393',
          id: widget.note.id.toString(),
          time: too.toString(),
        ),
      );
      _historyPostListBloc.add(
        StockInventoryLineHistoryPost(
          ip: widget.note.id.toString(),
          id: 's',
          time: '-$a',
        ),
      );
      setState(() {});
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Амжилттай',
        gravity: ToastGravity.CENTER,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Хасах тоо оруулах боломжгүй',
        gravity: ToastGravity.CENTER,
      );
    }
  }

  Widget buildButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: ElevatedButton(
        onPressed: () => handleButtonNemeh(),
        child: const Text('Нэмэх'),
      ),
    );
  }

  void handleButtonNemeh() async {
    final int productQty = widget.note.productQty.toInt();
    final int a = int.tryParse(controller.text) ?? 0;
    final int too = productQty + a;
    if (0 < a) {
      _stockMovePutBloc.add(
        StockInventoryLinePut(
          ip: '49.0.129.18:9393',
          id: widget.note.id.toString(),
          time: too.toString(),
        ),
      );
      _historyPostListBloc.add(
        StockInventoryLineHistoryPost(
          ip: widget.note.id.toString(),
          id: 's',
          time: a.toString(),
        ),
      );
      setState(() {});
      Navigator.pop(context);
      Fluttertoast.showToast(
        msg: 'Амжилттай',
        gravity: ToastGravity.CENTER,
      );
    } else {
      Fluttertoast.showToast(
        msg: 'Хасах тоо оруулах боломжгүй',
        gravity: ToastGravity.CENTER,
      );
    }
  }
}
