//
// ignore_for_file: unused_local_variable, depend_on_referenced_packages

import 'dart:io';

import 'package:abico_warehouse/app_theme.dart';
import 'package:abico_warehouse/app_types.dart';
import 'package:abico_warehouse/components/alert_dialog/inventory_productqty_dialog.dart';
import 'package:abico_warehouse/components/alert_dialog/stock_inventroy_barcode_dialog.dart';
import 'package:abico_warehouse/components/alert_dialog/stock_picking_dialog.dart';
import 'package:abico_warehouse/screen/dashboard/dashboard.dart';
import 'package:abico_warehouse/screen/product/barcode_detail_screen.dart';
import 'package:abico_warehouse/screen/product/product_register_detail_screen.dart';
import 'package:abico_warehouse/screen/product/product_register_screen.dart';
import 'package:abico_warehouse/screen/stock_picking/stock_picking_line_screen.dart';
import 'package:abico_warehouse/screen/stock_picking/stock_picking_screen.dart';
import 'package:abico_warehouse/screen/login/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';
import 'exceptions/exception_manager.dart';
import 'screen/dashboard/tabs/category/sub_category_screen.dart';
import 'screen/inventory/stock_inventory/stock_inventory_detail_screen.dart';
import 'screen/inventory/stock_inventory/stock_inventory_screen.dart';

/// ============================================================= ///
class StockBlocObserver extends BlocObserver {
  Logger logger = Logger(printer: PrettyPrinter(methodCount: 0));
  Logger errorLogger = Logger();

  @override
  void onEvent(Bloc bloc, Object event) {
    super.onEvent(bloc, event);
    logger.i(event);
  }

  @override
  onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    logger.v(transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    errorLogger.e(error, stackTrace);
  }
}

/// ============================================================= ///
class StockHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

/// ============================================================= ///
final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

void main() async {
  /// ===================== APP PRE SETUPS ======================== ///
  HttpOverrides.global = StockHttpOverrides();
  Bloc.observer = StockBlocObserver();
  ExceptionManager.xMan.debugMode = true;
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const StockInventoryApp());
}

class StockInventoryApp extends StatelessWidget {
  const StockInventoryApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode currentFocus = FocusScope.of(context);
        },
        child: MaterialApp(
            title: 'Warehouse Mobile Application',
            theme: AppTheme.themeData,
            home: const LoginScreen(),
            debugShowCheckedModeBanner: true,
            navigatorObservers: [
              routeObserver
            ],
            routes: {
              AppTypes.SCREEN_HOME: (context) => const DashboardScreen(),
              AppTypes.SCREEN_SUB: (context) => SubCategoryScreen(),
              AppTypes.SCREEN_LOGIN: (context) => const LoginScreen(),
              AppTypes.SCREEN_STOCK_PICKING: (context) =>
                  const StockPickingScreen(),
              AppTypes.SCREEN_STOCK_PICKING_LINE: (context) =>
                  const StockPickingLineScreen(),
              AppTypes.SCREEN_STOCK_PICKING_DIALOG: (context) =>
                  const StockPickingDialog(),
              AppTypes.SCREEN_PRODUCT_REGISTER_DETAIL: (context) =>
                  ProductRegisterDetailScreen(),
              AppTypes.SCREEN_PRODUCT_REGISTER: (context) =>
                  ProductRegisterScreen(),
              AppTypes.SCREEN_BAR_DETAIL: (context) => BarcodeDetailScreen(),
              AppTypes.SCREEN_INVENTORY_DETAIL: (context) =>
                  StockInventoryDetailScreen(),
              AppTypes.SCREEN_INVENTORY: (context) => StockInventoryScreen(),
              AppTypes.SCREEN_INVENTORY_PRODUCTQTY: (context) =>
                  const InventoryProductqtyDialog(),
              AppTypes.SCREEN_INVENTORY_DIALOG: (context) =>
                  const StockInventoryBarCodeDialog(),
            }));
  }
}