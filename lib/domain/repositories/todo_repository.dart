import 'package:todo_ass/domain/entities/todo.dart';

abstract class TodoRepository {
  List<Todo> getAllTodos();
  void addTodo(Todo todo);
  void updateTodo(Todo todo);
  void deleteTodo(String id);
}
