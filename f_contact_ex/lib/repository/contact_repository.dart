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

  Future<void> updateById({
    required int id,
    String? name,
    String? phone,
    String? photoName,
    String? email,
  });
}
