import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String name = 'Username';
  final phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Bienvenido $name"),
          Padding(
            padding: EdgeInsets.all(20),
            child: TextField(
              controller: phone,
              keyboardType: TextInputType.phone,
            ),
          )
        ],
      )),
    );
  }

  void call() async {
    FlutterPhoneDirectCaller.callNumber(phone.text);
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  void getName() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('username') ?? 'Vacio';
    });
  }
}
