// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:local_storage_app/componenets/component_interfaces/tenger_card_interface.dart';

class TengerCard extends TengerCardInterface {
  const TengerCard({
    @required child,
    borderSide = const BorderSide(color: Color(0xffefeff4), width: 1.0),
    backgroundColor,
    height,
    width,
    borderRadius,
  }) : super(
            child: child,
            backgroundColor: backgroundColor,
            borderSide: borderSide,
            height: height,
            width: width);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.symmetric(
          horizontal: borderSide,
          vertical: borderSide,
        ),
        borderRadius: borderRadius,
      ),
      child: child,
    );
  }
}
