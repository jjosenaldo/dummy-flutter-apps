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
            'CREATE TABLE $kTableName ($kIdColumnName INTEGER PRIMARY KEY AUTOINCREMENT, $kNameColumnName TEXT, $kPhoneColumnName TEXT, $kEmailColumnName TEXT, $kPhotoNameColumnName TEXT)',
          );
        },
        version: 3,
        onUpgrade: _onUpgrade,
      );
    } else {
      throw NullDatabasesPathException();
    }
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    if (oldVersion < newVersion) {
      db.execute("ALTER TABLE $kTableName ADD COLUMN $kEmailColumnName TEXT;");
    }
  }

  Future<int?> insert({
    required String tableName,
    required Map<String, dynamic> data,
  }) async {
    final database = await getDatabase();
    final insertedId = await database.insert(tableName, data);
    return insertedId == 0 ? null : insertedId;
  }

  Future<List<Map<String, dynamic>>> findAll({
    required String tableName,
  }) async {
    final database = await getDatabase();
    return database.query(tableName);
  }

  Future<void> updateByColumnEqualTo({
    required String tableName,
    required String columnName,
    required Object columnValue,
    required Map<String, dynamic> data,
  }) async {
    final database = await getDatabase();

    database.update(
      tableName,
      data,
      where: '$columnName = ?',
      whereArgs: [columnValue],
    );
  }

  Future<List<Map<String, dynamic>>> findByEqualTo({
    required String tableName,
    required String columnName,
    required Object columnValue,
  }) async {
    final database = await getDatabase();
    return database.query(
      tableName,
      where: '$columnName = ?',
      whereArgs: [columnValue],
    );
  }
}
