import 'package:flutter/material.dart';
import 'package:flutter_socketio/src/colors/colors.dart';
import 'package:flutter_socketio/src/ui/widgets/widgets.dart';
import 'package:flutter_socketio/src/utils/extensions/email_verifier_x.dart';
import 'package:flutter_socketio/src/utils/extensions/password_verifier_x.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _repeatPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _firstNameController,
                  decoration: _registerInputDecoration('First name'),
                ),
              ),
              SizedBox(width: 20),
              Expanded(
                child: TextField(
                  controller: _lastNameController,
                  decoration: _registerInputDecoration('Last name'),
                ),
              )
            ],
          ),
          SizedBox(width: 20),
          TextField(
            controller: _emailController,
            decoration: _registerInputDecoration('Email'),
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _passwordController,
            decoration: _registerInputDecoration('Password'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          TextFormField(
            controller: _repeatPasswordController,
            decoration: _registerInputDecoration('Repeat password'),
            obscureText: true,
          ),
          SizedBox(height: 20),
          LargeButton(
            color: AppColors.orange,
            text: 'Registrar',
            textColor: Colors.white,
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  InputDecoration _registerInputDecoration(String hintText) {
    return InputDecoration(
      labelText: hintText,
      labelStyle: TextStyle(
        color: AppColors.grey.light1,
        fontSize: 12.0,
      ),
    );
  }
}
