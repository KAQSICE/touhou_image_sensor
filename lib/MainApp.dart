import 'package:flutter/material.dart';

import 'DesktopPage.dart';
import 'MobilePage.dart';

class MainApp extends StatefulWidget {
  @override
  State createState() {
    return MainState();
  }
}

class MainState extends State {
  int currentIndex;
  final pages = [MobilePage(), DesktopPage()];

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Touhou Image Sensor',
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Colors.lightBlueAccent,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.pinkAccent,
      ),
      home: mainScaffold(),
    );
  }

  Widget mainScaffold() {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.image),
        title: Text('Touhou Image Sensor'),
      ),
      bottomNavigationBar: navigationBar(),
      body: pages[currentIndex],
    );
  }

  Widget navigationBar() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.phone_android),
          title: Text('Mobile'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.desktop_windows),
          title: Text('Desktop'),
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: currentIndex,
      onTap: (index) {
        changePage(index);
      },
    );
  }

  changePage(int index) {
    if (index != currentIndex) {
      setState(() {
        currentIndex = index;
      });
    }
  }
}
