class Enviroment {
  final String server;
  final String chatServer;
  const Enviroment({
    this.server,
    this.chatServer,
  });
}

final env = Enviroment(
  server: "https://reqres.in",
  chatServer: "https://socket-io-chat.now.sh/",
);
