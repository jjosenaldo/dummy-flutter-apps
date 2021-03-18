import 'package:f_contact_ex/model/contact.dart';
import 'package:f_contact_ex/service/db_service.dart';

import '../contact_repository.dart';

class SQLiteContactRepository implements ContactRepository {
  late final DBService _dbService;

  SQLiteContactRepository({
    required DBService service,
  }) {
    _dbService = service;
  }

  @override
  Future<Contact?> insert(ContactInsertParams params) async {
    final insertedId = await _dbService.insert(
      tableName: kTableName,
      data: buildDatabaseInsertJson(
        email: params.email,
        name: params.name,
        phone: params.phone,
        photoName: params.photoName,
      ),
    );

    return insertedId == null
        ? null
        : Contact(
            id: insertedId,
            name: params.name,
            email: params.email,
            phone: params.phone);
  }

  Future<List<Contact>> findAll() async {
    final jsons = await _dbService.findAll(tableName: kTableName);
    return jsons
        .map((contactJson) => buildContactFromQueryJson(contactJson))
        .toList();
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
