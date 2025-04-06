import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uptodo/ui/navbar.dart';
import 'package:uptodo/providers/task_provider.dart';
// import 'package:uptodo/views/home.dart';

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
          brightness: Brightness.dark,
          primaryColor: Colors.yellowAccent[700],
          colorScheme: ColorScheme.fromSwatch().copyWith(
              brightness: Brightness.dark,
              primary: Colors.yellowAccent[700],
              secondary: const Color.fromRGBO(45, 45, 45, 1)),
          textTheme: const TextTheme(
            bodySmall: TextStyle(color: Colors.white),
            bodyMedium: TextStyle(color: Colors.white),
            bodyLarge: TextStyle(color: Colors.white),
          ),
          scaffoldBackgroundColor: const Color.fromRGBO(10, 10, 10, 1),
          appBarTheme: const AppBarTheme(
              backgroundColor: Color.fromRGBO(10, 10, 10, 1),
              foregroundColor: Colors.white),
          // colorScheme: ColorScheme.fromSeed(seedColor: Colors.red, brightness: Brightness.dark),
          elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  foregroundColor: Colors.black)),
          useMaterial3: true,
        ),
        // home: const MyHomePage(title: 'Uptodo'),
        home: const Navbar(),
      ),
    );
  }
}
