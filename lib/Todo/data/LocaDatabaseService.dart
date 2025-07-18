import 'dart:ui';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todo_app/Todo/data/DataService.dart';
import 'package:todo_app/Todo/domain/model/Task.dart';

class LocalDatabaseService implements DataService {
  static Database? _db ;
  static final LocalDatabaseService instance = LocalDatabaseService._contructor();
  static final tableName = 'task';
  static final tableId = 'id';
  static final tableTitle = 'title';
  static final tableDescription = 'description';
  static final tableIsDone = 'isDone';
  static final tableCategory = 'category';
  static final tablePriority = 'priority';
  static final tableDate = 'date';

  LocalDatabaseService._contructor();


  Future<Database> get database async{
    if(_db!=null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  @override
  Future<Database> getDatabase() async {
    final databasDirpath = await getDatabasesPath();
    final databasePath = join(databasDirpath, 'todo_database.db');
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
        CREATE TABLE $tableName (
	$tableId INTEGER PRIMARY KEY AUTOINCREMENT,
	$tableTitle	TEXT NOT NULL,
	$tableIsDone	INTEGER DEFAULT 0,
	$tableCategory	TEXT,
	$tableDescription TEXT,
	$tablePriority	INTEGER,
	$tableDate	TEXT
)
        ''');
      },
    );
    return database;
  }

  @override
  Future<List<Task>?> getAllTask() async{
    try{
      final db =await database;
      final date =await db.query(tableName);
      print('my task data $date');
      return date.map((e) => Task.fromMap(e),).toList();
    }catch(e){
      print('error is $e');
    }
  }

  @override
  void addTask(Task task) async{
    final db =await database;
    try{
      db.insert(tableName, task.toMap());
    }catch(e){
      print('error is $e');
    }
  }

  @override
  void updateTask(Task task, int taskId) async{
    final db = await database;
    try{
      db.update(tableName, task.toMap() , where: '$tableId = ?' ,whereArgs: [taskId]);
      print('table upadre');
    }catch(e){
      print('error is $e');
    }
  }
}
