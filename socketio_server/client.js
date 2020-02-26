const io = require("socket.io-client");

const socket = io("http://localhost:3000/");

let counter = 0;
const topic = "news";

socket.on("connect", function() {
  console.log("Connected!");
  socket.emit(topic, {
    username: "frank@flutter.pe",
    //user: {
    //  id: 0,
    //  email: 'frank@flutter.pe',
    //  first_name: "Frank",
    //  last_name: 'Moreno',
    //  String get avatar => _data['avatar'];
    //}
    message: `counter: ${++counter}`
  });
});

socket.on(topic, function(data) {
  console.log(data);
  socket.emit(topic, {
    username: "frank@flutter.pe",
    //user: {
    //  id: 0,
    //  email: 'frank@flutter.pe',
    //  first_name: "Frank",
    //  last_name: 'Moreno',
    //  String get avatar => _data['avatar'];
    //}
    message: `counter: ${++counter}`
  });
});
socket.on("disconnect", () => console.log("disconnected!"));
