import 'package:f_contact_ex/model/contact.dart';
import 'package:f_contact_ex/service/db_service.dart';

import '../contact_repository.dart';

class SQLiteContactRepository implements ContactRepository {
  late final DBService _dbService;

  set dbService(DBService service) => _dbService = service;

  @override
  Future<int?> insert({
    required String name,
    required String phone,
    required String email,
    String? photoName,
  }) {
    return Future.value(0);
  }

  Future<List<Contact>> findAll() {
    return Future.value([]);
  }

  Future<List<Contact>> findByName(String name) {
    return Future.value([]);
  }

  Future<void> update({
    required int id,
    String? name,
    String? phone,
    String? photoName,
  }) {
    return Future.value();
  }
}
