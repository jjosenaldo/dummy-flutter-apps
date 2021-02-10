import 'package:f_vespa/pages/bovespa_page.dart';
import 'package:flutter/material.dart';

class BovespaApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BovespaPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
