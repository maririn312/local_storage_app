import 'package:flutter/material.dart';

abstract class TengerCardInterface extends StatelessWidget {
  final Widget child;
  final BorderSide borderSide;
  final BorderRadius borderRadius;
  final Color backgroundColor;
  final double height;
  final double width;

  const TengerCardInterface(
      {Key key,
      this.child,
      this.borderSide = const BorderSide(color: Color(0xffefeff4), width: 1.0),
      this.width,
      this.height,
      this.borderRadius = const BorderRadius.all(Radius.circular(8)),
      this.backgroundColor = Colors.white})
      : super(key: key);
}
