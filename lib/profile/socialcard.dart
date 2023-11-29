import 'package:flutter/material.dart';
import 'package:remind/profile/connected.dart';
import 'package:remind/profile/disconnected.dart';
import 'package:remind/services/services.dart';

class SocialCard extends StatefulWidget {
  final String account;
  final Function authHandler;
  final Service auth;
  const SocialCard(
      {super.key, required this.account, required this.authHandler,required this.auth});

  @override
  State<SocialCard> createState() => _SocialCardState();
}

class _SocialCardState extends State<SocialCard> {
  String checkDbForAccount() {
    return widget.auth.fetchField(widget.account) ?? "";
  }

  void updateAuthState() async {
    widget.authHandler();
    setState(() {});
  }

  @override
  Widget build(context) {
    String accountName = checkDbForAccount();
    return accountName != ""
        ? Connected(
            account: widget.account,
            accountId: accountName,
          )
        : DisConnected(
            account: widget.account,
            authHandler: updateAuthState,
          );
  }
}
