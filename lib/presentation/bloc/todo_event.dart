part of 'todo_bloc.dart';

sealed class TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  AddTodo(this.title);
}

class UpdateTodo extends TodoEvent {
  final String id;
  final String title;
  UpdateTodo(this.id, this.title);
}

class DeleteTodo extends TodoEvent {
  final String id;
  DeleteTodo(this.id);
}

class ToggleTodo extends TodoEvent {
  final String id;
  ToggleTodo(this.id);
}
