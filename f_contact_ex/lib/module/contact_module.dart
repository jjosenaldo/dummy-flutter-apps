import 'package:f_contact_ex/modular/my_modular.dart';
import 'package:f_contact_ex/pages/contact_page.dart';
import 'package:f_contact_ex/pages/contacts_page.dart';
import 'package:f_contact_ex/store/contact_page_store.dart';
import 'package:f_contact_ex/store/contacts_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactsModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, __) => ContactsPage(),
    ),
    MyChildRoute<Object>(
      '/contact',
      child: (_, args) => ContactPage(args.data),
      transition: TransitionType.leftToRight,
    ),
  ];

  @override
  final List<Bind> binds = [
    Bind.factory((_) => ContactsStore()),
    Bind.lazySingleton((_) => ContactPageStore()),
  ];
}
