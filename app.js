var express = require('express');
var https = require('https');
var http = require('http');
var fs = require('fs');
var io = require('socket.io')(http.Server());
// This line is from the Node.js HTTPS documentation.
var options = {
  key: fs.readFileSync('key.pem'),
  cert: fs.readFileSync('cert.pem')
};

// var port = 9999;
//
// if (global.process.env.NODE_ENV != 'production'){
// 	port = 9998;
// }

// Create a service (the app object is just a callback).
var app = express();

app.get('/', function (req, res) {
  res.send('NUTEfier on air');
});

// Create an HTTP service.
http.createServer(app).listen(80, function(){
	console.log("Server running on 80");
  console.log(new Date);
});
// Create an HTTPS service identical to the HTTP service.
https.createServer(options, app).listen(443, function(){
	console.log("Server running on 443");
  console.log(new Date);
});

io.on('connection', function(socket){
  console.log('a user connected');

	socket.on('notificar', function(grupo_id){
		console.log('notify @', grupo_id);
		socket.broadcast.emit('novidade', grupo_id);
	});

  socket.on('disconnect', function(){
    console.log('user disconnected');
  });
});
