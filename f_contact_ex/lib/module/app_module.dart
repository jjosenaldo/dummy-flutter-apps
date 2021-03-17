import 'package:f_contact_ex/module/contact_module.dart';
import 'package:f_contact_ex/pages/contacts_page.dart';
import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:f_contact_ex/repository/impl/sqlite_contact_repository.dart';
import 'package:f_contact_ex/service/db_service.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ModuleRoute('/contact', module: ContactModule()),
  ];

  @override
  final List<Bind> binds = [
    Bind.singleton((_) => DBService()),
    Bind.singleton<ContactRepository>(
      (_) => SQLiteContactRepository(
        service: Modular.get(),
      ),
    ),
  ];
}
