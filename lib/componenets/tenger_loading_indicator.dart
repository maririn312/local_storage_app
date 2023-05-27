// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'component_interfaces/tenger_loading_indicator_interface.dart';

class TengerLoadingIndicator extends TengerLoadingIndicatorInterface {
  @override
  Widget build(BuildContext context) => CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: size,
      );
}
