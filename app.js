var fs = require('fs');
var https = require('https');
var express = require('express');
var app = express();

var options = {
  key: fs.readFileSync('key.pem'),
  cert: fs.readFileSync('cert.pem')
};

var server = https.createServer(options, app);
var io = require('socket.io')(server);

server.listen(443, function() {
  console.log('server up and running at 80');
});

io.on('connection', function(socket){
  console.log('a user connected');

	socket.on('notificar', function(grupo_id){
		console.log('notify @', grupo_id);
		socket.broadcast.emit('notif', grupo_id);
	});

  socket.on('disconnect', function(){
    console.log('user disconnected');
  });
});
