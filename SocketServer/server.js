const app = require('express')();
const server = require('http').createServer(app);
const io = require('socket.io')(server);


io.on('connection', () => {
    //console log with socket id
    console.log(socket.id + ' user connected');
    /* … */ });

server.listen(3000);