import 'login_form.dart';
import 'package:flutter_socketio/src/ui/widgets/widgets.dart';
import 'package:flutter_socketio/src/providers/providers.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final authBloc = context.watch<AuthBloc>();
    assert(authBloc != null, "AcountBloc should be non null");
    return Scaffold(
      body: Center(
        child: LoginForm(
          initalValue: authBloc.savedAccount,
          image: SocketioLogo(),
          onLoginPressed: (u, p, r) => authBloc.login(
            email: u,
            password: p,
            shouldRememberAccount: r,
          ),
        ),
      ),
      bottomNavigationBar: Image.asset(
        'assets/temporal/banner.png',
        fit: BoxFit.fitWidth,
        width: double.infinity,
      ),
    );
  }
}
