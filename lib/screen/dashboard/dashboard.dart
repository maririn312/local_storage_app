// ignore_for_file: avoid_print, empty_catches, use_build_context_synchronously, depend_on_referenced_packages

import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/screen/dashboard/tabs/category_tab.dart';
import 'package:abico_warehouse/screen/dashboard/tabs/settings_tab.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import '../../language.dart';
import '../../models/screen args/barcode_args.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _DashboardScreenState();
  }
}

enum _MenuType { home, barCode, settings }

List<Widget> _navPages = [];

class _DashboardScreenState extends State<DashboardScreen>
    with TickerProviderStateMixin {
  final Image _homeActive = Image.asset(
    'assets/images/icons/home_active.webp',
    color: const Color(0xff6669f1),
    width: 30,
  );
  final Image _homeInactive = Image.asset(
    'assets/images/icons/home_active.webp',
    color: Colors.black,
    width: 30,
  );
  final Image _barcodeActive = Image.asset(
    'assets/images/icons/scan.webp',
    color: const Color(0xff6669f1),
    width: 30,
  );
  final Image _barcodeInactive = Image.asset(
    'assets/images/icons/scan.webp',
    color: Colors.black,
    width: 30,
  );
  final Image _settingsActive = Image.asset(
    'assets/images/icons/menu.webp',
    color: const Color(0xff6669f1),
    width: 30,
  );
  final Image _settingsInactive = Image.asset(
    'assets/images/icons/menu.webp',
    color: Colors.black,
    width: 30,
  );

  TabController _tabController;

  _MenuType _activeMenu = _MenuType.home;

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _navPages = const [
      CategoryTab(),
      SettingsTab(),
    ];
  }

  Future scanBarcode() async {
    try {
      _scan();
    } on PlatformException {}
  }

  Future<void> _scan() async {
    String barcodeScanRes;

    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancel', true, ScanMode.BARCODE);
      print('barcode data  : $barcodeScanRes');

      if (barcodeScanRes == '-1') {
      } else {
        Navigator.pushNamed(context, AppTypes.SCREEN_BAR_DETAIL,
            arguments: BarcodeArgs(barcodeScanRes));
      }

      print(barcodeScanRes);
    } on PlatformException catch (e) {
      if (e.code == 'USER_CANCELLED') {
        // Handle barcode scanning cancelled by user
        print('Barcode scanning cancelled by user');
        // Navigate to the home screen
        Navigator.pushReplacementNamed(context, AppTypes.SCREEN_HOME);
      } else {
        // Handle other platform exceptions
        print('Failed to scan barcode: ${e.message}');
      }
    }

    if (!mounted) return;

    setState(() {});
  }

  /* ================================================================================== */
  /* ================================================================================== */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.surface,
        centerTitle: true,
        elevation: 0,
      ),
      body: Stack(
        children: [
          TabBarView(
            physics: const NeverScrollableScrollPhysics(),
            controller: _tabController,
            children: _navPages.map<Widget>((Widget page) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Container(
                    color: Theme.of(context).colorScheme.surface,
                    key: ObjectKey(page),
                    child: page),
              );
            }).toList(),
          ),
          Positioned(bottom: 0, child: _buildMenu())
        ],
      ),
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */
  Widget _buildMenu() {
    return SafeArea(
      child: Material(
          child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              width: MediaQuery.of(context).size.width,
              padding:
                  const EdgeInsets.only(left: 6, right: 6, top: 10, bottom: 20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _menuButton(_MenuType.home, onClick: () {
                    _tabController.animateTo(0);
                  }),
                  _menuButton(_MenuType.barCode, onClick: () {
                    _scan();
                  }),
                  _menuButton(_MenuType.settings, onClick: () {
                    _tabController.animateTo(1);
                  }),
                ],
              ))),
    );
  }

  /* ================================================================================== */
  /* ================================================================================== */
  Widget _menuButton(_MenuType type, {Function onClick}) {
    String text;
    Image img;

    bool isActive = type == _activeMenu;

    if (type == _MenuType.home) {
      text = Language.MENU_HOME;
      img = isActive ? _homeActive : _homeInactive;
    } else if (type == _MenuType.barCode) {
      text = Language.MENU_BARCODE;
      img = isActive ? _barcodeActive : _barcodeInactive;
    } else if (type == _MenuType.settings) {
      text = Language.MENU_SETTINGS;
      img = isActive ? _settingsActive : _settingsInactive;
    }

    return SizedBox(
      width: 62,
      child: TextButton(
          style: TextButton.styleFrom(
              padding: EdgeInsets.zero,
              splashFactory: NoSplash.splashFactory,
              elevation: 0),
          onPressed: () {
            if (_activeMenu != type) {
              setState(() {
                _activeMenu = type;
              });
              onClick.call();
            }
          },
          child: Column(
            children: [
              SizedBox(
                width: 30,
                height: 30,
                child: Center(
                  child: img,
                ),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 10,
                ),
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }
}
