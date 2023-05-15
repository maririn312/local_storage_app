// import 'package:abox_mobile/components/component_interfaces/rain_message_interface.dart';
// ignore_for_file: prefer_if_null_operators, duplicate_ignore

import 'package:abico_warehouse/components/component_interfaces/tenger_message_interface.dart';
import 'package:flutter/material.dart';

class TengerMessage extends TengerMessageInterface {
  final double fontSize;
  final double iconSize;
  final EdgeInsets padding;

  // ignore: use_key_in_widget_constructors
  const TengerMessage({
    this.fontSize = 15,
    this.iconSize = 28,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    type = TengerMessageType.warning,
    @required message,
  }) : super(type: type, message: message);

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    Color accentColor;
    IconData iconData;

    if (type == TengerMessageType.warning) {
      bgColor = const Color(0xfffff8e6);
      accentColor = const Color(0xffe6a700);
      iconData = Icons.warning_amber;
    } else if (type == TengerMessageType.success) {
      // ignore: prefer_const_constructors
      bgColor = Color(0xffe6f6e6);
      accentColor = const Color(0xff009400);
      iconData = Icons.check_circle_outline;
    } else if (type == TengerMessageType.error) {
      bgColor = const Color(0xffffebec);
      accentColor = const Color(0xffe13238);
      iconData = Icons.local_fire_department;
    } else if (type == TengerMessageType.info) {
      bgColor = const Color(0xffeef9fd);
      accentColor = const Color(0xff4cb3d4);
      iconData = Icons.wb_incandescent_rounded;
    }

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          stops: const [0.015, 0.015],
          // ignore: duplicate_ignore
          colors: [
            accentColor,
            // ignore: prefer_if_null_operators
            backgroundColor == null ? bgColor : backgroundColor
          ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 4),
          Icon(
            icon == null ? iconData : icon,
            color: textColor == null ? accentColor : textColor,
            size: iconSize,
          ),
          const SizedBox(width: 8),
          Flexible(
              child: Text(
            message,
            style: TextStyle(
              color: textColor == null ? accentColor : textColor,
              fontWeight: FontWeight.w500,
              fontSize: fontSize,
            ),
          ))
        ],
      ),
    );
  }
}
