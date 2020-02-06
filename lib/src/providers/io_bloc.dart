part of 'providers.dart';

class IoBloc extends ChangeNotifier {
  factory IoBloc({String server}) {
    IO.Socket socket = IO.io(server);
    socket.on('connect', (_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    socket.on('event', (data) => print(data));
    socket.on('disconnect', (_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
    return IoBloc._(socket);
  }

  IoBloc._(this.socket);

  final IO.Socket socket;

  void sendMessage({String event, dynamic data}) {
    socket.emit(event, 'test');
  }
}
