import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:todo/app_theme.dart';
import 'package:todo/firebase_functions.dart';
import 'package:todo/models/taskmodel.dart';
import 'package:todo/taps/tasks_provider.dart';
import 'package:todo/widgets/default_elevated_button.dart';
import 'package:todo/widgets/default_text_form_field.dart';
import 'package:intl/intl.dart';

class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var formKey = GlobalKey<FormState>();
  TextEditingController titlecontroller = TextEditingController();
  TextEditingController descriptioncontroller = TextEditingController();
  DateTime selecteddate = DateTime.now();
  DateFormat dateFormat = DateFormat('dd/MM/yyyy');
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        height: height * 0.5,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: AppTheme.white,
        ),
        child: Form(
          key: formKey,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Center(
              child: Text(
                'Add New Task',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            DefaultTextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter task title';
                  }
                  return null;
                },
                controller: titlecontroller,
                hinttext: 'Enter Task Title'),
            const SizedBox(
              height: 16,
            ),
            DefaultTextFormField(
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter task Description';
                  }
                  return null;
                },
                controller: descriptioncontroller,
                hinttext: 'Enter Task Description'),
            const SizedBox(
              height: 16,
            ),
            Center(
              child: Text(
                'Select Date',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            const SizedBox(
              height: 16,
            ),
            Center(
                child: GestureDetector(
                    onTap: () async {
                      DateTime? datetime = await showDatePicker(
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          context: context,
                          initialDate: selecteddate,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(Duration(days: 365)));
                      if (datetime != null && selecteddate != datetime) {
                        selecteddate = datetime;
                        setState(() {});
                      }
                    },
                    child: Text(dateFormat.format(selecteddate)))),
            const SizedBox(
              height: 32,
            ),
            DefaultElevatedButton(
                text: 'Add',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    AddTask();
                  }
                })
          ]),
        ),
      ),
    );
  }

  void AddTask() {
    TaskModel task = TaskModel(
        title: titlecontroller.text,
        description: descriptioncontroller.text,
        date: selecteddate);
    FirebaseFunctions.addTaskToFirestore(task).timeout(
      Duration(milliseconds: 100),
      onTimeout: () {
        Navigator.of(context).pop();
        Provider.of<TasksProvider>(context, listen: false).getTasks();
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
}
