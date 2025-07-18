

 import 'package:sqflite/sqflite.dart';
import 'package:todo_app/Todo/domain/model/Task.dart';

abstract interface class DataService{
  Future<Database> getDatabase();
  Future<List<Task>?> getAllTask();
  void addTask(Task task);
  void updateTask(Task task ,int taskId);
 }