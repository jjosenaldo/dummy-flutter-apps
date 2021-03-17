import 'package:f_contact_ex/repository/impl/sqlite_contact_repository.dart';
import 'package:flutter/material.dart';

import 'app.dart';
import 'repository/contact_repository.dart';
import 'service/db_service.dart';

void main() async {
  final dbService = DBService();
  final ContactRepository contactRepository =
      SQLiteContactRepository(service: dbService);
  await contactRepository.insert(
    name: 'Josenaldi',
    phone: '996152448',
    email: 'jose',
  );
  (await contactRepository.findAll())
      .forEach((contact) => debugPrint('$contact'));
  runApp(App());
}
