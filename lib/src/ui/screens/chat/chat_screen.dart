import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socketio/src/colors/colors.dart';
import 'package:flutter_socketio/src/providers/providers.dart';
import 'package:flutter_socketio/src/ui/screens/chat/chat_body.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();

  static Future navigate(BuildContext context) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => ChangeNotifierProvider.value(
            value: context.watch<IoBloc>(),
            child: ChatScreen(),
          ),
        ),
      );
}

class _ChatScreenState extends State<ChatScreen> {
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
        title: Text('Chat',
            style: TextStyle(
              color: Colors.white,
            )),
        centerTitle: true,
        backgroundColor: AppColors.grey.dark2,
      ),
      body: ChatBody(),
    );
  }
}
