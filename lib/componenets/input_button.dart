import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  // final Icons icon;
  final Color color;
  final Color colour;
  final Widget child;

  final String text;
  final VoidCallback callBackData;

  const InputButton({
    Key key,
    this.child,
    this.color,
    this.colour,
    this.text,
    this.callBackData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.fromLTRB(30, 5, 30, 15),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        //  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
        child: TextField(
            decoration: InputDecoration(
          prefixIcon: child,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: color, fontSize: 15),
          hintText: text,
          fillColor: colour,
        )));
  }
}
