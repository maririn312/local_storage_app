// ignore_for_file: use_key_in_widget_constructors, prefer_if_null_operators, unnecessary_this, avoid_unnecessary_containers

import 'package:abico_warehouse/components/tenger_loading_indicator.dart';
import 'package:flutter/material.dart';

import 'component_interfaces/tenger_button_interface.dart';

class TengerElevatedButton extends TengerButtonInterface {
  final EdgeInsets padding;

  const TengerElevatedButton({
    @required child,
    @required onPressed,
    color,
    shape,
    this.padding,
    bool isLoading,
  }) : super(
          child: child,
          onPressed: onPressed,
          color: color,
          shape: shape,
        );

  @override
  Widget build(BuildContext context) {
    BorderRadius tmpRadius = BorderRadius.circular(8);
    if (shape is RoundedRectangleBorder) {
      tmpRadius = (shape as RoundedRectangleBorder).borderRadius;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: color == null ? null : color,
        borderRadius: shape == null ? BorderRadius.circular(8) : tmpRadius,
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: this.padding,
          backgroundColor: Theme.of(context).colorScheme.surface,
          elevation: 0,
          disabledForegroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.38),
          disabledBackgroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.12),
          shadowColor: Theme.of(context).colorScheme.surface,
          shape: shape,
        ),
        onPressed: isLoading ? () {} : onPressed,
        child: Container(
          child: Center(
            child: isLoading
                ? SizedBox(
                    child: TengerLoadingIndicator(),
                  )
                : child,
          ),
        ),
      ),
    );
  }
}
