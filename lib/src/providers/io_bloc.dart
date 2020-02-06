part of 'providers.dart';

class IoBloc extends ChangeNotifier {
  IoBloc({String server}) {
    init(server);
  }

  Future<void> init(String server) async {
    SocketIOManager manager = SocketIOManager();
    SocketOptions options = SocketOptions(server);
    final socket = await manager.createInstance(options);
    socket.onConnect((data) {
      print('connected: $data');
      socket.emit('news', ['hola', 'chau']);
    });
    socket.on("news", (data) {
      //sample event
      print("news");
      print(data);
    });
    socket.connect();
    socket.on('new message', (data) => print(data));
    socket.on('disconnect', (_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  SocketIO socket;

  void sendMessage({User user, dynamic message}) {
    final data = <String, dynamic>{
      'username': AuthBloc.username,
      'user': user.$data,
      'message': message,
    };
    print(data);
    //socket.emit('new message', [data]);
  }
}
