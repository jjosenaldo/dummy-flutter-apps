import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/contact',
    ).modular();
  }
}
