import 'package:f_contact_ex/model/contact.dart';

class ContactUpdateByIdParams {
  ContactUpdateByIdParams({
    required this.id,
    this.name,
    this.phone,
    this.photoName,
    this.email,
  });

  final int id;
  final String? name;
  final String? phone;
  final String? photoName;
  final String? email;
}

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

  Future<Contact?> findById(int id);

  Future<void> updateById({
    required int id,
    String? name,
    String? phone,
    String? photoName,
    String? email,
  });
}
