import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/taskmodel.dart';
import 'package:todo/taps/tasks/task_item.dart';
import 'package:todo/taps/tasks_provider.dart';

class TasksTap extends StatefulWidget {
  @override
  State<TasksTap> createState() => _TasksTapState();
}

class _TasksTapState extends State<TasksTap> {
  bool shouldGetTasks = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    ThemeData theme = Theme.of(context);
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    if (shouldGetTasks) {
      tasksProvider.getTasks();
      shouldGetTasks = false;
    }
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: height * 0.16,
              color: theme.primaryColor,
              width: double.infinity,
            ),
            PositionedDirectional(
                start: width * 0.1,
                child: SafeArea(
                  child: Text(
                    'To Do List',
                    style: theme.textTheme.bodySmall,
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: height * 0.114),
              child: EasyInfiniteDateTimeLine(
                onDateChange: (selectedDate) {
                  tasksProvider.ChangeDateTime(selectedDate);
                  tasksProvider.getTasks();
                },
                showTimelineHeader: false,
                firstDate: DateTime.now().subtract(Duration(days: 365)),
                focusDate: tasksProvider.selectedDate,
                lastDate: DateTime.now().add(const Duration(days: 365)),
                dayProps: EasyDayProps(
                    height: 79,
                    width: 58,
                    dayStructure: DayStructure.dayStrDayNum,
                    activeDayStyle: DayStyle(
                        decoration: BoxDecoration(
                            color: AppTheme.white,
                            borderRadius: BorderRadius.circular(5)),
                        monthStrStyle: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        dayNumStyle: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        dayStrStyle: TextStyle(
                            color: theme.primaryColor,
                            fontSize: 15,
                            fontWeight: FontWeight.bold),
                        borderRadius: 5),
                    inactiveDayStyle: DayStyle(
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(5)),
                      dayNumStyle: TextStyle(
                          color: AppTheme.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      dayStrStyle: TextStyle(
                          color: AppTheme.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                    todayStyle: DayStyle(
                      decoration: BoxDecoration(
                          color: AppTheme.white,
                          borderRadius: BorderRadius.circular(5)),
                      dayNumStyle: TextStyle(
                          color: AppTheme.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                      dayStrStyle: TextStyle(
                          color: AppTheme.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            ),
          ],
        ),
        Expanded(
          child: ListView.builder(
            itemBuilder: (_, index) => TaskItem(
              task: tasksProvider.tasks[index],
            ),
            itemCount: tasksProvider.tasks.length,
          ),
        ),
      ],
    );
  }
}
