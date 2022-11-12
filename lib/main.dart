import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home/home.dart';

void main() async {
  await Hive.initFlutter();

  await Hive.openBox("items");

  runApp(const ToDoListApp());
}

class ToDoListApp extends StatelessWidget {
  const ToDoListApp({super.key}); 

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: "/",
      title: 'To Do List',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Home(),
    );
  }
}
