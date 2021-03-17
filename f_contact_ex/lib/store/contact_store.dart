import 'package:f_contact_ex/model/contact.dart';
import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

class ContactStore {
  final _contacts = Observable(ObservableList.of(<Contact>[]));
  final repository = Modular.get<ContactRepository>();

  List<Contact> get contacts => _contacts.value;

  Future<void> insertContact({
    required String name,
    required String phone,
    required String email,
    required String photoName,
  }) async =>
      Action(() async {
        final maybeNewContact = await repository.insert(
          name: name,
          phone: phone,
          email: email,
          photoName: photoName.isEmpty ? null : photoName,
        );
        if (maybeNewContact != null) {
          final oldContacts = _contacts.value;
          oldContacts.add(maybeNewContact);
          _contacts.value = oldContacts;
        }
      })();
}
