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
  chatServer: "http://127.0.0.1:3000/",
);
