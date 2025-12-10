import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_ass/domain/entities/todo.dart';
import 'package:todo_ass/domain/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository _repository;

  TodoBloc({required TodoRepository repository})
      : _repository = repository,
        super(const TodoState()) {
    on<AddTodo>(_handleAdd);
    on<UpdateTodo>(_handleUpdate);
    on<DeleteTodo>(_handleDelete);
    on<ToggleTodo>(_handleToggle);
  }

  void _handleAdd(AddTodo event, Emitter<TodoState> emit) {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: event.title,
      createdAt: DateTime.now(),
    );
    _repository.addTodo(todo);
    emit(state.copyWith(todos: _repository.getAllTodos()));
  }

  void _handleUpdate(UpdateTodo event, Emitter<TodoState> emit) {
    final existing = state.todos.firstWhere((t) => t.id == event.id);
    final updated = existing.copyWith(title: event.title);
    _repository.updateTodo(updated);
    emit(state.copyWith(todos: _repository.getAllTodos()));
  }

  void _handleDelete(DeleteTodo event, Emitter<TodoState> emit) {
    _repository.deleteTodo(event.id);
    emit(state.copyWith(todos: _repository.getAllTodos()));
  }

  void _handleToggle(ToggleTodo event, Emitter<TodoState> emit) {
    final existing = state.todos.firstWhere((t) => t.id == event.id);
    final toggled = existing.copyWith(isCompleted: !existing.isCompleted);
    _repository.updateTodo(toggled);
    emit(state.copyWith(todos: _repository.getAllTodos()));
  }
}
