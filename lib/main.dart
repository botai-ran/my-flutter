
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/tabPage/tab_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '我的Flutter项目',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: const TabPage(),
    );
  }
}

