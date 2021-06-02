import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class DBService {
  final CollectionReference taskCollection = FirebaseFirestore.instance.collection('tasks');
  final CollectionReference eventCollection = FirebaseFirestore.instance.collection('events');
  final CollectionReference quoteCollection = FirebaseFirestore.instance.collection('quotes');
  var user = FirebaseAuth.instance.currentUser;

  Future getUser() async {
    return user;
  }

  Future getTasks() async {
    var tasks = await taskCollection.where('email', isEqualTo: user!.email).get();
    var parsedTasks = tasks.docs.map( (task) {
      var val = task.data();
      val['id'] = task.id;
      return val;
    }).toList();

    return parsedTasks; 
  }

  Future createTask(String title, String description, DateTime startDate, DateTime dueDate, List<String?> categories, var reminder) async {

    return taskCollection.add({
      'email': user!.email,
      'title': title,
      'description': description,
      'startDate': startDate,
      'dueDate': dueDate,
      'categories': categories,
      'reminder': reminder,
      'done': false,
    });
  }

  Future deleteTask(taskID) async {
    return taskCollection.doc(taskID).delete();
  }

  Future markTaskDone(taskID) async {
    return taskCollection.doc(taskID).update({
      'done': true
    });
  }

  Future editTask(String taskID, String title, String description, DateTime startDate, DateTime dueDate, List<String?> categories, var reminder) async {
    return taskCollection.doc(taskID).update({
      'title': title,
      'description': description,
      'startDate': startDate,
      'dueDate': dueDate,
      'categories': categories,
      'reminder': reminder,
    });
  }

  Future getEvents() async {
    var events = await eventCollection.where('email', isEqualTo: user!.email).get();
    var parsedEvents = events.docs.map( (event) {
      var val = event.data();
      val['id'] = event.id;
      return val;
    }).toList();

    return parsedEvents; 
  }

  Future createEvent(String title, String notes, TimeOfDay startTime, TimeOfDay endTime, DateTime date, List<String?> categories, var reminder) async {
   
    DateTime startTimestamp = new DateTime(date.year, date.month, date.day, startTime.hour, startTime.minute);
    DateTime endTimestamp = new DateTime(date.year, date.month, date.day, endTime.hour, endTime.minute);

    return eventCollection.add({
      'email': user!.email,
      'title': title,
      'notes': notes,
      'startTime': startTimestamp, // Timestamp data type
      'endTime': endTimestamp,     // Timestamp data type
      'categories': categories,
      'reminder': reminder,
    });
  }

  Future deleteEvent(eventID) async {
    return eventCollection.doc(eventID).delete();
  }

  Future getQuote() async {
    var quote = await quoteCollection.doc(user!.uid).get();
    return quote;
  }

  Future editQuote(String newQuote) async {
    return quoteCollection.doc(user!.uid).set({
      'quote': newQuote,
    });
  }
}