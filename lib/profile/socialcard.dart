import 'package:flutter/material.dart';
import 'package:remind/profile/connected.dart';
import 'package:remind/profile/disconnected.dart';

class SocialCard extends StatefulWidget {
  final String account;
  final Function authHandler;
  const SocialCard(
      {super.key, required this.account, required this.authHandler});

  @override
  State<SocialCard> createState() => _SocialCardState();
}

class _SocialCardState extends State<SocialCard> {
  Future<String> checkDbForAccount() async {
    print("Db Call For Social Media");
    return await Future.delayed(
        Duration(seconds: 2), () => "");
  }

  void updateAuthState() async {
    widget.authHandler();
    setState(() {});
  }

  @override
  Widget build(context) {
    return FutureBuilder<String>(
        future: checkDbForAccount(),
        builder: (context, AsyncSnapshot<String> snapshot) {
          if (snapshot.hasData && snapshot.data != "") {
            return Connected(
              account: widget.account,
              accountId: snapshot.data.toString(),
            );
          } else {
            return DisConnected(
              account: widget.account,
              authHandler: updateAuthState,
            );
          }
        });
  }
}
