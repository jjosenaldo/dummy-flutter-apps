import 'package:f_contact_ex/modular/my_child_route.dart';
import 'package:f_contact_ex/pages/add_contact_page.dart';
import 'package:f_contact_ex/pages/contacts_page.dart';
import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:f_contact_ex/store/add_contact_store.dart';
import 'package:f_contact_ex/store/contact_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => ContactsPage()),
    MyChildRoute<ContactInsertParams>(
      '/add',
      child: (_, __) => AddContactPage(),
      transition: TransitionType.leftToRight,
    )
  ];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((_) => ContactStore()),
    Bind.lazySingleton((_) => AddContactStore()),
  ];
}
