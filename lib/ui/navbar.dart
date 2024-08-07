import 'package:flutter/material.dart';
import 'package:uptodo/views/archive.dart';
import 'package:uptodo/views/home.dart';
import 'package:uptodo/views/new_task.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final PageController _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void toggleSearch() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text(widget.title),
        scrolledUnderElevation: 0.0,
        actions: <Widget>[
          IconButton(
            onPressed: toggleSearch,
            icon: const Icon(Icons.search),
          ),
          IconButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("TODO: App settings... for now it deletes all data :)")));
                //Provider.of<TaskProvider>(context, listen: false).purgeAllData();
              },
              icon: const Icon(Icons.settings))
        ],
      ),
      extendBody: true,
      floatingActionButton: FloatingActionButton(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(50.0))),
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () async {
          await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const NewTask()));
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        height: 60,
        color: Colors.yellowAccent[700],
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.home,
                color: Colors.black,
              ),
              onPressed: () {
                _pageController.jumpToPage(0);
              },
            ),
            IconButton(
              icon: const Icon(Icons.done_all, color: Colors.black),
              onPressed: () {
                _pageController.jumpToPage(1);
              },
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: const <Widget>[MyHomePage(title: 'Uptodo'), ArchivePage()],
      ),
    );
  }
}
