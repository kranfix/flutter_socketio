import 'dart:async';

import 'package:flutter/material.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socketio/src/colors/colors.dart';
import 'package:flutter_socketio/src/models/models.dart';
import 'package:flutter_socketio/src/providers/providers.dart';
import 'package:flutter_socketio/src/services/services.dart';
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

class _DashboardBody extends StatefulWidget {
  @override
  __DashboardBodyState createState() => __DashboardBodyState();
}

class __DashboardBodyState extends State<_DashboardBody> {
  List<User> users;

  @override
  void initState() {
    // TODO: implement initState
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
          leading: Container(
            margin: const EdgeInsets.only(right: 16),
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
              border: Border.all(color: AppColors.grey.light1, width: 1),
              image: DecorationImage(
                image: NetworkImage(u.avatar),
                fit: BoxFit.fill,
              ),
            ),
          ),
          title: Text('${u.firstName} ${u.lastName}'),
          subtitle: Text('${u.email}'),
          contentPadding: const EdgeInsets.symmetric(vertical: 4),
        );
      },
    );
  }
}
