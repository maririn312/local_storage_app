import 'package:flutter/material.dart';

class InputButton extends StatelessWidget {
  final Widget icon;
  final Color color;
  final Color fillColor;
  final String hintText;
  final VoidCallback onPressed;

  const InputButton({
    Key key,
    this.icon,
    this.color,
    this.fillColor,
    this.hintText,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(30, 5, 30, 15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: icon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          filled: true,
          hintStyle: TextStyle(color: color, fontSize: 15),
          hintText: hintText,
          fillColor: fillColor,
        ),
        onChanged: (_) {},
      ),
    );
  }
}
