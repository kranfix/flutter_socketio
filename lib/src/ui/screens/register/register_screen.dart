import 'register_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socketio/src/colors/colors.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();

  static Future navigate(BuildContext context) {
    return Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => RegisterScreen(),
    ));
  }
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Register',
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: AppColors.grey.dark2,
      ),
      body: RegisterForm(),
    );
  }
}
