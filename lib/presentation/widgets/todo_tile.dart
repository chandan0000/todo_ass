import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_ass/domain/entities/todo.dart';
import 'package:todo_ass/presentation/bloc/todo_bloc.dart';

class TodoTile extends StatelessWidget {
  final Todo todo;

  const TodoTile({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(todo.id),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => context.read<TodoBloc>().add(DeleteTodo(todo.id)),
      background: _buildDismissBackground(context),
      child: GestureDetector(
        onDoubleTap: () => _showEditSheet(context),
        child: _buildTile(context),
      ),
    );
  }

  Widget _buildDismissBackground(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.error,
        borderRadius: BorderRadius.circular(16),
      ),
      alignment: Alignment.centerRight,
      padding: const EdgeInsets.only(right: 24),
      child: const Icon(Icons.delete_outline, color: Colors.white, size: 28),
    );
  }

  Widget _buildTile(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: todo.isCompleted
            ? colorScheme.surfaceContainerHighest
            : colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colorScheme.outlineVariant),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        leading: _buildCheckbox(context),
        title: _buildTitle(context),
        trailing: _buildActions(context),
      ),
    );
  }

  Widget _buildCheckbox(BuildContext context) {
    return GestureDetector(
      onTap: () => context.read<TodoBloc>().add(ToggleTodo(todo.id)),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 28,
        height: 28,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: todo.isCompleted
              ? Theme.of(context).colorScheme.primary
              : Colors.transparent,
          border: Border.all(
            color: todo.isCompleted
                ? Colors.transparent
                : Theme.of(context).colorScheme.outline,
            width: 2,
          ),
        ),
        child: todo.isCompleted
            ? Icon(Icons.check, color: Theme.of(context).colorScheme.onPrimary, size: 18)
            : null,
      ),
    );
  }

  Widget _buildTitle(BuildContext context) {
    return Text(
      todo.title,
      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
        decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
      ),
    );
  }

  Widget _buildActions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          onPressed: () => _showEditSheet(context),
          icon: const Icon(Icons.edit_outlined, size: 20),
        ),
        IconButton(
          onPressed: () => context.read<TodoBloc>().add(DeleteTodo(todo.id)),
          icon: const Icon(Icons.close, size: 20),
        ),
      ],
    );
  }

  void _showEditSheet(BuildContext context) {
    final controller = TextEditingController(text: todo.title);
    final bloc = context.read<TodoBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          top: 20,
          bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text('Edit Task', style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: () {
                final newTitle = controller.text.trim();
                if (newTitle.isNotEmpty && newTitle != todo.title) {
                  bloc.add(UpdateTodo(todo.id, newTitle));
                }
                Navigator.pop(ctx);
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
