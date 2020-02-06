import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socketio/src/colors/colors.dart';
import 'package:flutter_socketio/src/providers/providers.dart';
import 'package:flutter_socketio/src/ui/widgets/my_app_bar.dart';
import 'package:flutter_socketio/src/ui/widgets/socketio_logo.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyMessageAppBar(
        messageCounter: 0, // TODO: connect to bloc
        logo: SocketioLogo(width: 35),
        // TODO: create MessagesScreen
        //onTapMessageButton: () => MessageScreen.navigate(context),
      ),
      body: _DashboardBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.read<AuthBloc>().logout(),
        child: Icon(Icons.exit_to_app),
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Missing implementation'),
    );
  }
}
