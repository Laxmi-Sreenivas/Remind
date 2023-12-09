import 'package:flutter/material.dart';
import 'package:remind/services/services.dart';

class LoginPopupControllers {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
}

extension LoginPopupContext on BuildContext {
  Future<Map<String, String>?> showEmailPopup(Service auth) async {
    LoginPopupControllers controllers = LoginPopupControllers();

    return await showDialog<Map<String, String>?>(
      context: this,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Connect Email To Account"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 16.0),
              TextField(
                controller: controllers.email,
                decoration: InputDecoration(
                  labelText: "Email",
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20.0),
              TextField(
                controller: controllers.password,
                decoration: InputDecoration(
                  labelText: "Password",
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String email = controllers.email.text;
                  String password = controllers.password.text;

                  // Perform any validation or processing here before returning
                  // the email and password
                  if (email.isNotEmpty && password.isNotEmpty) {
                    Navigator.of(context).pop({
                      'email': email,
                      'password': password,
                    });
                  } else {
                    
                  }
                },
                child: Text("Submit"),
              )
            ],
          ),
        );
      },
    );
  }
}