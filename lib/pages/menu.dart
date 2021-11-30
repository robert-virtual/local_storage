import 'package:flutter/material.dart';
import 'package:local_storage/pages/home_page.dart';
import 'package:local_storage/pages/paquetes.dart';
import 'package:local_storage/pages/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Menu extends StatefulWidget {
  Menu({Key? key}) : super(key: key);

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int paginaActual = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: paginaActual,
        children: [HomePage(), PaquetesPage(), SettingsPage()],
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: paginaActual,
          onTap: (index) {
            setState(() {
              paginaActual = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.power), label: "Recargas"),
            BottomNavigationBarItem(
                icon: Icon(Icons.phone_callback), label: "Paquetes"),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Ajustes")
          ]),
    );
  }
}
