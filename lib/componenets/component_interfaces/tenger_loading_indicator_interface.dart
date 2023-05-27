import 'package:flutter/material.dart';

abstract class TengerLoadingIndicatorInterface extends StatelessWidget {
  final double size;
  final Color color;

  const TengerLoadingIndicatorInterface(
      {Key key, this.size = 8.0, this.color = const Color(0xff6669f1)})
      : super(key: key);
}
