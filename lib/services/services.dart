import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';

class Service {
  //Class Specific
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final CollectionReference _users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _events =
      FirebaseFirestore.instance.collection('events');

  //User Specific
  Map<String, dynamic>? userData;
  List<Appointment>? userEvents;

  //Sign UP
  Future<bool> signUpWithEmailandPassword(
      String email, String password, String username) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      User? user = credential.user;

      print("User Created");
      await _users.doc(user?.uid).set({
        'username': username,
        'email': email,
        'event': [],
        'gmail': '',
        'facebook': '',
        'date': convertDate(DateTime.now())
      });

      print('User Added to Db');

      DocumentSnapshot userDoc = await _users.doc(user?.uid).get();
      print("User Doc Fetched");

      if (userDoc.exists) {
        userData = userDoc.data() as Map<String, dynamic>;
        print("User Data Stored");
      }

      return true;
    } on FirebaseAuthException catch (e) {
      print("Fetch Error : ${e.code}");
      return false;
    }
  }

  //Log-In + Fetches User Info Entirely
  Future<bool> logInWithEmailandPassword(String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      print("User Logged In");

      User? user = credential.user;
      DocumentSnapshot userDoc = await _users.doc(user?.uid).get();
      print("User Doc Fetched");

      if (userDoc.exists) {
        userData = userDoc.data() as Map<String, dynamic>;
        print("User Data Stored");
      }

      return true;
    } on FirebaseAuthException catch (e) {
      print("Fetch Error : ${e.code}");
      return false;
    }
  }

  //Add Events to Db
  Future<void> addEvent(DateTime date, TimeOfDay startTime, TimeOfDay endTime,
      String subject) async {
    try {
      // Format date and time
      String formattedDate = convertDate(date);
      String formattedStartTime = formatTimeOfDay(startTime);
      String formattedEndTime = formatTimeOfDay(endTime);

      // Add document to collection
      DocumentReference eventRef = await _events.add({
        'date': formattedDate,
        'startTime': formattedStartTime,
        'endTime': formattedEndTime,
        'subject': subject,
      });

      String eventId = eventRef.id;
      userData!["event"].add(eventId);

      String? uid = _auth.currentUser!.uid;
      await _users.doc(uid).update({
        "event": FieldValue.arrayUnion([eventId])
      });

      print('Event added successfully');
    } catch (e) {
      print('Adding Event Error');
    }
  }

  //Fetch List of Appointment from DB
  Future<List<Appointment>?> fetchEvents() async {
    try {
      userEvents = userEvents ?? [];

      if (userEvents!.length < userData!["event"].length) {
        print("New Events Added : Returning New List");

        for (int i = userEvents!.length; i < userData!["event"].length; i++) {
          DocumentSnapshot eventDoc =
              await _events.doc(userData!["event"][i]).get();
          Map<String, dynamic> event = eventDoc.data() as Map<String, dynamic>;

          userEvents!.add(Appointment(
              startTime: parseDateTime(event["date"], event["startTime"]),
              endTime: parseDateTime(event["date"], event["endTime"]),
              subject: event["subject"],
              color: Colors.blue));
        }

        return userEvents;
      } else {
        print("No New Events Added : Returning Old List");
        return userEvents;
      }
    } catch (e) {
      print('Event Fetching Error');
      return userEvents;
    }
  }

  //Logs out + Removes User Info
  Future<void> logout() async {
    await _auth.signOut();
    userData = null;
    userEvents = null;
  }

  //Sync Data Across Devices
  Future<void> syncData() async{
      User? user = _auth.currentUser;
      DocumentSnapshot userDoc = await _users.doc(user?.uid).get();
      print("New user Doc Fetched");

      if (userDoc.exists) {
        userData = userDoc.data() as Map<String, dynamic>;
        print("User Data Updated");
      }

  }

  //Utility Function : Simple Getter
  String? fetchField(String field) {
    if (userData?.containsKey(field) == true) {
      var value = userData![field];
      if (value is String) {
        return value;
      }
    }
    return null;
  }

  //Utility Function : Format Date
  String convertDate(DateTime date) {
    String day = date.day.toString().padLeft(2, '0');
    String month = date.month.toString().padLeft(2, '0');
    String year = date.year.toString();
    return '$day-$month-$year';
  }

  //Utility Function : Format Time
  String formatTimeOfDay(TimeOfDay time) {
    String hour = time.hour.toString().padLeft(2, '0');
    String minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  //Utility Function : Reformat Date & Time
  DateTime parseDateTime(String date, String time) {
    // Parse date in the format 'dd-mm-yyyy'
    List<String> dateParts = date.split('-');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    // Parse time in the format 'hh:mm'
    List<String> timeParts = time.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    // Create and return DateTime object
    return DateTime(year, month, day, hour, minute);
  }
}
