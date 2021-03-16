import 'package:f_contact_ex/model/contact.dart';

abstract class ContactRepository {
  Future<void> insert(Contact contact);
  Future<List<Contact>> findAll();
  Future<List<Contact>> findByName(String name);
  Future<void> update(Contact contact);
}
