import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_provider_mvvm/view/todo_screen.dart';
import 'package:todo_provider_mvvm/viewmodel/theme_viewmodel.dart';
import 'package:todo_provider_mvvm/viewmodel/todo_viewmodel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TodoViewModel()),
        ChangeNotifierProvider(create: (_) => ThemeViewModel()),
      ],
      child: Consumer<ThemeViewModel>(
        builder: (context, themeViewModel, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'To-Do App',
            theme: themeViewModel.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: TodoScreen(),
          );
        },
      ),
    );
  }
}