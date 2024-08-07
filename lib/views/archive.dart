import 'package:flutter/material.dart';
import 'package:uptodo/ui/task_list.dart';

class ArchivePage extends StatefulWidget {
  const ArchivePage({super.key});

  @override
  State<ArchivePage> createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
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
          children: <Widget>[
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
              height: 20.0,
            ),
            const Text(
              'Archive',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 20.0,
            ),
            const TaskList(isDone: true, justToday: false)
            // TaskList(isDone: true),
          ],
        ),
      ),
    );
  }
}
