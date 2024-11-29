import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo/models/taskmodel.dart';

class FirebaseFunctions {
  static CollectionReference<TaskModel> getTasksCollection() =>
      FirebaseFirestore.instance.collection('tasks').withConverter<TaskModel>(
            fromFirestore: (docSnapshot, _) =>
                TaskModel.fromJson(docSnapshot.data()!),
            toFirestore: (TaskModel, _) => TaskModel.toJson(),
          );

  static Future<void> addTaskToFirestore(TaskModel task) {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    DocumentReference<TaskModel> doc = tasksCollection.doc();
    task.id = doc.id;
    return doc.set(task);
  }

  static Future<List<TaskModel>> getAllTasksFromFirestore() async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    QuerySnapshot<TaskModel> querySnapshot = await tasksCollection.get();
    return querySnapshot.docs
        .map(
          (docSnapshot) => docSnapshot.data(),
        )
        .toList();
  }

  static Future<void> deleteTaskFromFirestore(String taskId) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    return tasksCollection.doc(taskId).delete();
  }

  static Future<void> IsDoneTaskFromFirestore(
      String taskId, bool isdone) async {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    return tasksCollection.doc(taskId).update({
      'isDone': isdone,
    });
  }

   static Future<void> updateTaskToFirestore(TaskModel task) {
    CollectionReference<TaskModel> tasksCollection = getTasksCollection();
    return tasksCollection.doc(task.id).update({
      'title': task.title,
      'description': task.description,
      'date': Timestamp.fromDate(task.date),
    });
  }
}
