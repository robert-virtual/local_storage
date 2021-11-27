import 'package:flutter/material.dart';
import 'package:local_storage/pages/home_page.dart';
import 'package:local_storage/pages/paquetes.dart';
import 'package:local_storage/pages/settings_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: Scaffold(
          body: SafeArea(
            child: IndexedStack(
              index: currentPage,
              children: [HomePage(), PaquetesPage(),SettingsPage()],
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: currentPage,
            onTap: (index) {
              setState(() {
                currentPage = index;
              });
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: "Paquetes"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings), label: "Settings"),
            ],
          )),
    );
  }
}
