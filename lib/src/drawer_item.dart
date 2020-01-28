import 'package:flutter/material.dart';

class DrawerItem {
  final String label;
  final Icon icon;
  const DrawerItem({
    this.label = "",
    @required this.icon,
  }) : assert(icon != null);
}

class DrawerNavItem extends StatelessWidget {
  final Icon icon;
  final String label;
  final double size;
  final Color color;
  final Color background;

  const DrawerNavItem(
      {Key key,
      @required this.icon,
      this.label = "",
      this.size = 25.0,
      this.color = Colors.black54,
      this.background = Colors.white})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(this.size)),
      color: this.background,
      type: MaterialType.button,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          children: this.label.isNotEmpty
              ? <Widget>[
                  Icon(this.icon.icon, size: this.size, color: this.color),
                  SizedBox(width: 5),
                  Text(
                    label,
                    style: TextStyle(color: this.color),
                  ),
                ]
              : <Widget>[
                  Icon(this.icon.icon, size: this.size, color: this.color),
                ],
        ),
      ),
    );
  }
}

class NavButton extends StatelessWidget {
  final double position;
  final int length;
  final int index;
  final bool isEndDrawer;
  final double width;
  final Color color;
  final ValueChanged<int> onTap;
  final Icon icon;

  NavButton(
      {this.onTap,
      this.position,
      this.length,
      this.isEndDrawer,
      this.width,
      this.color,
      this.index,
      this.icon});

  @override
  Widget build(BuildContext context) {
    final desiredPosition = 1.0 / length * index;
    final difference = (position - desiredPosition).abs();
    final verticalAlignment = 1 - length * difference;
    final opacity = length * difference;
    final directionMultiplier = isEndDrawer ? 1 : -1;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          onTap(index);
        },
        child: Container(
            width: this.width,
            child: Transform.translate(
              offset: Offset(
                  difference < 1.0 / length
                      ? verticalAlignment * directionMultiplier * 40
                      : 0,
                  0),
              child: Opacity(
                  opacity: difference < 1.0 / length * 0.99 ? opacity : 1.0,
                  child: Icon(
                    icon.icon,
                    color: this.color,
                  )),
            )),
      ),
    );
  }
}
