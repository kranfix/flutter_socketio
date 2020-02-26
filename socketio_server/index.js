const socketio = require("socket.io");
const express = require("express");
const http = require("http");

const app = express();
const server = http.createServer(app);
const io = socketio(server);
const port = process.env.PORT || 3000;

server.listen(port, () => {
  console.log("Server listening at port %d", port);
});

io.on("connection", socket => {
  socket.on("news", data => {
    console.log(data);
    socket.broadcast.emit("news", data);
  });
});
