import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:qr_reader_app/src/models/scan_model.dart';


class DBProvider {
  // Singleton pattern for database provider
  static Database _database;
  static final DBProvider db = DBProvider._();

  DBProvider._();

  Future<Database> get database  async {
    if (_database != null) return _database;

    _database = await  initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory  = await getApplicationDocumentsDirectory();
    
    String path = join(documentsDirectory.path, 'ScanDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      // DB init
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Scans ('
          'id INTEGER PRIMARY KEY,'
          'type TEXT,'
          'value TEXT '
          ')'
        );
      }
    );
  }

  // Create Registers
  newScanRaw(ScanModel newScan) async {
    final db = await database;

    final res = await db.rawInsert(
      "INSERT INTO Scans (id, type, value) "
      "VALUES ( ${newScan.id}, '${newScan.type}', '${newScan.value}')"
    );

    return res;

  }

  newScan(ScanModel newScan) async {
    final db = await database;

    final res = await db.insert('Scans', newScan.toJson());

    return res;
  }


  // Select Info
  Future<ScanModel> getScanID(int id) async {
    final db = await database;

    final res = await db.query('Scans', where: 'id =  ?', whereArgs: [id]);

    return res.isNotEmpty ? ScanModel.fromJson(res.first) : null;
  }

  Future<List<ScanModel>> getAllScans() async {
    final db = await database;

    final res = await db.query('Scans');

    List<ScanModel> list = res.isNotEmpty
     ? res.map((e) => ScanModel.fromJson(e)).toList()
     : [];

    return list;
  }

    Future<List<ScanModel>> getAllScansByType(String type) async {
    final db = await database;

    final res = await db.query('Scans', where: 'type =  ?', whereArgs: [type]);

    List<ScanModel> list = res.isNotEmpty
     ? res.map((e) => ScanModel.fromJson(e)).toList()
     : [];

    return list;
  }

}