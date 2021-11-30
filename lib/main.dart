import 'package:flutter/material.dart';
import 'package:local_storage/pages/login.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Recargas App',
        home: Login());
  }
}
