import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/taskmodel.dart';
import 'package:todo/taps/setting/setting_provider.dart';
import 'package:todo/taps/tasks/update_task.dart';
import 'package:todo/taps/tasks_provider.dart';
import 'package:todo/widgets/isdone.dart';

class TaskItem extends StatefulWidget {
  TaskModel task;
  TaskItem({required this.task});

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    SettingProvider settingProvider = Provider.of<SettingProvider>(context);
    bool isDone = widget.task.isDone;
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                FirebaseFunctions.deleteTaskFromFirestore(widget.task.id)
                    .timeout(
                  Duration(microseconds: 100),
                  onTimeout: () =>
                      Provider.of<TasksProvider>(context, listen: false)
                          .getTasks(),
                )
                    .catchError((error) {
                  Fluttertoast.showToast(
                      msg: "Something went wrong",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.BOTTOM,
                      timeInSecForIosWeb: 5,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0);
                });
              },
              backgroundColor: AppTheme.red,
              foregroundColor: AppTheme.white,
              icon: Icons.delete,
              label: 'Delete',
            ),
          ],
        ),
        child: GestureDetector(
          onTap: () {
            Map<String, dynamic> taskData = {
              'id': widget.task.id,
              'taskTitle': widget.task.title,
              'taskDescription': widget.task.description,
              'date': widget.task.date,
            };
            Navigator.of(context)
                .pushNamed(UpdateTask.routename, arguments: taskData);
          },
          child: Container(
            padding: const EdgeInsets.all(20),
            height: 115,
            width: 352,
            decoration: BoxDecoration(
                color: settingProvider.themeMode == ThemeMode.light
                    ? AppTheme.white
                    : AppTheme.darkblue,
                borderRadius: BorderRadius.circular(15)),
            child: Row(children: [
              Container(
                height: 62,
                width: 4,
                margin: const EdgeInsetsDirectional.only(end: 25),
                decoration: BoxDecoration(
                    color: isDone == false
                        ? AppTheme.primaryLight
                        : AppTheme.green,
                    borderRadius: BorderRadius.circular(10)),
              ),
              Container(
                margin: const EdgeInsets.only(top: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      style: theme.textTheme.titleMedium!.copyWith(
                        color: isDone == false
                            ? AppTheme.primaryLight
                            : AppTheme.green,
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.task.description,
                      style: theme.textTheme.titleSmall,
                    ),
                  ],
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  isDone = !isDone;
                  FirebaseFunctions.IsDoneTaskFromFirestore(
                          widget.task.id, isDone)
                      .timeout(Duration(microseconds: 100), onTimeout: () {
                    Provider.of<TasksProvider>(context, listen: false)
                        .getTasks();
                  }).catchError((error) {
                    Fluttertoast.showToast(
                        msg: "Something went wrong",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 5,
                        backgroundColor: Colors.red,
                        textColor: Colors.white,
                        fontSize: 16.0);
                  });
                  setState(() {});
                },
                child: isDone == false
                    ? Container(
                        width: 69,
                        height: 34,
                        decoration: BoxDecoration(
                            color: theme.primaryColor,
                            borderRadius: BorderRadius.circular(10)),
                        child: const Icon(
                          Icons.check,
                          color: AppTheme.white,
                          size: 32,
                        ),
                      )
                    : IsDone(),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
