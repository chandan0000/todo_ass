import 'package:todo_ass/domain/entities/todo.dart';
import 'package:todo_ass/domain/repositories/todo_repository.dart';

class LocalTodoRepository implements TodoRepository {
  final List<Todo> _todos = [];

  @override
  List<Todo> getAllTodos() => List.unmodifiable(_todos);

  @override
  void addTodo(Todo todo) {
    _todos.add(todo);
  }

  @override
  void updateTodo(Todo todo) {
    final index = _todos.indexWhere((t) => t.id == todo.id);
    if (index != -1) {
      _todos[index] = todo;
    }
  }

  @override
  void deleteTodo(String id) {
    _todos.removeWhere((t) => t.id == id);
  }
}
