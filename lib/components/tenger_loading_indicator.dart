import 'package:flutter/material.dart';

class TengerLoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;

  const TengerLoadingIndicator({Key key, this.size = 4, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size * 3,
      height: size * 3,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
                color ?? Theme.of(context).primaryColor),
            strokeWidth: size,
          ),
          RotationTransition(
            turns: const AlwaysStoppedAnimation(0.7),
            child: Icon(
              Icons.refresh,
              size: size * 2,
              color: color ?? Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
