# curved_drawer

A Flutter widget that provides an easy to use animated drawer.

![Gif](https://github.com/rafalbednarczuk/curved_navigation_bar/blob/master/example.gif "Fancy Gif")


### Add dependency

```yaml
dependencies:
  curved_drawer: ^0.0.1 #latest version
```
### Simple Implementation
```dart
Scaffold(
  drawer: CurvedDrawer(
    color: Colors.white,
    labelColor: Colors.black54,
    width: 75.0
    items: <DrawerItem>[
      DrawerItem(icon: personIcon),
      //Optional Label Text
      DrawerItem(icon: messageIcon, label: "Messages")
    ],
    onTap: (index) {
      //Handle button tap
    },
  ),
  body: Container(),
)
```

### Attributes

items: List of DrawerItems  
index: index of selected item, can be used to change current index or to set initial index  
color: Color of drawer, default Colors.white 
buttonBackgroundColor: background color of floating button, default same as color attribute  
backgroundColor: Color of NavigationBar's background, default Colors.transparent 
onTap: Function handling taps on items  
animationCurve: Curves interpolating button change animation, default Curves.easeOutCubic  
animationDuration: Duration of button change animation, default Duration(milliseconds: 600)  
width: Width of Drawer, min 50.0, max 100.0
isEndDrawer: set to true if used as as an end drawer, default is false