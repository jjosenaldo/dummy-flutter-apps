import 'package:f_contact_ex/exception/null_databases_path_exception.dart';
import 'package:f_contact_ex/repository/impl/contact_db_config.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

export 'package:f_contact_ex/repository/impl/contact_db_config.dart';

const _kDatabaseName = 'contacts.db';

class DBService {
  DBService._();
  factory DBService() {
    if (_instance == null) {
      _instance = DBService._();
    }

    return _instance!;
  }

  static DBService? _instance;
  Database? _database;

  Future<Database> getDatabase() async {
    if (_database == null) {
      _database = await _open();
    }

    return _database!;
  }

  Future<Database> _open() async {
    final maybeDatabasesPath = await getDatabasesPath();

    if (maybeDatabasesPath != null) {
      return openDatabase(
        join(maybeDatabasesPath, _kDatabaseName),
        onCreate: (db, version) async {
          await db.execute(
            'CREATE TABLE $kTableName ($kIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT, $kNameColumnName TEXT, $kPhoneColumnName TEXT, $kPhotoNameColumnName TEXT)',
          );
        },
        version: 1,
      );
    } else {
      throw NullDatabasesPathException();
    }
  }
}
