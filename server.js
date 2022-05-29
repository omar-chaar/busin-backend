const http = require('http')
const app = require('./main')
const port = process.env.PORT || 3001
const server = http.createServer(app)
const jwt = require('jsonwebtoken')

//socket.io 
const io = require('socket.io')(server, {
    cors: {origin : '*'}
  }); //allowing all cors for development

io.on('connection', (socket) => {
  socket.on('token', (token) => {
    const user = jwt.verify(token, process.env.JWT_KEY)
    let room = ''
    socket.on('private-connection', (otherUserId) => {    
      if(otherUserId){
        let ids = [user.userId, otherUserId]
        ids.sort();
        room = ids.join('-');
        socket.join(room);
        console.log(`${user.userId} is now connected in room ${room}`);
      } else {
        socket.disconnect();
      }
      socket.on('message', (message) => {
        
        console.log("Private message received" + message.message + " " + room + " " + socket.id);

        io.to(room).emit('message', message);
      });
      socket.on('disconnect', (reason) => {
        socket.leave(room);
        return console.log("Id: "+ socket.id + " disconnected for the reason: " + reason + " from the private room: " + room);
      });  
    })
  });

  socket.on('group-connection', (room) => {
    console.log("User connected to group: " + room);
    socket.join(room);
  
    socket.on('group-message', (message) => {
      console.log("Message received" + message.message + " " + room + " " + socket.id);

      io.to(room).emit('group-message', message);
    });
  
    socket.on('group-disconnect', (reason) => {
      socket.leave(room);
      return console.log("Id: "+ socket.id + " disconnected for the reason: " + reason + " from the room: " + room);
    });  
   
  });
});

server.listen(port, () => {
    console.log(`Server running on port ${port}`)
});