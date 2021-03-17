import 'package:f_contact_ex/model/contact.dart';

abstract class ContactRepository {
  Future<Contact?> insert({
    required String name,
    required String phone,
    required String email,
    String? photoName,
  });

  Future<List<Contact>> findAll();

  Future<List<Contact>> findByName(String name);

  Future<void> update({
    required int id,
    required String name,
    required String phone,
    String? photoName,
  });
}
