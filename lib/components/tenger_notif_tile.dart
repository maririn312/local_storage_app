import 'package:flutter/material.dart';

class TengerNotifTile extends StatelessWidget {
  final Widget child;
  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final Widget trailing;
  final Function onPress;
  final bool isRead;

  const TengerNotifTile({
    Key key,
    this.isRead = false,
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.child,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 2),
      child: GestureDetector(
          onTap: onPress,
          child: Container(
              decoration: const BoxDecoration(),
              child: ListTile(
                leading: leading,
                title: title,
                subtitle: subtitle,
                trailing: trailing,
              ))),
    );
  }
}
