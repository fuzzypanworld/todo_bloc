import 'package:isar/isar.dart';
import 'package:todo_bloc/todo.dart';

part 'isar_todo.g.dart';

@collection
class TodoIsar {
  Id id = Isar.autoIncrement; // Automatically incrementing ID
  late String text;
  late bool isCompleted;

  // Named constructor to directly initialize fields
  TodoIsar({
    required this.id,
    required this.text,
    required this.isCompleted,
  });

  // Convert Isar model to domain model
  Todo toDomain() {
    return Todo(
      id: id,
      text: text,
      isCompleted: isCompleted,
    );
  }

  // Factory constructor to convert from domain model to Isar model
  factory TodoIsar.fromDomain(Todo todo) {
    return TodoIsar(
      id: todo.id,
      text: todo.text,
      isCompleted: todo.isCompleted,
    );
  }
}
