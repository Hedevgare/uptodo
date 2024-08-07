import 'package:flutter/material.dart';
import 'package:uptodo/ui/navbar.dart';
import 'package:uptodo/ui/task_list.dart';
import 'package:uptodo/views/new_task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController controller;
  bool showSearch = false;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  // void toggleSearch() {
  //   setState(() {
  //     showSearch = !showSearch;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20.0, 0, 20.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedSwitcher(duration: const Duration(milliseconds: 150),
            transitionBuilder: (Widget child, Animation<double> animation) {
              return SlideTransition(position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: const Offset(0, 0)
              ).animate(animation),
              child: child);
            }, child: showSearch ? TextField(
                controller: controller,
                decoration: const InputDecoration(
                    hintText: "Search tasks",
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(50.0)))),
                onTapOutside: (e) => FocusScope.of(context).unfocus(),
              ) : const SizedBox.shrink(),),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Tasks",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const TaskList(
              isDone: false,
              justToday: false,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "Completed Today",
              style: TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            const TaskList(
              isDone: true,
              justToday: true,
            ),
          ],
        ),
      ),
      // floatingActionButton: FloatingActionButton(
      //   backgroundColor: Theme.of(context).primaryColor,
      //   foregroundColor: Colors.black,
      //   onPressed: () async {
      //     await Navigator.push(context,
      //         MaterialPageRoute(builder: (context) => const NewTask()));
      //   },
      //   tooltip: 'New task',
      //   child: const Icon(Icons.add),
      // ),
    );
  }
}
