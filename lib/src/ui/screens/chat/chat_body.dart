import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter_socketio/src/models/models.dart';
import 'package:flutter_socketio/src/providers/providers.dart';
import 'package:flutter_socketio/src/ui/widgets/widgets.dart';

class ChatBody extends StatefulWidget {
  @override
  _ChatBodyState createState() => _ChatBodyState();
}

class _ChatBodyState extends State<ChatBody> {
  List<Message> messages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ioBloc = context.read<IoBloc>();
    return Column(children: [
      Expanded(
        child: ListView(
          children: <Widget>[
            for (final m in messages)
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
        onTap: (text) => ioBloc.sendMessage(
          user: AuthBloc.user,
          message: text,
        ),
      ),
    ]);
  }
}

class Message {
  final Map<String, dynamic> _data;

  const Message._(this._data);

  User get user {
    final Map<String, dynamic> _user = _data['user'] ?? {};
    return User.fromMap({
      'id': _user['id'] ?? 0,
      'email': _user['email'],
      'first_name': _user['first_name'] ?? 'Unknown',
      'last_name': _user['last_name'] ?? _data['username'],
      'avatar': _user['avatar'] ??
          'https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.iconfinder.com%2Ficons%2F4649639%2Favatar_happy_man_people_person_user_icon&psig=AOvVaw3t8dzyXTNU54D8-deA3sDy&ust=1581108044333000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCKCF98rkvecCFQAAAAAdAAAAABAJ',
    });
  }

  String get username => _data['username'];
  String get text => _data['message'];
}
