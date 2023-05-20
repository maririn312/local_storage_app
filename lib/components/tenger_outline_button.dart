import 'package:flutter/material.dart';

import 'component_interfaces/tenger_button_interface.dart';

class TengerOutlineButton extends TengerButtonInterface {
  const TengerOutlineButton({
    Key key,
    Widget child,
    VoidCallback onPressed,
    Color color,
  }) : super(key: key, child: child, onPressed: onPressed, color: color);

  @override
  Widget build(BuildContext context) {
    Color clr = color ?? Theme.of(context).colorScheme.background;
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: clr,
        shape: shape ??
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
      ),
      onPressed: onPressed,
      child: Center(child: child),
    );
  }
}
