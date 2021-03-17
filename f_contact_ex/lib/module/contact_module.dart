import 'package:f_contact_ex/pages/add_contact_page.dart';
import 'package:f_contact_ex/pages/contacts_page.dart';
import 'package:f_contact_ex/store/contact_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => ContactsPage()),
    ChildRoute(
      '/add',
      child: (_, __) => AddContactPage(),
      transition: TransitionType.leftToRight,
    )
  ];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((_) => ContactStore()),
  ];
}
