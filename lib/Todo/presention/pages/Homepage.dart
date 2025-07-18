import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/Todo/presention/bloc/TodoBloc.dart';
import 'package:todo_app/Todo/presention/bloc/TodoBlocEvent.dart';
import 'package:todo_app/Todo/presention/bloc/TodoBlocState.dart';
import 'package:todo_app/Todo/presention/pages/AddTaskPage.dart';
import 'package:todo_app/Todo/presention/widget/EmptyScreen.dart';
import 'package:todo_app/Todo/presention/widget/TaskCard.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {

  final searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    context.read<TodoBloc>().add(FetchAllTask());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Tasks", textAlign: TextAlign.center,)),
      ),
      floatingActionButton: FloatingActionButton(
        child:const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => Addtaskpage(),));
      },),
      body: BlocConsumer<TodoBloc, TodoBlocState>(
          builder: (context, state) {
            if(state is TodoFailureHome){
              return Emptyscreen();
            }
            if(state is TodoLoadingState){
              return Center(child: CircularProgressIndicator(),);
            }
            if(state is TodoAllTaskSuccess){
              print(state.tasks.length);
              return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        context.read<TodoBloc>().add(OnSearchTask(state.tasks, text: value));
                      },
                      controller: searchController,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.search),
                        hintText: 'Search for your task...'
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(itemBuilder: (context, index) {
                        return Taskcard(task: state.tasks[index],onTogale: (p0) {
                          context.read<TodoBloc>().add(UpdateBlocEvent(task: p0));
                          context.read<TodoBloc>().add(FetchAllTask());
                        },);
                      },itemCount: state.tasks.length,),
                    ),
                  ],
                ),
              );
            }
            return Emptyscreen();
          },
          listener: (context, state) {
          },
      ),
    );
  }
}
