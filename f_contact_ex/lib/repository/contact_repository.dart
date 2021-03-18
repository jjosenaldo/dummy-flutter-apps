import 'package:f_contact_ex/model/contact.dart';

class ContactInsertParams {
  ContactInsertParams({
    required this.name,
    required this.phone,
    required this.email,
    this.photoName,
  });

  final String name;
  final String phone;
  final String email;
  String? photoName;
}

abstract class ContactRepository {
  Future<Contact?> insert(ContactInsertParams params);

  Future<List<Contact>> findAll();

  Future<List<Contact>> findByName(String name);

  Future<void> update({
    required int id,
    required String name,
    required String phone,
    String? photoName,
  });
}
