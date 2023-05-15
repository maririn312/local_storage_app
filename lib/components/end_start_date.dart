// ignore_for_file: unused_element, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class EndStartDate extends StatelessWidget {
  // final Icons icon;
  final Text textStart;
  final Icon iconStart;
  final Widget child;

  const EndStartDate({
    Key key,
    this.textStart,
    this.iconStart,
    this.child,
  }) : super(key: key);

  Widget _buildExpandedTile(String data) {
    return data == "null"
        ? Container()
        : Expanded(
            child: Center(
            child: Text(
              '${data == "null" ? " " : data.substring(11, 19)}',
              style: const TextStyle(fontSize: 15),
            ),
          ));
  }

  @override
  Widget build(BuildContext context) {
    // ignore: todo
    // TODO: implement build
    throw UnimplementedError();
  }
}
