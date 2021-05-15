import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DBService {
  final CollectionReference taskCollection = FirebaseFirestore.instance.collection('tasks');
  final CollectionReference eventCollection = FirebaseFirestore.instance.collection('events');
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

  Future getEvents() async {
    var events = await eventCollection.where('email', isEqualTo: user.email).get();
    var parsedEvents = events.docs.map( (event) {
      var val = event.data();
      val['id'] = event.id;
      return val;
    }).toList();

    return parsedEvents; 
  }

  Future createEvent(String title, String notes, TimeOfDay startTime, TimeOfDay endTime, DateTime date, List<String> categories, var reminder) async {
   
    DateTime startTimestamp = new DateTime(date.year, date.month, date.day, startTime.hour, startTime.minute);
    DateTime endTimestamp = new DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute);

    return eventCollection.add({
      'email': user.email,
      'title': title,
      'notes': notes,
      'startTime': startTimestamp, // Timestamp data type
      'endTime': endTimestamp,     // Timestamp data type
      'categories': categories,
      'reminder': reminder,
    });
  }
}