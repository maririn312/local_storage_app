import 'package:flutter/material.dart';

class TengerNotifTile extends StatelessWidget {
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
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: leading,
      title: title,
      subtitle: subtitle,
      trailing: trailing,
    );
  }
}
