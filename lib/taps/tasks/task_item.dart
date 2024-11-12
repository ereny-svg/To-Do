import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/taskmodel.dart';
import 'package:todo/taps/tasks_provider.dart';

class TaskItem extends StatelessWidget {
  TaskModel task;
  TaskItem({required this.task});
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) {
                FirebaseFunctions.deleteTaskFromFirestore(task.id)
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
        child: Container(
          padding: const EdgeInsets.all(20),
          height: 115,
          width: 352,
          decoration: BoxDecoration(
              color: AppTheme.white, borderRadius: BorderRadius.circular(15)),
          child: Row(children: [
            Container(
              height: 62,
              width: 4,
              margin: const EdgeInsetsDirectional.only(end: 25),
              decoration: BoxDecoration(
                  color: AppTheme.primaryLight,
                  borderRadius: BorderRadius.circular(10)),
            ),
            Container(
              margin: const EdgeInsets.only(top: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: theme.textTheme.titleMedium!
                        .copyWith(color: theme.primaryColor),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    task.description,
                    style: theme.textTheme.titleSmall,
                  ),
                ],
              ),
            ),
            const Spacer(),
            Container(
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
          ]),
        ),
      ),
    );
  }
}
