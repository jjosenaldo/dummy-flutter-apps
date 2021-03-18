import 'package:f_contact_ex/model/contact.dart';
import 'package:f_contact_ex/model/maybe_contact.dart';
import 'package:f_contact_ex/modular/my_modular.dart';
import 'package:f_contact_ex/pages/contact_page.dart';
import 'package:f_contact_ex/pages/contacts_page.dart';
import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:f_contact_ex/store/contact_page_store.dart';
import 'package:f_contact_ex/store/contacts_store.dart';
import 'package:flutter_modular/flutter_modular.dart';

class ContactsModule extends Module {
  @override
  final List<ModularRoute> routes = [
    ChildRoute('/', child: (_, __) => ContactsPage()),
    MyModuleRoute<ContactInsertParams>(
      '/contact',
      module: ContactModule(),
      transition: TransitionType.leftToRight,
    ),
  ];

  @override
  final List<Bind> binds = [
    Bind.lazySingleton((_) => ContactsStore()),
  ];
}

class ContactModule extends Module {
  static MaybeContact _maybeContact = MaybeContact();

  ContactModule(Contact? maybeContact) {
    ContactModule._maybeContact.contact = maybeContact;
  }

  @override
  final List<ModularRoute> routes = [
    MyChildRoute<ContactInsertParams>(
      '/contact',
      child: (_, __) => ContactPage(),
      transition: TransitionType.leftToRight,
    ),
  ];

  @override
  final List<Bind<Object>> binds = [
    Bind.instance(_maybeContact),
    Bind.lazySingleton(
      (_) => ContactPageStore(Modular.get<MaybeContact>().contact),
    ),
  ];
}
