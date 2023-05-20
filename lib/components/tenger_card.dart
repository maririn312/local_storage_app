import 'package:flutter/material.dart';
import 'component_interfaces/tenger_card_interface.dart';

class TengerCard extends TengerCardInterface {
  const TengerCard({
    Key key,
    @required child,
    borderSide = const BorderSide(color: Color(0xffefeff4), width: 1.0),
    backgroundColor,
    height,
    width,
    borderRadius,
  }) : super(
          key: key,
          child: child,
          backgroundColor: backgroundColor,
          borderSide: borderSide,
          height: height,
          width: width,
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: borderSide.color,
          width: borderSide.width,
        ),
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
