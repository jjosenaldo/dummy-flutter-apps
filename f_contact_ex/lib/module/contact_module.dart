import 'package:f_contact_ex/pages/contacts_page.dart';
import 'package:f_contact_ex/store/contact_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactModule extends Module {
  @override
  final List<ChildRoute> routes = [
    ChildRoute('/contact', child: (_, __) => ContactsPage())
  ];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((_) => ContactStore()),
  ];
}
