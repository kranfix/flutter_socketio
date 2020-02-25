import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socketio/src/providers/providers.dart';
import 'package:flutter_socketio/src/ui/widgets/widgets.dart';

class ChatBody extends StatefulWidget {
  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ioBloc = context.watch<IoBloc>();

    return Column(children: [
      if (ioBloc.messages == null || ioBloc.messages.isEmpty)
        Expanded(
          child: Center(
            child: Text('Waiting for messages..'),
          ),
        )
      else
        Expanded(
          child: ListView(
            children: <Widget>[
              for (final m in ioBloc.messages)
                Bubble(
                  nip: m.username == AuthBloc.username
                      ? BubbleNip.rightBottom
                      : BubbleNip.leftBottom,
                  child: ListTile(
                    leading: m.username != AuthBloc.username
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(m.user.avatar),
                            radius: 10,
                          )
                        : null,
                    title: Text(m.username),
                    subtitle: Text(m.text),
                    trailing: m.username == AuthBloc.username
                        ? CircleAvatar(
                            backgroundImage: NetworkImage(m.user.avatar),
                            radius: 10,
                          )
                        : null,
                  ),
                )
            ],
          ),
        ),
      InputBox(
        imgUrl: AuthBloc.user.avatar,
        onTap: (text) => ioBloc.sendMessage(message: text),
      ),
    ]);
  }
}
