import 'package:f_contact_ex/repository/impl/sqlite_contact_repository.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app.dart';
import 'repository/contact_repository.dart';
import 'service/db_service.dart';

void _provideStuff() {
  final dbService = DBService();
  final contactRepository = SQLiteContactRepository(service: dbService);
  GetIt.I.registerSingleton<ContactRepository>(contactRepository);
}

void main() {
  _provideStuff();

  runApp(App());
}
