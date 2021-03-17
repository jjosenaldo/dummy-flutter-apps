import 'package:f_contact_ex/model/contact.dart';
import 'package:f_contact_ex/repository/contact_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

part 'contact_store.g.dart';

class ContactStore = _ContactStore with _$ContactStore;

abstract class _ContactStore with Store {
  final ObservableList<Contact> contacts = ObservableList.of(<Contact>[]);
  final repository = Modular.get<ContactRepository>();

  @action
  Future<void> insertContact({
    required String name,
    required String phone,
    required String email,
    required String photoName,
  }) async {
    final newContact = await repository.insert(
      name: name,
      phone: phone,
      email: email,
      photoName: photoName.isEmpty ? null : photoName,
    );
    contacts.add(newContact);
  }
}
