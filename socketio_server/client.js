const io = require("socket.io-client");

const socket = io("http://localhost:3000/");

let counter = 0;
const topic = "news";

socket.on("connect", () => sendBroadcastNews("Connected!"));
socket.on(topic, sendBroadcastNews);
socket.on("disconnect", () => console.log("disconnected!"));

function sendBroadcastNews(data) {
  console.log(data);
  socket.emit(topic, {
    username: "frank@flutter.pe",
    message: `counter: ${++counter}`
  });
}
