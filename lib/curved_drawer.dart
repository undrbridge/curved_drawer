library curved_drawer;

import 'package:curved_drawer/src/drawer_custom_painter.dart';
import 'package:curved_drawer/src/drawer_nav_item.dart';
import 'package:flutter/material.dart';

class CurvedDrawer extends StatefulWidget {
  //List of items shown in the drawer
  final List<DrawerItem> items;
  //currently selected index
  final int index;
  //color of the drawer
  final Color color;
  //color of the pill or cirlce that is shown when selected
  final Color buttonBackgroundColor;
  //color of the text and icons in the drawer
  final Color labelColor;
  //color behind the curve
  final Color backgroundColor;
  //function to be executed on nav item tapped
  final ValueChanged<int> onTap;
  //curve for the animation
  final Curve animationCurve;
  //duration of the animation
  final Duration animationDuration;
  //width of the drawer
  final double width;
  //boolean to be used if drawer is used as end drawer
  final bool isEndDrawer;

  CurvedDrawer(
      {Key key,
      @required this.items,
      //default select first item
      this.index = 0,
      this.color = Colors.white,
      this.buttonBackgroundColor = Colors.white,
      this.labelColor = Colors.black54,
      this.backgroundColor = Colors.transparent,
      this.onTap,
      this.animationCurve = Curves.easeOut,
      this.animationDuration = const Duration(milliseconds: 600),
      this.width = 75,
      this.isEndDrawer = false})
      : assert(items != null),
        assert(items.length >= 1),
        assert(0 <= index && index < items.length),
        assert(0 <= width && width <= 100),
        super(key: key);

  @override
  _CurvedDrawerState createState() => _CurvedDrawerState();
}

class _CurvedDrawerState extends State<CurvedDrawer>
    with SingleTickerProviderStateMixin {
  double _startingPos;
  int _endingIndex = 0;
  double _pos;
  double _buttonHide = 0;
  DrawerNavItem _icon;
  AnimationController _animationController;
  int _length;
  int _isEnd;
  List<DrawerNavItem> _items = [];

  @override
  void initState() {
    super.initState();
    widget.items.forEach((item) {
      _items.add(
          DrawerNavItem(icon: item.icon,
              label: item.label,
              color: widget.labelColor,
              background: widget.buttonBackgroundColor,
              size: widget.width / 3
          ));
    });
    _icon = _items[widget.index];
    _length = _items.length;
    _pos = widget.index / _length;
    _startingPos = _pos;
    _isEnd = widget.isEndDrawer ? -1 : 1;
    _animationController = AnimationController(vsync: this, value: _pos);
    _animationController.addListener(() {
      setState(() {
        _pos = _animationController.value;
        final endingPos = _endingIndex / widget.items.length;
        final middle = (_startingPos + endingPos) / 2;
        if ((endingPos - _pos).abs() < (_startingPos - _pos).abs()) {
          _icon = _items[_endingIndex];
        }
        _buttonHide =
            (1 - ((middle - _pos) / (_startingPos - middle)).abs()).abs();
      });
    });
  }

  @override
  void didUpdateWidget(CurvedDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.index != widget.index) {
      final newPosition = widget.index / _length;
      _startingPos = _pos;
      _endingIndex = widget.index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: widget.width,
      color: widget.backgroundColor,
      child: Stack(
          overflow: Overflow.visible,
          alignment:
              widget.isEndDrawer ? Alignment.centerRight : Alignment.centerLeft,
          children: <Widget>[
            Positioned(
              left: widget.isEndDrawer
                  ? null
                  : -widget.width * 0.6 - (75.0 - widget.width),
              right: widget.isEndDrawer
                  ? -widget.width * 0.6 - (75.0 - widget.width)
                  : null,
              top: _pos * size.height,
              height: size.height / _length,
              child: Center(
                  child: Transform.translate(
                      offset: Offset(
                        _isEnd *
                            (1 - _buttonHide) *
                            (75 + (widget.width * 0.2)),
                        0,
                      ),
                      child: _icon)),
            ),
            Positioned(
                top: 0,
                height: size.height,
                left: widget.isEndDrawer ? null : 0,
                right: widget.isEndDrawer ? 0 : null,
                width: widget.width,
                child: CustomPaint(
                    painter: DrawerCustomPainter(
                        _pos,
                        _length,
                        widget.color,
                        Directionality.of(context),
                        widget.width,
                        widget.isEndDrawer),
                    child:
                        Container(width: widget.width, height: size.height))),
            Positioned(
              top: 0,
              bottom: 0,
              left: widget.isEndDrawer ? null : 0,
              right: widget.isEndDrawer ? 0 : null,
              child: SizedBox(
                  width: widget.width * 1.25,
                  child: Column(
                      children: _items.map((item) {
                    return NavButton(
                      onTap: _buttonTap,
                      position: _pos,
                      length: _length,
                      isEndDrawer: widget.isEndDrawer,
                      width: widget.width,
                      color: widget.labelColor,
                      index: _items.indexOf(item),
                      icon: item.icon,
                    );
                  }).toList())),
            ),
          ]),
    );
  }

  void setPage(int index) {
    _buttonTap(index);
  }

  void _buttonTap(int index) {
    if (widget.onTap != null) {
      widget.onTap(index);
    }
    final newPosition = index / _length;
    setState(() {
      _startingPos = _pos;
      _endingIndex = index;
      _animationController.animateTo(newPosition,
          duration: widget.animationDuration, curve: widget.animationCurve);
    });
  }
}

class DrawerItem {
  final String label;
  final Icon icon;
  const DrawerItem({
    this.label = "",
    @required this.icon,
  }) : assert(icon != null);
}
