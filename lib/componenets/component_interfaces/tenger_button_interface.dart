import 'package:flutter/material.dart';

abstract class TengerButtonInterface extends StatelessWidget {
  final Widget child;
  final Function onPressed;
  final ShapeBorder shape;
  final bool isLoading;
  final Color color;

  const TengerButtonInterface({
    Key key,
    this.child,
    this.onPressed,
    this.shape,
    this.isLoading = false,
    this.color,
    Type text,
  }) : super(key: key);
}
