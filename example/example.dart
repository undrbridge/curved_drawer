import 'package:curved_drawer/curved_drawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return MaterialApp(
      title: 'Animation Playground',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Playground(title: 'Curved Drawer Demo'),
    );
  }
}

class Playground extends StatefulWidget {
  const Playground({Key? key, this.title}) : super(key: key);

  final String? title;

  @override
  _PlaygroundState createState() => _PlaygroundState();
}

class _PlaygroundState extends State<Playground> {
  int index = 0;
  double leftWidth = 75.0;
  int leftTextColor = 1;
  int leftBackgroundColor = 0;
  double rightWidth = 75.0;
  int rightTextColor = 1;
  int rightBackgroundColor = 0;

  static const List<Color> colorPallete = <Color>[
    Colors.white,
    Colors.black,
    Colors.blue,
    Colors.blueAccent,
    Colors.red,
    Colors.redAccent,
    Colors.teal,
    Colors.orange,
    Colors.pink,
    Colors.purple,
    Colors.lime,
    Colors.green,
  ];

  static const List<DrawerItem> _drawerItems = <DrawerItem>[
    DrawerItem(icon: Icon(Icons.people), label: "People"),
    DrawerItem(icon: Icon(Icons.trending_up), label: "Trending"),
    DrawerItem(icon: Icon(Icons.tv)),
    DrawerItem(icon: Icon(Icons.work), label: "Work"),
    DrawerItem(icon: Icon(Icons.web)),
    DrawerItem(icon: Icon(Icons.videogame_asset)),
    DrawerItem(icon: Icon(Icons.book), label: "Book"),
    DrawerItem(icon: Icon(Icons.call), label: "Telephone")
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      drawer: CurvedDrawer(
        index: index,
        width: leftWidth,
        color: colorPallete[leftBackgroundColor],
        buttonBackgroundColor: colorPallete[leftBackgroundColor],
        labelColor: colorPallete[leftTextColor],
        items: _drawerItems,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
      ),
      endDrawer: CurvedDrawer(
        index: index,
        width: rightWidth,
        color: colorPallete[rightBackgroundColor],
        buttonBackgroundColor: colorPallete[rightBackgroundColor],
        labelColor: colorPallete[rightTextColor],
        isEndDrawer: true,
        items: _drawerItems,
        onTap: (newIndex) {
          setState(() {
            index = newIndex;
          });
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Current index is $index',
            ),
            const SizedBox(
              height: 15,
            ),
            Text("Left Width = $leftWidth"),
            Slider(
              label: "Left Drawer Width",
              activeColor: Colors.blue,
              min: 50.0,
              max: 100.0,
              divisions: 50,
              value: leftWidth,
              onChanged: (value) => setState(() => leftWidth = value),
            ),
            const SizedBox(
              height: 15,
            ),
            SliderTheme(
              child: Slider(
                label: "Left Drawer Background Color",
                activeColor: colorPallete[leftBackgroundColor],
                min: 0,
                max: colorPallete.length.toDouble() - 1.0,
                divisions: colorPallete.length,
                value: leftBackgroundColor.toDouble(),
                onChanged: (value) => setState(() {
                  leftBackgroundColor = value.toInt();
                }),
              ),
              data: const SliderThemeData(
                valueIndicatorTextStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SliderTheme(
              child: Slider(
                label: "Left Drawer Label Color",
                activeColor: colorPallete[leftTextColor],
                min: 0,
                max: colorPallete.length.toDouble() - 1.0,
                divisions: colorPallete.length,
                value: leftTextColor.toDouble(),
                onChanged: (value) => setState(() {
                  leftTextColor = value.toInt();
                }),
              ),
              data: const SliderThemeData(
                valueIndicatorTextStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Text("Right Width = $rightWidth"),
            Slider(
              label: "Right Drawer Width",
              activeColor: Colors.blue,
              min: 50.0,
              max: 100.0,
              divisions: 50,
              value: rightWidth,
              onChanged: (value) => setState(() => rightWidth = value),
            ),
            const SizedBox(
              height: 15,
            ),
            SliderTheme(
              child: Slider(
                label: "Right Drawer Background Color",
                activeColor: colorPallete[rightBackgroundColor],
                min: 0,
                max: colorPallete.length.toDouble() - 1.0,
                divisions: colorPallete.length,
                value: rightBackgroundColor.toDouble(),
                onChanged: (value) => setState(() {
                  rightBackgroundColor = value.toInt();
                }),
              ),
              data: const SliderThemeData(
                valueIndicatorTextStyle: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            SliderTheme(
              child: Slider(
                label: "Right Drawer Label Color",
                activeColor: colorPallete[rightTextColor],
                min: 0,
                max: colorPallete.length.toDouble() - 1.0,
                divisions: colorPallete.length,
                value: rightTextColor.toDouble(),
                onChanged: (value) => setState(() {
                  rightTextColor = value.toInt();
                }),
              ),
              data: const SliderThemeData(
                valueIndicatorTextStyle: TextStyle(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
