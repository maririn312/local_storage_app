import 'package:abico_warehouse/components/tenger_loading_indicator.dart';
import 'package:flutter/material.dart';

import 'component_interfaces/tenger_button_interface.dart';

class TengerElevatedButton extends TengerButtonInterface {
  final EdgeInsets padding;

  const TengerElevatedButton({
    Key key,
    @required child,
    @required onPressed,
    color,
    shape,
    this.padding,
    bool isLoading,
  }) : super(
          key: key,
          child: child,
          onPressed: onPressed,
          color: color,
          shape: shape,
        );

  @override
  Widget build(BuildContext context) {
    final buttonShape = shape ??
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        );

    final buttonDecoration = BoxDecoration(
      color: color,
      borderRadius: buttonShape is RoundedRectangleBorder
          ? buttonShape.borderRadius
          : null,
    );

    return DecoratedBox(
      decoration: buttonDecoration,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: padding,
          backgroundColor: Theme.of(context).colorScheme.surface,
          disabledForegroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.38),
          disabledBackgroundColor:
              Theme.of(context).colorScheme.surface.withOpacity(0.12),
          elevation: 0,
          shadowColor: Theme.of(context).colorScheme.surface,
          shape: buttonShape,
        ),
        onPressed: isLoading ? () {} : onPressed,
        child: Center(
          child: isLoading ? const TengerLoadingIndicator() : child,
        ),
      ),
    );
  }
}
