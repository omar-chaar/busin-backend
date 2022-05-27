const http = require('http')
const app = require('./main')
const port = process.env.PORT || 3001
const server = http.createServer(app)
const jwt = require('jsonwebtoken')

//socket.io 
const io = require('socket.io')(server, {
    cors: {origin : '*'}
  }); //allowing all cors for development
  
var connectedUsers = {}; 

io.on('connection', (socket) => { //add sender as a requirement for this function
 
  socket.on('token', (token) => {
    connectedUsers[token] = socket.id;
  });

  socket.on('message', (message) => {
    console.log(message);
    console.log(connectedUsers);
    Object.entries(connectedUsers).forEach(([key, value]) => {
      
      const decode = jwt.verify(key, process.env.JWT_KEY)
      const user = decode
      console.log(user)
      if(!user.userId){ //in this case a user is connected with an invalid token and will be disconnected
        io.to(value).emit('exception', {errorMessage: 'Invalid token connected, please log in again'});
        io.sockets.sockets[value].disconnect();
      } else if(user.userId == message.receiver){
        return io.to(value).emit('message', message);
      }      
    });
  });

  socket.on('disconnect', () => {
    Object.entries(connectedUsers).forEach(([key, value]) => {
      if(value === socket.id){
        delete connectedUsers[key];
      }      
    });
  });
});

server.listen(port, () => {
    console.log(`Server running on port ${port}`)
});