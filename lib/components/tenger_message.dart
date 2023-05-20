import 'package:abico_warehouse/components/component_interfaces/tenger_message_interface.dart';
import 'package:flutter/material.dart';

class TengerMessage extends TengerMessageInterface {
  final double fontSize;
  final double iconSize;
  final EdgeInsets padding;

  const TengerMessage({
    Key key,
    this.fontSize = 15,
    this.iconSize = 28,
    this.padding = const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
    TengerMessageType type = TengerMessageType.warning,
    @required String message,
  }) : super(key: key, type: type, message: message);

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
      bgColor = const Color(0xffe6f6e6);
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
          colors: [
            accentColor,
            backgroundColor ?? bgColor,
          ],
        ),
        borderRadius: const BorderRadius.all(Radius.circular(8)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(width: 4),
          Icon(
            icon ?? iconData,
            color: textColor ?? accentColor,
            size: iconSize,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              message,
              style: TextStyle(
                color: textColor ?? accentColor,
                fontWeight: FontWeight.w500,
                fontSize: fontSize,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
