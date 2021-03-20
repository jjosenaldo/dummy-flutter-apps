import 'package:f_contact_ex/model/contact.dart';
import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'contacts_store.g.dart';

class ContactsStore = _ContactsStore with _$ContactsStore;

abstract class _ContactsStore with Store {
  ObservableList<Contact> _contacts = ObservableList.of([]);
  final repository = Modular.get<ContactRepository>();

  @computed
  List<Contact> get contacts => _contacts;

  _ContactsStore() {
    repository
        .findAll()
        .then((localContacts) => _contacts.insertAll(0, localContacts));
  }

  @action
  Future<void> updateContact(ContactUpdateByIdParams params) async {
    await repository.updateById(
      id: params.id,
      email: params.email,
      name: params.name,
      phone: params.phone,
      photoName: params.photoName,
    );
    final maybeEditedContact = await repository.findById(params.id);

    if (maybeEditedContact != null) {
      final editedContactIndex = _contacts.indexOf(maybeEditedContact);
      _contacts.replaceRange(
          editedContactIndex, editedContactIndex + 1, [maybeEditedContact]);
    }
  }

  @action
  Future<void> insertContact(ContactInsertParams params) async {
    final maybeNewContact = await repository.insert(params);
    if (maybeNewContact != null) {
      _contacts.add(maybeNewContact);
    }
  }

  Future<void> deleteContact(Contact contact) =>
      repository.deleteById(contact.id).then((deleted) {
        if (deleted) {
          _contacts.remove(contact);
        }
      });
}
