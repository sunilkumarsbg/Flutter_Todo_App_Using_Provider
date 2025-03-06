import 'package:flutter/material.dart';
import '../model/todo.dart';
import 'dart:math';

class TodoViewModel extends ChangeNotifier {
  List<Todo> _todos = [];

  List<Todo> get todos => _todos;

  void addTodo(String title,String desc) {
    _todos.add(Todo(id: Random().nextInt(10000).toString(), title: title,description: desc));
    notifyListeners();
  }

  void toggleTodoStatus(String id) {
    final todo = _todos.firstWhere((element) => element.id == id);
    todo.isCompleted = !todo.isCompleted;
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todos.removeWhere((element) => element.id == id);
    notifyListeners();
  }

  void editTodo(String id, String newTitle, String desc) {
    final todo = _todos.firstWhere((element) => element.id == id);
    todo.title = newTitle;
    todo.description = desc;
    notifyListeners();
  }
}