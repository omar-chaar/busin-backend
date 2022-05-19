const express = require("express");
const { createServer } = require("http");
const { Server } = require("socket.io");


const app = express();
const httpServer = createServer(app);
const io = new Server(httpServer, {    
    cors: {origin: "*"} //TODO: REMOVE THIS AT FINAL BUILD
});

app.use(express.static('public'));



io.on("connection", (socket) => {
    console.log(socket + " connected");
});

/* io.on('message',(socket) =>
    
) */

httpServer.listen(3000);