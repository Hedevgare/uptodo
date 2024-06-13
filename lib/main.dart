import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/providers/task_provider.dart';
import 'package:uptodo/views/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'Uptodo',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(primary: Colors.blue),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white, foregroundColor: Colors.black)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'Uptodo'),
      ),
    );
  }
}
