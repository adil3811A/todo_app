import 'package:get_it/get_it.dart';
import 'package:todo_app/Todo/data/DataService.dart';
import 'package:todo_app/Todo/data/LocaDatabaseService.dart';
import 'package:todo_app/Todo/domain/repository/TodoRepository.dart';
import 'package:todo_app/Todo/domain/repository/TodoRepositoryImp.dart';
import 'package:todo_app/Todo/presention/bloc/TodoBloc.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependency() async{
  serviceLocator.registerLazySingleton<DataService>(() => LocalDatabaseService.instance,);
  serviceLocator.registerFactory<TodoRepository>(() => TodoRepositoryImp(dataService: serviceLocator()),);
  serviceLocator.registerFactory(() => TodoBloc(serviceLocator()),);
}