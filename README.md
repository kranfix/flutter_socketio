# flutter_socketio

A simplified chat made with [Flutter](https://flutter.dev),
[Socket.io](https://) and [HiveDB](https://hivedb.dev/).

This repository container an app, a socket.io server and a emulated socket.io client.

This is not a complete functional app, only has educational pourpose.

## Before starting

Review the slides to a little introduction:

- Slides for [socket.io](https://docs.google.com/presentation/d/1dbpBkJlm-MFpKWdv6b6WG84JaejMC9al8vLSD0dEtHY/edit#slide=id.g5b9a4bdf9e_0_358)
- Slides for [HiveDB](https://docs.google.com/presentation/d/1EsGdW7NBCatXgjlPGcJjaM0Fe2lZk26Lpkf0Ti2dlOw/edit?usp=sharing)

## Getting Started

First, go to the socket.io server

```bash
cd socketio_server
npm install
# yarn
```

Then, in one terminal, run the server.

```bash
node index.js
```

And, in another terminal, run a emulated client.

```bash
node client.js
```

To finish, run the app and use the following account and navigate to chat screen:

```
username: eve.holt@reqres.in
password: cityslicka1A!
```
