import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DBService {
  final CollectionReference taskCollection = FirebaseFirestore.instance.collection('tasks');
  var user = FirebaseAuth.instance.currentUser;

  Future getTasks() async {
    var tasks = await taskCollection.where('email', isEqualTo: user.email).get();
    var parsedTasks = tasks.docs.map( (task) {
      var val = task.data();
      val['id'] = task.id;
      return val;
    }).toList();

    return parsedTasks; 
  }

  Future createTask(String title, String description, DateTime startDate, DateTime dueDate, List<String> categories, var reminder) async {

    return taskCollection.add({
      'email': user.email,
      'title': title,
      'description': description,
      'startDate': startDate,
      'dueDate': dueDate,
      'categories': categories,
      'reminder': reminder,
    });
  }
}