import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/todo_viewmodel.dart';
import '../utils/styles.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodel/todo_viewmodel.dart';
import '../viewmodel/theme_viewmodel.dart';
import '../utils/styles.dart';

class TodoScreen extends StatelessWidget {
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoViewModel = Provider.of<TodoViewModel>(context);
    final themeViewModel = Provider.of<ThemeViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('To-Do List'),
        actions: [
          IconButton(
            icon: Icon(themeViewModel.isDarkMode ? Icons.light_mode : Icons.dark_mode),
            onPressed: () {
              themeViewModel.toggleTheme();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(
                labelText: 'Enter Task',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(8.0),
            child: TextField(
              controller: _descController,
              decoration: InputDecoration(
                labelText: 'Enter Task Desc',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                todoViewModel.addTodo(_controller.text,_descController.text);
                _controller.clear();
              }
            },
            child: Text('Add To-Do'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: todoViewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = todoViewModel.todos[index];
                return ListTile(
                  title: Text(
                    todo.title,
                    style: todo.isCompleted
                        ? Styles.completedTaskStyle
                        : Styles.taskStyle,
                  ),
                  leading: Checkbox(
                    value: todo.isCompleted,
                    onChanged: (value) =>
                        todoViewModel.toggleTodoStatus(todo.id),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          _showEditDialog(context, todoViewModel, todo.id);
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete, color: Colors.red),
                        onPressed: () => todoViewModel.deleteTodo(todo.id),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(BuildContext context, TodoViewModel viewModel, String id) {
    TextEditingController editController = TextEditingController();
    TextEditingController editDescController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit To-Do'),
        content: Column(
          children: [
            TextField(
              controller: editController,
              decoration: InputDecoration(hintText: 'New Task Name'),
            ),
            TextField(
              controller: editDescController,
              decoration: InputDecoration(hintText: 'New Task Desc'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              if (editController.text.isNotEmpty) {
                viewModel.editTodo(id, editController.text,editDescController.text);
                Navigator.pop(context);
              }
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }
}
