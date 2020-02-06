import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_socketio/src/colors/colors.dart';
import 'package:flutter_socketio/src/providers/providers.dart';
import 'package:flutter_socketio/src/ui/widgets/widgets.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    Key key,
    this.isKeyboardOpen,
    this.labelStyle,
    @required this.image,
    this.onLoginPressed,
    this.onRecoverPassword,
    this.onCreateAcccount,
    this.email = 'Email',
    this.password = 'Password',
    this.rememberAccount = 'Remember account',
    this.loginText = "Login",
    this.initalValue,
  })  : assert(email != null),
        assert(password != null),
        assert(rememberAccount != null),
        assert(loginText != null),
        super(key: key);

  final bool isKeyboardOpen;
  final TextStyle labelStyle;
  final String email;
  final String password;
  final String rememberAccount;
  final String loginText;
  final Widget image;
  final FutureOr<void> Function(
    String username,
    String password,
    bool shouldRememberAccount,
  ) onLoginPressed;
  final VoidCallback onRecoverPassword;
  final VoidCallback onCreateAcccount;

  final AccountData initalValue;

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  TextEditingController _emailController;
  TextEditingController _passController;

  bool shouldRememberAccount;

  String get username => _emailController.text.trim();

  bool get isDataValid =>
      username.isNotEmpty && _passController.text.isNotEmpty;

  TextStyle get labelStyle =>
      widget.labelStyle ??
      TextStyle(color: AppColors.grey.light2, fontSize: 14);

  @override
  void initState() {
    super.initState();
    shouldRememberAccount = widget.initalValue != null;
    _emailController = TextEditingController(text: widget.initalValue?.email)
      ..addListener(_refresh);
    _passController = TextEditingController(text: widget.initalValue?.password)
      ..addListener(_refresh);
  }

  void _refresh() => setState(() {});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(width: 150, height: 55, child: widget.image),
          SizedBox(height: 20),
          TextField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: widget.email,
              labelStyle: widget.labelStyle,
            ),
          ),
          SizedBox(height: 20),
          TextField(
            controller: _passController,
            decoration: InputDecoration(
              labelText: widget.password,
              labelStyle: widget.labelStyle,
            ),
          ),
          SizedBox(height: 20),
          StatefulBuilder(
            builder: (_, checkboxSetState) => CustomCheckBox(
              value: shouldRememberAccount,
              text: Text(widget.rememberAccount),
              onChanged: (newValue) =>
                  checkboxSetState(() => shouldRememberAccount = newValue),
            ),
          ),
          SizedBox(height: 20),
          LargeButton(
            text: "Ingresar",
            onPressed: isDataValid && widget.onLoginPressed != null
                ? () => widget.onLoginPressed(
                      username,
                      _passController.text,
                      shouldRememberAccount,
                    )
                : null,
          ),
        ],
      ),
    );
  }
}
