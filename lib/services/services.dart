import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

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
        'google': '',
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
  Future<void> syncData() async {
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

  //Google Auth Login Implementation : If email = gmail -> automatically linked
  Future<bool> googleAuth() async {
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser =
          await GoogleSignIn(forceCodeForRefreshToken: true).signIn();

      // User canceled the sign-in process
      if (googleUser == null) {
        return false;
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential authResult = await _auth.signInWithCredential(credential);
      User? user = authResult.user;

      DocumentSnapshot userDoc = await _users.doc(user?.uid).get();

      String gmail = googleUser.email;
      String username = user!.displayName ?? "";

      if (userDoc.exists) {
        print('User Already Exist : Updating Only Gmail');
        await _users.doc(user.uid).update({
          'google': gmail,
        });
      } else {
        await _users.doc(user.uid).set({
          'username': username,
          'email': "",
          'event': [],
          'google': gmail,
          'facebook': '',
          'date': convertDate(DateTime.now()),
        });
        print('User Added to Db');
      }

      DocumentSnapshot newUserDoc = await _users.doc(user.uid).get();
      print("User Doc Fetched");

      if (newUserDoc.exists) {
        userData = newUserDoc.data() as Map<String, dynamic>;
        print("User Data Stored");
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //Linking Google Account to Already Existing Account
  Future<void> linkAccountWithGoogle() async {
    try {
      await GoogleSignIn().signOut();
      // Sign in with Google
      GoogleSignInAccount? googleSignInAccount =
          await GoogleSignIn(forceCodeForRefreshToken: true).signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount!.authentication;
      AuthCredential googleCredential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      print("Fetched Credentiatls");

      // Get the current user
      User? user = _auth.currentUser;
      await user?.linkWithCredential(googleCredential);

      //Modyfing fields
      await _users.doc(user?.uid).update({
        'google': googleSignInAccount.email,
      });

      userData!["google"] = googleSignInAccount.email;

      print('Account linked with Google successfully!');
    } catch (e) {
      print('Error linking account with Google: $e');
    }
  }

  //Facebook Auth Login Implementation
  Future<bool> facebookAuth() async {
    try {
      await FacebookAuth.instance.logOut();
      final LoginResult result = await FacebookAuth.instance.login();

      // User canceled the sign-in process
      if (result.status == LoginStatus.cancelled) {
        return false;
      }

      final AccessToken accessToken = result.accessToken!;
      final AuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);

      UserCredential authResult = await _auth.signInWithCredential(credential);
      User? user = authResult.user;

      DocumentSnapshot userDoc = await _users.doc(user?.uid).get();

      //Get The Email & Name
      final graphResponse = await http.get(
        Uri.parse('https://graph.facebook.com/v14.0/me?fields=id,name,email'),
        headers: {'Authorization': 'Bearer ${accessToken.token}'},
      );
      final Map<String, dynamic> facebookUserData =
          json.decode(graphResponse.body);
      String facebookEmail = facebookUserData['email'];
      String facebookUsername = facebookUserData["name"];

      if (userDoc.exists) {
        print('User Already Exists: Updating Only Facebook Email');
        await _users.doc(user!.uid).update({
          'facebook': facebookEmail,
        });
      } else {
        await _users.doc(user!.uid).set({
          'username': facebookUsername,
          'email': "",
          'event': [],
          'google': '',
          'facebook': facebookEmail,
          'date': convertDate(DateTime.now()),
        });
        print('User Added to Db');
      }

      DocumentSnapshot newUserDoc = await _users.doc(user.uid).get();
      print("User Doc Fetched");

      if (newUserDoc.exists) {
        userData = newUserDoc.data() as Map<String, dynamic>;
        print("User Data Stored");
      }

      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  //Linking Facebook Account to Already Existing Account
  Future<void> linkAccountWithFacebook() async {
    try {
      await FacebookAuth.instance.logOut();
      final LoginResult result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.cancelled) {
        print('Facebook sign-in canceled.');
        return;
      }

      final AccessToken accessToken = result.accessToken!;
      final AuthCredential facebookCredential =
          FacebookAuthProvider.credential(accessToken.token);

      print("Fetched Credentials");

      // Get the current user
      User? user = _auth.currentUser;
      await user?.linkWithCredential(facebookCredential);

      //Get The Gmail
      final graphResponse = await http.get(
        Uri.parse('https://graph.facebook.com/v14.0/me?fields=id,name,email'),
        headers: {'Authorization': 'Bearer ${accessToken.token}'},
      );
      final Map<String, dynamic> facebookUserData =
          json.decode(graphResponse.body);
      String facebookEmail = facebookUserData['email'] ?? '';

      // Modify fields
      await _users.doc(user?.uid).update({
        'facebook': facebookEmail,
      });

      userData!["facebook"] = facebookEmail;

      print('Account linked with Facebook successfully!');
    } catch (e) {
      print('Error linking account with Facebook: $e');
    }
  }

  //Linking Oauth Accounts with Email & Password
  Future<void> linkAccountWithEmailPassword(String email, String password) async {
    try {
      User? user = _auth.currentUser;

      // Generate credentials with email and password
      AuthCredential emailCredential = EmailAuthProvider.credential(
        email: email,
        password: password,
      );

      await user?.linkWithCredential(emailCredential);
      await _users.doc(user?.uid).update({
        'email': email,
      });

      userData!["email"] = email;
      
      print('Account linked with email and password successfully!');
    } catch (e) {
      print('Error linking account with email and password: $e');
    }
  }
}
