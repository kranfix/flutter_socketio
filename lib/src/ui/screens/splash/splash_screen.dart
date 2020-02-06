import 'dart:async';

import '../login/login_screen.dart';
import '../dashboard/dashboard_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_socketio/src/providers/providers.dart';
import 'package:flutter_socketio/src/ui/widgets/socketio_logo.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> initFuture() async {
    final authBloc = context.read<AuthBloc>();
    await Future.wait<void>([
      authBloc.validateToken(),
      Future.delayed(Duration(seconds: 1, milliseconds: 500)),
    ]);
    await SplashRoot.navigate(context);
  }

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(initFuture);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SocketioLogo(width: 150),
      ),
    );
  }
}

class SplashRoot extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    if (authBloc.status == AuthStatus.loggedIn) {
      return DashboardScreen();
    }
    return LoginScreen();
  }

  static Future navigate(BuildContext context) {
    return Navigator.of(context).pushReplacement(MaterialPageRoute(
      builder: (_) => SplashRoot(),
    ));
  }
}
