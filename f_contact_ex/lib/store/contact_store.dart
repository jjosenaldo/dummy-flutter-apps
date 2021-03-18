import 'package:f_contact_ex/model/contact.dart';
import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'contact_store.g.dart';

class ContactStore = _ContactStore with _$ContactStore;

abstract class _ContactStore with Store {
  ObservableList<Contact> _contacts = ObservableList.of([]);
  final repository = Modular.get<ContactRepository>();

  @computed
  List<Contact> get contacts => _contacts;

  _ContactStore() {
    repository
        .findAll()
        .then((localContacts) => _contacts.insertAll(0, localContacts));
  }

  @action
  Future<void> insertContact(ContactInsertParams params) async {
    final maybeNewContact = await repository.insert(params);
    if (maybeNewContact != null) {
      _contacts.add(maybeNewContact);
    }
  }
}
