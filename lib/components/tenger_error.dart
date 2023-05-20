import 'package:flutter/material.dart';

class TengerError extends StatelessWidget {
  final String error;

  const TengerError({Key key, @required this.error}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (error == null) return null;
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: BoxDecoration(
        color: Colors.red.shade100,
        borderRadius: const BorderRadius.all(Radius.circular(5)),
      ),
      child: Flexible(
        child: Text(
          error,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }
}
