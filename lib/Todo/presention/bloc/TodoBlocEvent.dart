
import 'package:todo_app/Todo/domain/model/Task.dart' show Task;

sealed class TodoBlocEvent{}

final class AddTaskEvent extends TodoBlocEvent{
  final Task task;

  AddTaskEvent({required this.task});
}

final class FetchAllTask extends TodoBlocEvent{}
final class UpdateBlocEvent extends TodoBlocEvent{
  final Task task;
  UpdateBlocEvent({required this.task});
}
final class OnSearchTask extends TodoBlocEvent{
  final String text;
  final List<Task>  task;
  OnSearchTask(this.task, {required this.text});

}
