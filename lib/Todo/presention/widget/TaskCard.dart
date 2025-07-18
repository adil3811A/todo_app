import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Todo/domain/model/Task.dart';

class Taskcard extends StatelessWidget {
  final Task task;
  final Function(Task) onTogale;

  const Taskcard({super.key, required this.task, required this.onTogale});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 12, right: 12),
              child: GestureDetector(
                onTap: () => onTogale(task),
                child: Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: task.isDone == 1 ? Colors.green : Colors.black,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  task.title,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Wrap(
                  spacing: 10,
                  runSpacing: 8,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    Text(
                      DateFormat('dd-MMM-yyyy').format(DateTime.parse(task.date)),
                      style: TextStyle(fontSize: 14),
                    ),
                    Chip(
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset('assets/${task.category}_Outline.png', height: 14),
                          SizedBox(width: 10),
                          Text(task.category),
                        ],
                      ),
                      backgroundColor: GetColorbaseOnCetegory(task.category),
                    ),
                    Chip(
                      side: BorderSide(color: Color(0xff8687E7), width: 2),
                      label: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.flag_outlined, size: 16),
                          SizedBox(width: 8),
                          Text(task.priority.toString()),
                        ],
                      ),
                    ),
                  ],
                )
                ,
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color GetColorbaseOnCetegory(String category) {
    switch (category) {
      case 'Grocery':
        return Color(0xffCCFF80);
      case 'Work':
        return Color(0xffFF9680);
      case 'Sport':
        return Color(0xff80FFFF);
      case 'Home':
        return Color(0xffFF8080);
      case 'University':
        return Color(0xff809CFF);
      case 'Social':
        return Color(0xffFF80EB);
      case 'Music':
        return Color(0xffFC80FF);
      case 'Health':
        return Color(0xff80FFA3);
      case 'Movie':
        return Color(0xff80D1FF);
      default:
        return Color(0xffCCFF80);
    }
  }
}
