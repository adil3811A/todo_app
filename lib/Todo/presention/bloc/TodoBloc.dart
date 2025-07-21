import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Todo/domain/model/Task.dart';
import 'package:todo_app/Todo/domain/repository/TodoRepository.dart';
import 'package:todo_app/Todo/presention/bloc/TodoBlocEvent.dart';
import 'TodoBlocState.dart';

class TodoBloc extends Bloc<TodoBlocEvent , TodoBlocState>{
  List<Task> list = [];
  final TodoRepository todoRepository;
  TodoBloc(this.todoRepository): super(TodoInitialState()){
    on<AddTaskEvent>((event, emit) async{
      final responce =await todoRepository.addTask(event.task);
      responce.fold((l) => emit(TodoFailure(message: l.message)), (r) => TodoAddSuccess(),);
    },);
    on<FetchAllTask>((event, emit) async{
      final responce = await todoRepository.getAllTask();
      responce.fold((l) => emit(TodoFailureHome(message: l.message)), (r) => emit(TodoAllTaskSuccess(tasks: r)),);
    },);
    on<UpdateBlocEvent>((event, emit) {
      final updatedTask = event.task.copyWith(
        isDone: event.task.isDone == 0 ? 1 :0
      );
      todoRepository.updateTask(updatedTask, event.task.id??0);
    },);
    on<OnSearchTask>((event, emit) {
      final list = event.task.where((task) => task.title.contains(event.text),).toList();
      emit(TodoAllTaskSuccess(tasks: list));
    },);
  }
}