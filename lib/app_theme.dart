import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTheme {
  static ThemeData get themeData => ThemeData(
        fontFamily: 'Manrope',
        canvasColor: const Color(0xffefeff4),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: {
            TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          },
        ),
        appBarTheme:
            const AppBarTheme(systemOverlayStyle: SystemUiOverlayStyle.dark),
        colorScheme: const ColorScheme.light(
          background: Color(0xffffffff),
          surface: Color(0xffefeff4),
          primary: Color(0xff6669f1),
          secondary: Color(0xff6669f1),
          onError: Colors.redAccent,
          onBackground: Colors.black,
          onSurface: Colors.black,
          onPrimary: Colors.white,
        ).copyWith(background: const Color(0xffefeff4)),
      );
}
