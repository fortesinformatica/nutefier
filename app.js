var http = require('http').Server(),
		https = require('https'),
		fs = require('fs'),
		io = require('socket.io')(http);

http.listen(80, function(){
	console.log("Server configured for: " + (global.process.env.NODE_ENV || 'development') + " environment.");
	console.log("Server running on :80");
  console.log(new Date);
});

var options = {
  key: fs.readFileSync('key.pem'),
  cert: fs.readFileSync('cert.pem')
};

https.createServer(options, app).listen(443, function(){
	console.log("Server running on 443");
  console.log(new Date);
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
