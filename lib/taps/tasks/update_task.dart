import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/models/taskmodel.dart';

import 'package:todo/taps/tasks_provider.dart';
import 'package:todo/widgets/default_elevated_button.dart';
import 'package:todo/widgets/default_text_form_field.dart';

class UpdateTask extends StatefulWidget {
  static const String routename = '/update';
  const UpdateTask({super.key});

  @override
  State<UpdateTask> createState() => _UpdateTaskState();
}

class _UpdateTaskState extends State<UpdateTask> {
  late String taskId;
  var formKey = GlobalKey<FormState>();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  DateTime selecteddate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    TasksProvider tasksProvider = Provider.of<TasksProvider>(context);
    final args=ModalRoute.of(context)?.settings.arguments as TaskModel;
    titlecontroller.text=args.title;
    descriptioncontroller.text=args.description;
    taskId=args.id;
    double height = MediaQuery.of(context).size.height;
    ThemeData theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'To Do List',
          style: theme.textTheme.bodySmall,
        ),
        centerTitle: false,
        foregroundColor: AppTheme.white,
        backgroundColor: theme.primaryColor,
      ),
      body: Stack(
        children: [
          Container(
            height: height * 0.07,
            color: theme.primaryColor,
            width: double.infinity,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Container(
              width: 365,
              height: 688,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppTheme.white,
              ),
              child: Form(
                key: formKey,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          'Edit Task',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      const SizedBox(
                        height: 52,
                      ),
                      DefaultTextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter task title';
                            }
                            return null;
                          },
                          controller: titlecontroller,
                          hinttext: 'This is title'),
                      const SizedBox(
                        height: 31,
                      ),
                      DefaultTextFormField(
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return 'Please enter task Description';
                            }
                            return null;
                          },
                          controller: descriptioncontroller,
                          hinttext: 'Task details'),
                      const SizedBox(
                        height: 31,
                      ),
                      Text(
                        'Select Date',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Center(
                          child: GestureDetector(
                              onTap: () async {
                                DateTime? datetime = await showDatePicker(
                                    initialEntryMode:
                                        DatePickerEntryMode.calendarOnly,
                                    context: context,
                                    initialDate: selecteddate,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now()
                                        .add(Duration(days: 365)));
                                if (datetime != null &&
                                    selecteddate != datetime) {
                                   selecteddate = datetime;
                                }
                              },
                              child: Text(dateFormat.format(selecteddate)))),
                      const SizedBox(
                        height: 115,
                      ),
                      DefaultElevatedButton(
                          text: 'Save Changes',
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              TaskModel task = TaskModel(
                                  id: taskId,
                                  title: titlecontroller.text,
                                  description: descriptioncontroller.text,
                                  date: selecteddate);
                              tasksProvider.updateTask(task).timeout(
                                Duration(milliseconds: 100),
                                onTimeout: () {
                                  Navigator.of(context).pop();
                                  Provider.of<TasksProvider>(context,
                                          listen: false)
                                      .getTasks();
                                  Fluttertoast.showToast(
                                      msg: "Task added successfully",
                                      toastLength: Toast.LENGTH_LONG,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 5,
                                      backgroundColor: Colors.green,
                                      textColor: Colors.white,
                                      fontSize: 16.0);
                                },
                              ).catchError((error) {
                                Fluttertoast.showToast(
                                    msg: "Something went wrong",
                                    toastLength: Toast.LENGTH_LONG,
                                    gravity: ToastGravity.BOTTOM,
                                    timeInSecForIosWeb: 5,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0);
                              });
                            }
                          })
                    ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
