import 'ln.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseProvider {
  static const String TABLE_LN = "ln";
  static const String COLUMN_ID = "id";
  static const String COLUMN_SCHNAME = "schname";
  static const String COLUMN_TYPE = "type";
  static const String COLUMN_AMOUNT = "amount";
  static const String COLUMN_AMOUNT2 = "amount2";
  static const String COLUMN_YEAR = "year";
  static const String COLUMN_DATE = "date";

  static const String COLUMN_MATURED = "isMatured";

  DatabaseProvider._();
  static final DatabaseProvider db = DatabaseProvider._();

  Database _database;

  Future<Database> get database async {
    print("database getter called");

    if (_database != null) {
      return _database;
    }

    _database = await createDatabase();

    return _database;
  }

  Future<Database> createDatabase() async {
    String dbPath = await getDatabasesPath();

    return await openDatabase(
      join(dbPath, 'hi2.db'),
      version: 1,
      onCreate: (Database database, int version) async {
        print("Creating ln table");

        await database.execute(
          "CREATE TABLE $TABLE_LN ("
              "$COLUMN_ID INTEGER PRIMARY KEY,"
              "$COLUMN_SCHNAME TEXT,"
              "$COLUMN_TYPE TEXT,"
              "$COLUMN_AMOUNT TEXT,"
              "$COLUMN_AMOUNT2 TEXT,"
              "$COLUMN_YEAR TEXT,"
              "$COLUMN_DATE TEXT,"
              "$COLUMN_MATURED INTEGER"
              ")",
        );
      },
    );
  }

  Future<List<Ln>> getLns() async {
    final db = await database;

    var lns = await db
        .query(TABLE_LN, columns: [COLUMN_ID, COLUMN_SCHNAME, COLUMN_TYPE, COLUMN_AMOUNT,COLUMN_AMOUNT2, COLUMN_DATE, COLUMN_MATURED]);

    List<Ln> lnList = List<Ln>();

    lns.forEach((currentLn) {
      Ln ln = Ln.fromMap(currentLn);

      lnList.add(ln);
    });

    return lnList;
  }

  Future<Ln> insert(Ln ln) async {
    final db = await database;
    ln.id = await db.insert(TABLE_LN, ln.toMap());
    return ln;
  }

  Future<int> delete(int id) async {
    final db = await database;

    return await db.delete(
      TABLE_LN,
      where: "id = ?",
      whereArgs: [id],
    );
  }

  Future<int> update(Ln ln) async {
    final db = await database;

    return await db.update(
      TABLE_LN,
      ln.toMap(),
      where: "id = ?",
      whereArgs: [ln.id],
    );
  }
}