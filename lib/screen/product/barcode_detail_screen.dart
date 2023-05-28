// ignore_for_file: use_key_in_widget_constructors, unused_local_variable, unused_import, deprecated_member_use, equal_keys_in_map, avoid_print, missing_return

import 'dart:convert';

import 'package:abico_warehouse/app_types.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abico_warehouse/componenets/tenger_notif_tile.dart';
import 'package:abico_warehouse/data/db_provider.dart';
import 'package:abico_warehouse/language.dart';
import 'package:abico_warehouse/models/entity/stock_entity/product_entity/stock_product_register_entity.dart';
import 'package:abico_warehouse/models/screen%20args/barcode_args.dart';

class BarcodeDetailScreen extends StatefulWidget {
  final dynamic data;
  const BarcodeDetailScreen({Key key, this.data}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BarcodeDetailScreenState();
  }
}

class _BarcodeDetailScreenState extends State<BarcodeDetailScreen> {
  final controller = TextEditingController();

  List<StockProductRegisterEntity> nameData = [];

  List<String> nameList = [];

  String name;

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void initState() {
    getProductRegister();
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {});
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void dispose() {
    super.dispose();
  }

//db gees baraanii medeelel tatj bga hesg
  getProductRegister() async {
    List<StockProductRegisterEntity> productRegister =
        await DBProvider.db.getProductRegister();
    setState(() {
      nameData.addAll(productRegister);
    });
  }

//relation hiisen talbar duudj bga hesg
  Future<String> getMeasureName(int id) async {
    final DBProvider _databaseService = DBProvider();
    final measureName = await _databaseService.measureName(id);
    return measureName.name;
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      resizeToAvoidBottomInset: true,
      appBar: _buildAppBar(),
      body: _buildListBoxGroup(),
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */
  Widget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      foregroundColor: Colors.black,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pushNamed(context, AppTypes.SCREEN_HOME);
        },
      ),
      elevation: 0,
      centerTitle: false,
    );
  }

//baraanii medeelel haruulj bga function buh l zuiliig end bichsen gsn ug ui taldaa
  Widget _buildListBoxGroup() {
    final BarcodeArgs barCodeArg = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    for (int i = 0; i < nameData.length; i++) {
      if (nameData[i].barcode == barCodeArg.data) {
        return ListView.builder(
            itemCount: nameData.length,
            itemBuilder: (_, index) {
              var result = nameData[index];
              if (result.barcode == barCodeArg.data) {
                return TengerNotifTile(
                  title: Container(
                    decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Color.fromARGB(206, 48, 39, 185),
                            Color.fromARGB(228, 190, 34, 144),
                          ],
                        ),
                        borderRadius: BorderRadius.circular(10)),
                    // padding: const EdgeInsets.fromLTRB(40, 10, 0, 10),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 20),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Container(
                        //   margin: const EdgeInsets.symmetric(horizontal: 80),
                        //   height: 120,
                        //   width: 220,
                        //   decoration: const BoxDecoration(color: Colors.grey),
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 220,
                              width: 220,
                              decoration: result.image128 == null
                                  ? null
                                  : BoxDecoration(
                                      color:
                                          const Color.fromARGB(227, 6, 32, 179),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: MemoryImage(
                                              base64Decode(result.image128))),
                                      borderRadius: BorderRadius.circular(50)),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                        _buildRowText(
                            _buildLeftTextStyle(Language.LABEL_DETAIL_NAME),
                            _buildRightTextStyle(result.name == null
                                ? 'Хоосон'
                                : result.name.toString())),
                        _buildRowText(
                            _buildLeftTextStyle(Language.LABEL_BARCODE_CODE),
                            _buildRightTextStyle(result.barcode == null
                                ? 'Хоосон'
                                : result.barcode.toString())),

                        _buildRowText(
                            _buildLeftTextStyle(
                                Language.LABEL_DETAIL_PRODUCT_CODE),
                            _buildRightTextStyle(result.defaultCode == null
                                ? 'Хоосон'
                                : result.defaultCode.toString())),
                        _buildRowText(
                            _buildLeftTextStyle(
                                Language.LABEL_DETAIL_PRODUCT_PRICE),
                            _buildRightTextStyle(result.listPrice == null
                                ? 'Хоосон'
                                : result.listPrice.toString())),
                        _buildRowText(
                            _buildLeftTextStyle(
                                Language.LABEL_DETIAL_PRODUCT_TYPE),
                            _buildRightTextStyle(result.type == null
                                ? 'Хоосон'
                                : result.type.toString())),
                        _buildRowText(
                            _buildLeftTextStyle(
                                Language.LABEL_DETAIL_PRODUCT_WEIGHT),
                            _buildRightTextStyle(result.weight == null
                                ? 'Хоосон'
                                : result.weight.toString())),
                        _buildRowText(
                            _buildLeftTextStyle(
                                Language.LABEL_DETIAL_PRODUCT_VOLUME),
                            _buildRightTextStyle(result.volume == null
                                ? 'Хоосон'
                                : result.volume.toString())),
                        _buildRowText(
                            _buildLeftTextStyle(
                                Language.LABEL_DETAIL_PRODUCT_UOMID),
                            _buildRightRelacion(getMeasureName(result.uomId))
                            // _buildRightTextStyle(result.uomId == null
                            // ? 'Хоосон байна'
                            // : result.uomId.toString())
                            ),
                        _buildRowText(
                            _buildLeftTextStyle(
                                Language.LABEL_DETAIL_PRODUCT_COMPANY),
                            _buildRightTextStyle(result.companyId == null
                                ? 'Хоосон'
                                : result.companyId.toString())),
                      ],
                    ),
                  ),
                );
              }
              return Row();
            });
      } else {
        (const Text('Бараа байхгүй байна'));
      }
    }
  }

  //1row dotor 2utga avn ene 2n ehlel bolon togsgol deer bairlana
  Widget _buildRowText(Widget text, Widget data) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [Expanded(child: text), Expanded(child: data)],
      ),
    );
  }

//text duudaj bga function containeriin hoino
  Widget _buildRightTextStyle(String text) {
    return Text(
      text ?? 'Хоосон',
      style: const TextStyle(color: Colors.white, fontSize: 15),
      textAlign: TextAlign.end,
    );
  }

//ehlehed bh textiig oruulj baiga dunction
  Widget _buildLeftTextStyle(String text) {
    return Text('$text:' ?? 'Хоосон',
        style: const TextStyle(color: Colors.white, fontSize: 15),
        textAlign: TextAlign.start);
  }

//id irj bga talbariin zov utgiig oruulj bga function suulees n bichegdene
  Widget _buildRightRelacion(Future test) {
    return FutureBuilder<String>(
      future: test,
      builder: (context, name) {
        return Text(name.data ?? 'Хоосон',
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.end);
      },
    );
  }
}
