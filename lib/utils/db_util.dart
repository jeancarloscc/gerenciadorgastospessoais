import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DbUtil {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(
      path.join(dbPath, 'gerenciador_gastos.db'),
      onCreate: (db, version) {
        _createDb(db);
      },
      version: 1
    );
  }

  static void _createDb(sql.Database db){
    db.execute(""" 
    CREATE TABLE conta (id INTEGER PRIMARY KEY AUTOINCREMENT,
    titulo VARCHAR(50), saldo REAL)
     """);
  }

  static Future<void> insertData(String table, Map<String, Object?> dados) async {
    final db = await DbUtil.database();
    await db.insert(table, dados,
    conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DbUtil.database();
    return db.query(table);
  }
}