
import 'package:fpdart/src/either.dart' as fpdart;
import 'package:todo_app/Todo/data/DataService.dart';
import 'package:todo_app/Todo/domain/model/Task.dart';
import 'package:todo_app/Todo/domain/repository/TodoRepository.dart';
import 'package:todo_app/core/Failure/Failure.dart';

 class TodoRepositoryImp implements TodoRepository{

   final DataService dataService;

  TodoRepositoryImp({required this.dataService});

  @override
  Future<fpdart.Either<Failure, void>> addTask(Task task) async{
   try{
    dataService.addTask(task);
    return fpdart.right(task);
   }catch(e){
    return fpdart.left(Failure(message: e.toString()));
   }
  }

  @override
  Future<fpdart.Either<Failure, List<Task>>> getAllTask() async{
   try{
    final list =  await dataService.getAllTask();
    if(list==null || list.isEmpty ){
     return fpdart.left(Failure(message: 'Task is empty'));
    }
    return fpdart.right(list);
   }catch(e){
    return fpdart.left(Failure(message: e.toString()));
   }
  }

  @override
  void updateTask(Task task, int taskId) {
    dataService.updateTask(task, taskId);
  }
}