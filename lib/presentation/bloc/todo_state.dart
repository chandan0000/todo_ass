part of 'todo_bloc.dart';

class TodoState extends Equatable {
  final List<Todo> todos;

  const TodoState({this.todos = const []});

  TodoState copyWith({List<Todo>? todos}) {
    return TodoState(todos: todos ?? this.todos);
  }

  int get totalCount => todos.length;
  int get completedCount => todos.where((t) => t.isCompleted).length;
  int get pendingCount => totalCount - completedCount;

  @override
  List<Object?> get props => [todos];
}
