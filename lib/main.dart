import 'dart:async';
import 'dart:io';

import 'package:abico_warehouse/data/hive_data/barcode_detail_screen_data.dart';
import 'package:abico_warehouse/data/hive_data/dashboard_screen_data.dart';
import 'package:abico_warehouse/data/hive_data/inventory_productqty_dialog_data.dart';
import 'package:abico_warehouse/data/hive_data/login_screen_data.dart';
import 'package:abico_warehouse/data/hive_data/product_register_detail_screen_data.dart';
import 'package:abico_warehouse/data/hive_data/stock_inventory_barcode_dialog_data.dart';
import 'package:abico_warehouse/data/hive_data/stock_inventory_detail_screen_data.dart';
import 'package:abico_warehouse/data/hive_data/stock_inventory_screen_data.dart';
import 'package:abico_warehouse/data/hive_data/stock_picking_dialog_data.dart';
import 'package:abico_warehouse/data/hive_data/stock_picking_line_screen_data.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:abico_warehouse/app_theme.dart';
import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/componenets/alert_dialog/inventory_productqty_dialog.dart';
import 'package:abico_warehouse/componenets/alert_dialog/stock_inventroy_barcode_dialog.dart';
import 'package:abico_warehouse/componenets/alert_dialog/stock_picking_dialog.dart';
import 'package:abico_warehouse/screen/dashboard/dashboard.dart';
import 'package:abico_warehouse/screen/login/login_screen.dart';
import 'package:abico_warehouse/screen/product/barcode_detail_screen.dart';
import 'package:abico_warehouse/screen/product/product_register_detail_screen.dart';
import 'package:abico_warehouse/screen/product/product_register_screen.dart';
import 'package:abico_warehouse/screen/stock_picking/stock_picking_line_screen.dart';
import 'package:abico_warehouse/screen/stock_picking/stock_picking_screen.dart';
import 'package:abico_warehouse/exceptions/exception_manager.dart';
import 'package:abico_warehouse/screen/inventory/stock_inventory_screen.dart';
import 'package:abico_warehouse/screen/inventory/stock_inventory_detail_screen.dart';

class AbicoBlocObserver extends BlocObserver {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: 0));
  Logger errorLogger = Logger();

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    logger.i(event);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.v(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    errorLogger.e(error, stackTrace);
  }
}

class AbicoHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

Future<bool> checkInternetConnection() async {
  var connectivityResult = await Connectivity().checkConnectivity();
  return connectivityResult != ConnectivityResult.none;
}

void main() async {
  HttpOverrides.global = AbicoHttpOverrides();
  Bloc.observer = AbicoBlocObserver();
  ExceptionManager.xMan.debugMode = true;
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  // Open the Hive box for data caching
  await Hive.openBox('cache');

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const AbicoApp());
  });

  bool isConnected = await checkInternetConnection();
  if (kDebugMode) {
    print('Internet connection status: $isConnected');
  }

  // Save screen data to the cache
  saveScreenDataToCache();
  // You can retrieve the cached data using 'retrieveScreenDataFromCache' method when needed.
}

void saveScreenDataToCache() {
  // Retrieve the Hive box for data caching
  var box = Hive.box('cache');

  // Save screen data to the cache
  box.put('dashboard', DashboardScreenData());
  box.put('login', LoginScreenData());
  box.put('stockPickingLine', StockPickingLineScreenData());
  box.put('stockPickingDialog', StockPickingDialogData());
  box.put('productRegisterDetail', ProductRegisterDetailScreenData());
  box.put('productRegister', ProductRegisterDetailScreenData());
  box.put('barCodeDetail', BarcodeDetailScreenData());
  box.put('stockInventoryDetail', StockInventoryDetailScreenData());
  box.put('stockInventory', StockInventoryScreenData());
  box.put('inventoryProductqtyDialog', InventoryProductqtyDialogData());
  box.put('stockInventoryBarCodeDialog', StockInventoryBarcodeDialogData());
}

dynamic retrieveScreenDataFromCache(String screenName) {
  // Retrieve the Hive box for data caching
  var box = Hive.box('cache');

  // Retrieve the screen data from the cache based on the screen name
  return box.get(screenName);
}

