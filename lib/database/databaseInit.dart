 import 'package:adscoin/database/table.dart';
 import 'package:sqflite/sqflite.dart' as sqlite;
 import 'package:sqflite/sqflite.dart';
 import 'package:sqflite/sqlite_api.dart';
 import 'package:path/path.dart' as path;


 class DatabaseInit{
   static DatabaseInit _dbHelper = DatabaseInit._singleton();
   factory DatabaseInit() {
     return _dbHelper;
   }
   DatabaseInit._singleton();
   final tables = [
     ProductTable.CREATE_TABLE,
     UserTable.CREATE_TABLE,
     FavoriteTable.CREATE_TABLE
   ];
   Future<Database> openDB() async {
     final dbPath = await sqlite.getDatabasesPath();
     return sqlite.openDatabase(
       path.join(dbPath, 'adscoin.db'),
       onCreate: (db, version) {
         tables.forEach((table) async {
           await db.execute(table).then((value) {
             print("############################### created table $table");
           }).catchError((err) {
             print("errornya ${err.toString()}");
           });
         });
       },
       version: 1
     );
   }
   Future<bool> insert(String table, Map<String, Object> data) async {
     try{
       final db = await openDB();
       await db.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
       return true;
     }
     catch(_){
       return false;
     }
   }
   Future<List> getData(String tableName) async {
     final db = await openDB();
     var result = await db.rawQuery('SELECT * FROM $tableName');
     return result.toList();
   }
   Future<bool> update(String table,int id, Map<String, Object> data) async {
     try {
       final db = await openDB();
       await db.update(table, data, where: 'id = ?',whereArgs: [id],conflictAlgorithm: ConflictAlgorithm.replace);
       return true;
     }
     catch (_) {
       return false;
     }
   }
   Future<int> delete(String table) async {
     final db = await openDB();
     var result = await db.delete(table);
      print("DELETEEEEEEED $result");
     return result;
   }
   Future<List> getDetail(String tableName,String column,String id) async {
     final db = await openDB();
     var result = await db.rawQuery('SELECT * FROM $tableName WHERE $column=?',[id]);
     return result.toList();
   }
   Future<bool> deleteById(table,int id) async{
     try{
       final db = await openDB();
       await db.rawDelete('DELETE FROM $table WHERE id=?', [id]);
       return true;
     }
     catch(_){
       return false;
     }
   }







 }