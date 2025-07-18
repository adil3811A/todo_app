import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Todo/domain/model/Task.dart';
import 'package:todo_app/Todo/presention/bloc/TodoBloc.dart';
import 'package:todo_app/Todo/presention/bloc/TodoBlocEvent.dart';
import 'package:todo_app/Todo/presention/bloc/TodoBlocState.dart';


class Addtaskpage extends StatefulWidget {
  const Addtaskpage({super.key});

  @override
  State<Addtaskpage> createState() => _AddtaskpageState();
}

class _AddtaskpageState extends State<Addtaskpage> {
  static List<String> CategoryImage = [
    'assets/Grocery_image.png',
    'assets/Work_image.png',
    'assets/Sport_image.png',
    'assets/Home_image.png',
    'assets/University_image.png',
    'assets/Social_image.png',
    'assets/Music_image.png',
    'assets/Health_image.png',
    'assets/Movie_image.png'
  ];
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime currentDateTime = DateTime.now();
  String selectedCategory = 'University';
  int priority = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Image.asset('assets/Close.png'),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: BlocConsumer<TodoBloc , TodoBlocState>(
          listener: (context, state) {
            if(state is TodoAddSuccess){
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            if(state is TodoFailure){
              return Center(child: Text(state.message),);
            }
            if(state is TodoLoadingState){
              return CircularProgressIndicator();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Title'),
                SizedBox(height: 10,),
                TextField(
                  controller: titleController,
                  decoration: InputDecoration(
                      hintText: 'Enter Task title'
                  ),
                ),
                SizedBox(height: 20,),
                Text('Description'),
                SizedBox(height: 10,),
                TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                      hintText: 'Enter Task description'
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.access_time),
                    SizedBox(width: 10,),
                    Text('Task Date : '),
                    Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () async{
                        final selectedDate = await showDatePicker(context: context, firstDate: DateTime(2000), lastDate: DateTime(2100));
                        if(selectedDate==null) return;
                        setState(() {
                          currentDateTime = selectedDate;
                        });
                      },
                      child: Chip(
                        label: Text(DateFormat('dd-MMM-yyyy').format(currentDateTime)),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.local_offer_outlined),
                    SizedBox(width: 10,),
                    Text('Task Category : '),
                    Expanded(child: SizedBox()),
                    GestureDetector(
                        onTap: () {
                          showDialog(context: context, builder: (context) {
                            return  AlertDialog(
                              title: Text('Choose Category',textAlign: TextAlign.center),
                              content:SizedBox(
                                width: double.maxFinite,
                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: const EdgeInsets.all(12.0),
                                    child: Column(
                                      children: [
                                        Container(height: 1,width: double.maxFinite,color: Colors.white,),
                                        SizedBox(height: 20,),
                                        GridView.builder(
                                          shrinkWrap: true,
                                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                                              childAspectRatio: 0.7,
                                              crossAxisCount: 3
                                          ), itemBuilder: (context, index) {
                                          return GestureDetector(
                                              onTap: () {
                                                final categotyWithAssets = CategoryImage[index].split('_');
                                                final categoty = categotyWithAssets.first.split('/');
                                                setState(() {
                                                  selectedCategory = categoty.last;
                                                  Navigator.pop(context);
                                                });
                                              },
                                              child: Padding(
                                                padding: const EdgeInsets.only(bottom: 18),
                                                child: Image.asset(CategoryImage[index]),
                                              )
                                          );
                                        },itemCount: CategoryImage.length,),
                                        SizedBox(
                                          width: double.maxFinite,
                                          child: OutlinedButton(onPressed: () {
                                          }, child: Padding(
                                            padding: const EdgeInsets.only(top: 12 , bottom: 12),
                                            child: Text('Add Category'),
                                          )),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            );

                          },);
                        },
                        child: Chip(label: Row(
                          children: [
                            Image.asset('assets/${selectedCategory}_Outline.png', height: 30,),
                            SizedBox(width: 10,),
                            Text(selectedCategory)
                          ],
                        ))),
                  ],
                ),
                SizedBox(height: 20,),
                Row(
                  children: [
                    Icon(Icons.flag_outlined),
                    SizedBox(width: 10,),
                    Text('Task Priority :'),
                    Expanded(child: SizedBox()),
                    GestureDetector(
                      onTap: () {
                        if(priority<5){
                          setState(() {
                            priority++;
                          });
                        }else{
                          setState(() {
                            priority= 1;
                          });
                        }
                      },
                      child: Chip(label: Row(
                        children: [
                          Row(children: [
                            Icon(Icons.flag),
                            SizedBox(width: 10,),
                            Text(priority.toString())
                          ],),
                        ],
                      )),
                    ),
                  ],
                ),
                Expanded(child: SizedBox()),
                Container(
                  width: double.infinity,
                  child: OutlinedButton(
                      onPressed: () async{
                        context.read<TodoBloc>().add(AddTaskEvent(task: Task(title: titleController.text, description: descriptionController.text, category: selectedCategory, date: currentDateTime.toIso8601String(), priority: priority, isDone: 0, id: null)));
                        context.read<TodoBloc>().add(FetchAllTask());
                        Navigator.pop(context);
                      }, child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      "Add Task",
                      style: TextStyle(fontSize: 18),
                    ),
                  )),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
