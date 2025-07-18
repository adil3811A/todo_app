import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Todo/presention/bloc/TodoBloc.dart';
import 'package:todo_app/Todo/presention/pages/Homepage.dart';
import 'package:todo_app/core/theme/TodoTheme.dart';
import 'package:todo_app/init_dependency.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initDependency();
  runApp(BlocProvider(
    create: (context) => serviceLocator<TodoBloc>(),
      child: const MyApp())
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme:TodoTheme.MyTheme,
      home: const Homepage(),
    );
  }
}

