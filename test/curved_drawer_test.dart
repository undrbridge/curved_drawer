import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:curved_drawer/curved_drawer.dart';

void main() {
  Icon personIcon = Icon(Icons.person);
  Icon messageIcon = Icon(Icons.message);
  List<DrawerItem> _items = <DrawerItem>[
    DrawerItem(icon: personIcon),
    DrawerItem(icon: messageIcon)
  ];
  testWidgets('Widget with Icons', (WidgetTester tester) async {
    await tester.pumpWidget(CurvedDrawer(items: _items));
    final personFinder = find.byIcon(personIcon.icon);
    final messageFinder = find.byIcon(messageIcon.icon);

    expect(personFinder, findsOneWidget);
    expect(messageFinder, findsOneWidget);
  });
}
