// ignore_for_file: unused_field, unused_local_variable, avoid_print, use_build_context_synchronously

import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/models/entity/stock_entity/inventory/stock_inventory_line_entity.dart';
import 'package:flutter/material.dart';

import '../../models/screen args/stock_inventory_line_args.dart';

class InventoryProductqtyDialog extends StatefulWidget {
  const InventoryProductqtyDialog({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _InventoryProductqtyDialogState();
  }
}

class _InventoryProductqtyDialogState extends State<InventoryProductqtyDialog> {
  _InventoryProductqtyDialogState();
  String value;
  final controller = TextEditingController(text: "0");

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void initState() {
    super.initState();
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void dispose() {
    super.dispose();
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  // ignore: missing_return
  Widget build(BuildContext context) {
    final StockInventoryLineArg stockPickingDetailArg =
        ModalRoute.of(context).settings.arguments;

    return GestureDetector(
        child: AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20.0))),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Тоолсон тоогоо оруулна уу',
              style: TextStyle(fontSize: 18),
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Тоо хэмжээ',
                fillColor: Colors.white,
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(25.0),
                  borderSide: const BorderSide(
                    color: Colors.blue,
                    width: 2.0,
                  ),
                ),
              ),
              keyboardType: TextInputType.number,
              controller: controller,
            ),
          ],
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Үгүй')),
            ElevatedButton(
                onPressed: () async {
                  double i = double.parse(controller.text);
                  await DBProvider.db
                      .updateInventoryLine(StockInventoryLineEntity(
                    id: stockPickingDetailArg.result.id,
                    theoreticalQty: stockPickingDetailArg.result.theoreticalQty,
                    productQty: i,
                    barcode: stockPickingDetailArg.result.barcode,
                  ));
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context)
                    ..removeCurrentSnackBar()
                    ..showSnackBar(const SnackBar(
                        content: Text(
                      'Амжилттай',
                      textAlign: TextAlign.center,
                    )));
                },
                child: const Text('Тийм')),
          ],
        )
      ],
    ));
  }
}
