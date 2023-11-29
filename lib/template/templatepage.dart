import 'package:flutter/material.dart';
import 'package:remind/events/eventpage.dart';
import 'package:remind/home/homepage.dart';
import 'package:remind/profile/profilepage.dart';
import 'package:remind/services/services.dart';
import 'package:remind/template/loadingpage.dart';
import 'package:remind/template/meetings.dart';
import 'package:remind/template/navbar.dart';
import 'package:remind/template/topbar.dart';
import 'package:remind/update/addmeetings.dart';

class TemplatePage extends StatefulWidget {
  final Service auth;
  const TemplatePage({super.key,required this.auth});

  @override
  State<TemplatePage> createState() => _TemplatePageState();
}

class _TemplatePageState extends State<TemplatePage> {
  int pageIndex = 0;
  bool needForRefresh = true;

  void dbUpate() {
    setState(() {
      needForRefresh = true;
    });
  }

  void moveToIndex(int index) {
    setState(() {
      pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MeetingData>(
        future: fetchAppointments(widget.auth),
        builder: (context, AsyncSnapshot<MeetingData> snapshot) {
          if (snapshot.connectionState != ConnectionState.done && needForRefresh) {
            return Scaffold(
              appBar: TopBar(),
              body: LoadingPage(),
              bottomNavigationBar: NavBar(
                index: pageIndex,
                update: moveToIndex,
              ),
            );
          } 
          else {
            needForRefresh = false;

            List<Widget> pages = [
              HomePage(meetingInfo: snapshot.data!),
              EventPage(meetingInfo: snapshot.data!),
              AddMeetingPage(auth : widget.auth,onUpdate: dbUpate),
              Profilepage(auth: widget.auth)
            ];

            return Scaffold(
              appBar: TopBar(),
              body: pages.elementAt(pageIndex),
              bottomNavigationBar: NavBar(
                index: pageIndex,
                update: moveToIndex,
              ),
            );
          }
        });
  }
}