class AbicoApp extends StatelessWidget {
  const AbicoApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Retrieve the cached data for the screens
    var dashboardData = retrieveScreenDataFromCache('dashboard');
    var loginData = retrieveScreenDataFromCache('login');
    var stockPickingData = retrieveScreenDataFromCache('stockPicking');
    var stockPickingLineData = retrieveScreenDataFromCache('stockPickingLine');
    var stockPickingDialogData =
        retrieveScreenDataFromCache('stockPickingDialog');
    var productRegisterDetailData =
        retrieveScreenDataFromCache('productRegisterDetail');
    var productRegisterData = retrieveScreenDataFromCache('productRegister');
    var barCodeDetailData = retrieveScreenDataFromCache('barCodeDetail');
    var stockInventoryDetailData =
        retrieveScreenDataFromCache('stockInventoryDetail');
    var stockInventoryData = retrieveScreenDataFromCache('stockInventory');
    var inventoryProductqtyDialogData =
        retrieveScreenDataFromCache('inventoryProductqtyDialog');
    var stockInventoryBarCodeDialogData =
        retrieveScreenDataFromCache('stockInventoryBarCodeDialog');

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: MaterialApp(
        title: 'Tenger Attendance Mobile Application',
        theme: AppTheme.themeData,
        home: loginData != null
            ? LoginScreen(data: loginData)
            : const LoginScreen(),
        debugShowCheckedModeBanner: true,
        navigatorObservers: [routeObserver],
        routes: {
          AppTypes.SCREEN_HOME: (context) => dashboardData != null
              ? DashboardScreen(data: dashboardData)
              : const DashboardScreen(),
          AppTypes.SCREEN_LOGIN: (context) => loginData != null
              ? LoginScreen(data: loginData)
              : const LoginScreen(),
          // Агуулахын хөдөлгөөн
          AppTypes.SCREEN_STOCK_PICKING: (context) => stockPickingData != null
              ? StockPickingScreen(data: stockPickingData)
              : const StockPickingScreen(),
          AppTypes.SCREEN_STOCK_PICKING_LINE: (context) =>
              stockPickingLineData != null
                  ? StockPickingLineScreen(
                      data: stockPickingLineData,
                    )
                  : const StockPickingLineScreen(),
          AppTypes.SCREEN_STOCK_PICKING_DIALOG: (context) =>
              stockPickingDialogData != null
                  ? StockPickingDialog(data: stockPickingDialogData)
                  : const StockPickingDialog(),
          AppTypes.SCREEN_PRODUCT_REGISTER_DETAIL: (context) =>
              productRegisterDetailData != null
                  ? ProductRegisterDetailScreen(
                      data: productRegisterDetailData,
                    )
                  : const ProductRegisterDetailScreen(),
          // Барааны бүртгэл
          AppTypes.SCREEN_PRODUCT_REGISTER: (context) =>
              productRegisterData != null
                  ? ProductRegisterScreen(
                      data: productRegisterDetailData,
                    )
                  : const ProductRegisterScreen(),
          AppTypes.SCREEN_BAR_DETAIL: (context) => barCodeDetailData != null
              ? BarcodeDetailScreen(data: barCodeDetailData)
              : const BarcodeDetailScreen(),
          AppTypes.SCREEN_INVENTORY_DETAIL: (context) =>
              stockInventoryDetailData != null
                  ? StockInventoryDetailScreen(
                      data: stockInventoryDetailData,
                    )
                  : const StockInventoryDetailScreen(),
          // Тооллого бүртгэл
          AppTypes.SCREEN_INVENTORY: (context) => stockInventoryData != null
              ? StockInventoryScreen(
                  data: stockInventoryData,
                )
              : const StockInventoryScreen(),
          AppTypes.SCREEN_INVENTORY_PRODUCTQTY: (context) =>
              inventoryProductqtyDialogData != null
                  ? InventoryProductqtyDialog(
                      data: inventoryProductqtyDialogData)
                  : const InventoryProductqtyDialog(),
          AppTypes.SCREEN_INVENTORY_DIALOG: (context) =>
              stockInventoryBarCodeDialogData != null
                  ? StockInventoryBarCodeDialog(
                      data: stockInventoryBarCodeDialogData)
                  : const StockInventoryBarCodeDialog(),
          // Add more screen routes
        },
      ),
    );
  }
}
