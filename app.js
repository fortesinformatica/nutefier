var http = require('http').Server(),
		io = require('socket.io')(http);

http.listen(9999, function(){
	console.log("Server configured for: " + (global.process.env.NODE_ENV || 'development') + " environment.");
	console.log("Server running on :9999");
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