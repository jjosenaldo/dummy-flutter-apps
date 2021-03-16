import 'package:f_contact_ex/model/contact.dart';

abstract class ContactRepository {
  Future<int?> insert({
    required String name,
    required String phone,
    required String email,
    String photoName,
  });

  Future<List<Contact>> findAll();

  Future<List<Contact>> findByName(String name);

  Future<void> update({
    required int id,
    String name,
    String phone,
    String photoName,
  });
}
