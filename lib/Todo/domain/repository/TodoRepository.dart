import 'package:todo_app/Todo/domain/model/Task.dart';
import 'package:fpdart/fpdart.dart' as fpdat;
import 'package:todo_app/core/Failure/Failure.dart';

abstract interface class TodoRepository{
  Future<fpdat.Either<Failure , List<Task>>> getAllTask();
  Future<fpdat.Either<Failure  , void>> addTask(Task task);
  void updateTask(Task task , int taskId);
}