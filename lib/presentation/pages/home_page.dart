import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_ass/presentation/bloc/todo_bloc.dart';
import 'package:todo_ass/presentation/widgets/todo_input.dart';
import 'package:todo_ass/presentation/widgets/todo_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Tasks'),
      ),
      body: Column(
        children: [
          const TodoInput(),
          Expanded(child: _buildTodoList()),
        ],
      ),
    );
  }

  Widget _buildTodoList() {
    return BlocBuilder<TodoBloc, TodoState>(
      builder: (context, state) {
        if (state.todos.isEmpty) {
          return _buildEmptyState(context);
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: state.todos.length,
          itemBuilder: (_, i) => TodoTile(todo: state.todos[i]),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.task_alt,
            size: 80,
            color: Theme.of(context).colorScheme.outlineVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No tasks yet',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Add a new task to get started',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
