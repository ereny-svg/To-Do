import 'package:flutter/material.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/taskmodel.dart';

class TasksProvider with ChangeNotifier {
  List<TaskModel> tasks = [];
 
  DateTime selectedDate = DateTime.now();
  Future<void> getTasks() async {
    tasks = await FirebaseFunctions.getAllTasksFromFirestore();
    tasks = tasks
        .where((task) =>
            task.date.year == selectedDate.year &&
            task.date.month == selectedDate.month &&
            task.date.day == selectedDate.day)
        .toList();
    notifyListeners();
  }
  Future<void> updateTask( TaskModel taskModel) async {
     await FirebaseFunctions.updateTaskToFirestore(taskModel);
    tasks = tasks
        .where((task) =>
            task.date.year == selectedDate.year &&
            task.date.month == selectedDate.month &&
            task.date.day == selectedDate.day)
        .toList();
    notifyListeners();
  }

  void ChangeDateTime(DateTime date) {
    selectedDate = date;
    notifyListeners();
  }
}
