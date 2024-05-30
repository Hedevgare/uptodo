import 'package:flutter/material.dart';
import 'package:uptodo/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Uptodo',
      theme: ThemeData(
        colorScheme: const ColorScheme.light(primary: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Uptodo'),
    );
  }
}