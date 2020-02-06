import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_socketio/src/colors/colors.dart';
import 'package:flutter_socketio/src/models/models.dart';
import 'package:flutter_socketio/src/providers/providers.dart';
import 'package:flutter_socketio/src/services/services.dart';
import 'package:flutter_socketio/src/ui/widgets/my_app_bar.dart';
import 'package:flutter_socketio/src/ui/widgets/socketio_logo.dart';
import 'package:fab_circular_menu/fab_circular_menu.dart';

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
      body: FabCircularMenu(
        ringColor: AppColors.orange.withOpacity(0.5),
        options: <Widget>[
          IconButton(
            tooltip: 'Logout',
            icon: Icon(Icons.exit_to_app),
            onPressed: () => context.read<AuthBloc>().logout(),
          ),
        ],
        child: _DashboardBody(),
      ),
    );
  }
}

class _DashboardBody extends StatefulWidget {
  @override
  __DashboardBodyState createState() => __DashboardBodyState();
}

class __DashboardBodyState extends State<_DashboardBody> {
  List<User> users;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(initFuture);
  }

  Future<void> initFuture() async {
    users ??= [];
    try {
      final userListData = await Services.user.fetchMany();
      users.addAll(userListData.users);
    } catch (e) {}
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (users == null) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    if (users.isEmpty) {
      return Center(
        child: Text("There's no available users"),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: users.length,
      itemBuilder: (_, index) {
        final u = users[index];
        return ListTile(
          leading: CircleAvatar(
            radius: 28,
            backgroundImage: NetworkImage(u.avatar),
          ),
          title: Text('${u.firstName} ${u.lastName}'),
          subtitle: Text('${u.email}'),
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
        );
      },
    );
  }
}
