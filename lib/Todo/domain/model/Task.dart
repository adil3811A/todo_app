
class Task{
  final String title,description , category, date;
   final int priority , isDone;
  final int? id ;

  Task({required this.title, required this.description, required this.category, required this.date, required this.priority, required this.isDone, required this.id});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'category': category,
      'date': date,
      'priority': priority,
      'isDone': isDone,
    };
  }
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      description: map['description'],
      category: map['category'],
      date: map['date'],
      priority: map['priority'],
      isDone: map['isDone'],
    );
  }

  Task copyWith({
    String? title,
    String? description,
    String? category,
    String? date,
    int? priority,
    int? isDone,
    int? id,
  }) {
    return Task(
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      date: date ?? this.date,
      priority: priority ?? this.priority,
      isDone: isDone ?? this.isDone,
      id: id ?? this.id,
    );
  }
}