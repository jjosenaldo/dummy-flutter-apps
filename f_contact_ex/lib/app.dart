import 'package:flutter/material.dart';

import 'pages/contacts_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My Contacts',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactsPage(),
    );
  }
}
