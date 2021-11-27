import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final name = TextEditingController();
  String nameFromPref = 'username';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SettingsPage"),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(nameFromPref),
              TextField(
                controller: name,
                decoration: const InputDecoration(hintText: "Nombre"),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton(
            onPressed: () {
              saveName();
            },
            child: const Icon(Icons.save),
          ),
          FloatingActionButton(
            onPressed: () {
              getName();
            },
            child: const Icon(Icons.arrow_downward),
          ),
        ],
      ),
    );
  }

  void getName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      nameFromPref = prefs.getString('username') ?? 'Vacio';
    });

  }
  void saveName() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('username', name.text);
    name.clear();
  }
}
