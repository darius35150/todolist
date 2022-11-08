import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'home/home.dart';
import 'package:responsive_framework/responsive_framework.dart';

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
      builder: ((context, child) => ResponsiveWrapper.builder(
        child,
        maxWidth: 2000,
        minWidth: 600,
        defaultScale: true,
        breakpoints: [
          ResponsiveBreakpoint.resize(750, name: MOBILE),
          ResponsiveBreakpoint.autoScale(800, name: TABLET),
          ResponsiveBreakpoint.resize(1000, name: DESKTOP)
        ],
      )),
      initialRoute: "/",
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: Home(),
    );
  }
}
