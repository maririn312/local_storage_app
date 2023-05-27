import 'package:flutter/material.dart';

enum TengerMessageType {
  success,
  warning,
  error,
  info,
}

abstract class TengerMessageInterface extends StatelessWidget {
  final TengerMessageType type;
  final String message;
  final Icon icon;
  final Color textColor;
  final Color backgroundColor;

  const TengerMessageInterface(
      {Key key,
      @required this.type,
      @required this.message,
      this.icon,
      this.textColor,
      this.backgroundColor})
      : super(key: key);
}
