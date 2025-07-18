
import 'package:todo_app/Todo/domain/model/Task.dart';

sealed class TodoBlocState{}

final class TodoInitialState  extends TodoBlocState{}
final class TodoLoadingState  extends TodoBlocState{}

final class TodoAllTaskSuccess extends TodoBlocState{
  final List<Task> tasks ;
  TodoAllTaskSuccess({required this.tasks});
}

final class TodoFailure extends TodoBlocState{
  final String message;

  TodoFailure({required this.message});
}

final class TodoFailureHome extends TodoBlocState{
  final String message;

  TodoFailureHome({required this.message});
}
final class TodoAddSuccess extends TodoBlocState{}

