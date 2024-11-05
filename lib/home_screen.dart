import 'package:flutter/material.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/taps/setting/setting_tap.dart';
import 'package:todo/taps/tasks/add_task_bottom_sheet.dart';
import 'package:todo/taps/tasks/task_tap.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentTapIndex = 0;
  List<Widget> taps = [
    TasksTap(),
    SettingTap(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: taps[currentTapIndex],
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: AppTheme.white,
        padding: EdgeInsets.zero,
        elevation: 0,
        notchMargin: 8,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: BottomNavigationBar(
            currentIndex: currentTapIndex,
            onTap: (index) {
              currentTapIndex = index;
              setState(() {});
            },
            items: const [
              BottomNavigationBarItem(label: 'Tasks', icon: Icon(Icons.list)),
              BottomNavigationBarItem(
                  label: 'Setting', icon: Icon(Icons.settings))
            ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (_) => AddTaskBottomSheet(),
        ),
        child: const Icon(
          Icons.add,
          size: 32,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
