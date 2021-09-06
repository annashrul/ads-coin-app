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
     ProductTable.CREATE_TABLE

   ];
   Future<Database> openDB() async {
     final dbPath = await sqlite.getDatabasesPath();
     return sqlite.openDatabase(path.join(dbPath, 'adscoin.db'),
         onCreate: (db, version) {
           tables.forEach((table) async {
             await db.execute(table).then((value) {
               print("############################### created table $table");
             }).catchError((err) {
               print("errornya ${err.toString()}");
             });
           });
         }, version: 1);
   }


}