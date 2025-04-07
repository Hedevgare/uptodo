import 'package:flutter/material.dart';
import 'package:uptodo/views/archive.dart';
import 'package:uptodo/views/calendar.dart';
import 'package:uptodo/views/home.dart';
import 'package:uptodo/views/new_task.dart';
import 'package:uptodo/views/timer.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void changePage(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text(
                        "TODO: App settings... for now it deletes all data :)")));
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
        child: const Icon(Icons.add, size: 30),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        height: 60,
        color: Colors.yellowAccent[700],
        shape: const CircularNotchedRectangle(),
        notchMargin: 5,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: _selectedIndex == 0
                      ? Theme.of(context).appBarTheme.backgroundColor
                      : Colors.yellowAccent[700],
                  borderRadius: const BorderRadius.all(Radius.circular(50.0))),
              child: IconButton(
                icon: Icon(Icons.done_all,
                    size: 30,
                    color: _selectedIndex == 0 ? Colors.white : Colors.black),
                onPressed: () {
                  changePage(0);
                  _pageController.jumpToPage(0);
                },
              ),
            ),
            // AnimatedContainer(
            //   duration: const Duration(milliseconds: 400),
            //   curve: Curves.easeInOut,
            //   padding: const EdgeInsets.symmetric(horizontal: 8),
            //   decoration: BoxDecoration(
            //       color: _selectedIndex == 1
            //           ? Theme.of(context).appBarTheme.backgroundColor
            //           : Colors.yellowAccent[700],
            //       borderRadius: const BorderRadius.all(Radius.circular(50.0))),
            //   child: IconButton(
            //     icon: Icon(Icons.calendar_month_outlined,
            //         size: 30,
            //         color: _selectedIndex == 1 ? Colors.white : Colors.black),
            //     onPressed: () {
            //       changePage(1);
            //       _pageController.jumpToPage(1);
            //     },
            //   ),
            // ),
            const SizedBox(
              width: 50,
            ),
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: _selectedIndex == 1
                      ? Theme.of(context).appBarTheme.backgroundColor
                      : Colors.yellowAccent[700],
                  borderRadius: const BorderRadius.all(Radius.circular(50.0))),
              child: IconButton(
                icon: Icon(Icons.archive_outlined,
                    size: 30,
                    color: _selectedIndex == 1 ? Colors.white : Colors.black),
                onPressed: () {
                  changePage(2);
                  _pageController.jumpToPage(1);
                },
              ),
            ),
            // AnimatedContainer(
            //   duration: const Duration(milliseconds: 400),
            //   curve: Curves.easeInOut,
            //   padding: const EdgeInsets.symmetric(horizontal: 8),
            //   decoration: BoxDecoration(
            //       color: _selectedIndex == 3
            //           ? Theme.of(context).appBarTheme.backgroundColor
            //           : Colors.yellowAccent[700],
            //       borderRadius: const BorderRadius.all(Radius.circular(50.0))),
            //   child: IconButton(
            //     icon: Icon(Icons.timer_outlined,
            //         size: 30,
            //         color: _selectedIndex == 3 ? Colors.white : Colors.black),
            //     onPressed: () {
            //       changePage(3);
            //       _pageController.jumpToPage(3);
            //     },
            //   ),
            // ),
          ],
        ),
      ),
      body: PageView(
        onPageChanged: changePage,
        controller: _pageController,
        children: const <Widget>[
          MyHomePage(title: 'Uptodo'),
          // CalendarPage(),
          ArchivePage(),
          // TimerPage()
        ],
      ),
    );
  }
}
